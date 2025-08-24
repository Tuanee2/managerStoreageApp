PRAGMA foreign_keys = ON;

-- =============================
-- Schema (SQLite)
-- =============================

CREATE TABLE IF NOT EXISTS products (
    product_id   TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    cost         REAL NOT NULL,
    unit         TEXT NOT NULL,
    is_value     INTEGER NOT NULL,
    description  TEXT
);

CREATE TABLE IF NOT EXISTS product_batches (
    id           TEXT PRIMARY KEY,
    product_name TEXT NOT NULL,
    quantity     INTEGER NOT NULL,
    cost         REAL NOT NULL,
    import_date  TEXT NOT NULL,
    expiry_date  TEXT NOT NULL,
    FOREIGN KEY(product_name) REFERENCES products(product_name)
);

CREATE TABLE IF NOT EXISTS customers (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    name          TEXT NOT NULL,
    phone_number  TEXT NOT NULL,
    gender        TEXT NOT NULL,
    year_of_birth INTEGER NOT NULL,
    reward_points INTEGER NOT NULL DEFAULT 0,
    rank          TEXT NOT NULL,
    debt_points   INTEGER NOT NULL DEFAULT 0,
    debt          TEXT NOT NULL,
    debt_cents    INTEGER NOT NULL DEFAULT 0
);

-- Tối thiểu dùng phone_number để liên kết (nên migrate sang customer_id sau)
CREATE UNIQUE INDEX IF NOT EXISTS idx_customers_phone ON customers(phone_number);

CREATE TABLE IF NOT EXISTS orders (
    id           TEXT PRIMARY KEY,
    customer_name TEXT NOT NULL,
    phone_number  TEXT NOT NULL,
    export_date   TEXT NOT NULL,
    data          TEXT NOT NULL,
    debt          TEXT NOT NULL,
    notes         TEXT,
    total_cents   INTEGER NOT NULL DEFAULT 0,
    paid_cents    INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_orders_phone_date  ON orders(phone_number, export_date);
CREATE INDEX IF NOT EXISTS idx_products_name      ON products(product_name);
CREATE INDEX IF NOT EXISTS idx_batches_product    ON product_batches(product_name);
CREATE INDEX IF NOT EXISTS idx_batches_expiry     ON product_batches(expiry_date);

-- =============================
-- Triggers đảm bảo toàn vẹn nợ khách hàng
-- =============================

-- 1) Khi tạo đơn mới, cộng nợ = (total_cents - paid_cents)
CREATE TRIGGER IF NOT EXISTS trg_orders_insert_increase_customer_debt
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
  UPDATE customers
  SET debt_cents = MAX(0, debt_cents + (NEW.total_cents - NEW.paid_cents))
  WHERE phone_number = NEW.phone_number;
END;

-- 2) Chặn overpay: paid_cents không được vượt total_cents
CREATE TRIGGER IF NOT EXISTS trg_orders_paid_guard
BEFORE UPDATE OF paid_cents ON orders
FOR EACH ROW
BEGIN
  SELECT CASE WHEN NEW.paid_cents > NEW.total_cents
    THEN RAISE(ABORT, 'paid_cents cannot exceed total_cents')
  END;
END;

-- 3) Khi tăng/giảm tiền đã trả, tự động điều chỉnh nợ khách theo phần chênh lệch
CREATE TRIGGER IF NOT EXISTS trg_orders_paid_update_customer_debt
AFTER UPDATE OF paid_cents ON orders
FOR EACH ROW
WHEN NEW.paid_cents <> OLD.paid_cents
BEGIN
  UPDATE customers
  SET debt_cents = MAX(0, debt_cents - (NEW.paid_cents - OLD.paid_cents))
  WHERE phone_number = NEW.phone_number;
END;

-- 4) Khi xoá đơn hàng thì tiền nợ khách hàng sẽ đk điều chỉnh giảm
CREATE TRIGGER IF NOT EXISTS trg_orders_delete_reduce_customer_debt
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
  UPDATE customers
  SET debt_cents = MAX(0, debt_cents - (OLD.total_cents - OLD.paid_cents))
  WHERE phone_number = OLD.phone_number;
END;

-- 5) Cập nhật số điện thoại 
CREATE TRIGGER IF NOT EXISTS trg_customers_phone_propagate
AFTER UPDATE OF phone_number ON customers
FOR EACH ROW
BEGIN
  UPDATE orders
  SET phone_number = NEW.phone_number
  WHERE phone_number = OLD.phone_number;
END;