#include "databasemanager.h"
#include <QDir>

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject{parent}
{}

bool DatabaseManager::initialize(){
    QString dbPath = "database.db";
    bool isFirstTime = !QFile::exists(dbPath);

    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbPath);

    if (!db.open()) {
        qWarning() << "Cannot open database:" << db.lastError().text();
        return false;
    }

    if (isFirstTime) {
        QSqlQuery query;
        QString createProductsTableQuery =
            "CREATE TABLE IF NOT EXISTS products ("
            "product_id TEXT PRIMARY KEY,"
            "product_name TEXT NOT NULL,"
            "cost REAL NOT NULL,"
            "is_value INTEGER NOT NULL,"
            "description TEXT"
            ")";

        if (!query.exec(createProductsTableQuery)) {
            qWarning() << "Failed to create products table:" << query.lastError().text();
            return false;
        }

        QString createBatchesTableQuery =
            "CREATE TABLE IF NOT EXISTS product_batches ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "product_name TEXT NOT NULL,"
            "quantity INTEGER NOT NULL,"
            "cost REAL NOT NULL,"
            "import_date TEXT NOT NULL,"
            "expiry_date TEXT NOT NULL,"
            "FOREIGN KEY(product_name) REFERENCES products(product_name))";

        if (!query.exec(createBatchesTableQuery)) {
            qWarning() << "Failed to create product_batches table:" << query.lastError().text();
            return false;
        }

        QString createCustomersTableQuery =
            "CREATE TABLE IF NOT EXISTS customers ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "name TEXT NOT NULL,"
            "phone_number TEXT NOT NULL,"
            "gender TEXT NOT NULL,"
            "year_of_birth INTEGER NOT NULL"
            ")";

        if (!query.exec(createCustomersTableQuery)) {
            qWarning() << "Failed to create customers table:" << query.lastError().text();
            return false;
        }

    }
    qDebug() << "Database file is located at:" << QDir::current().absoluteFilePath("database.db");
    return true;
}

bool DatabaseManager::insertProduct(const Products& product) {
    QSqlQuery query;
    query.prepare("INSERT INTO products (product_id, product_name, cost, is_value, description) "
                  "VALUES (?, ?, ?, ?, ?)");
    query.addBindValue(product.getProductId());
    query.addBindValue(product.getProductName());
    query.addBindValue(product.getCost());
    query.addBindValue(product.getIsValue() ? 1 : 0);
    query.addBindValue(product.getDescription());

    if (!query.exec()) {
        qWarning() << "Failed to insert product:" << query.lastError().text();
        return false;
    }
    
    return true;
}

bool DatabaseManager::checkProductNameExists(const QString& name) {
    QSqlQuery query;
    query.prepare("SELECT EXISTS (SELECT 1 FROM products WHERE product_name = :name LIMIT 1)");
    query.bindValue(":name", name);

    if (query.exec() && query.next()) {
        return query.value(0).toBool();
    }

    return false; // nếu có lỗi
}

bool DatabaseManager::addBatch(const QString& productName, const Batch& batch) {
    QSqlQuery query;
    query.prepare("INSERT INTO product_batches (product_name, quantity, cost, import_date, expiry_date) "
                  "VALUES (?, ?, ?, ?, ?)");
    query.addBindValue(productName);
    query.addBindValue(batch.getQuantity());
    query.addBindValue(batch.getCost());
    query.addBindValue(batch.getImportDate().toString("dd-MM-yyyy"));
    query.addBindValue(batch.getExpiryDate().toString("dd-MM-yyyy"));

    if (!query.exec()) {
        qWarning() << "❌ Lỗi khi thêm lô hàng:" << query.lastError().text();
        return false;
    }

    return true;
}

// ****< xoá sản phẩm >****
bool DatabaseManager::deleteProduct(const QString& pro){
    QSqlQuery query;
    query.prepare("DELETE FROM products WHERE product_name = ?");
    query.addBindValue(pro);

    if (!query.exec()) {
        qWarning() << "Failed to delete product:" << query.lastError().text();
        return false;
    }

    return true;
}

// ****************************************

// ****< Lấy danh sách sản phẩm >****
QList<Products*> DatabaseManager::getProductsByPage(int numPage) {
    QList<Products*> list;
    QSqlQuery query;
    int limit = 12;
    int offset = numPage * limit;

    query.prepare("SELECT product_id, product_name, cost, is_value, description FROM products "
                  "LIMIT :limit OFFSET :offset");
    query.bindValue(":limit", limit);
    query.bindValue(":offset", offset);

    if (!query.exec()) {
        qWarning() << "Failed to fetch products by page:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Products* p = new Products();
        p->setProductId(query.value(0).toString());
        p->setProductName(query.value(1).toString());
        p->setCost(query.value(2).toDouble());
        p->setIsValue(query.value(3).toBool());
        p->setDescription(query.value(4).toString());
        list.append(p);
    }

    return list;
}

QList<Products*> DatabaseManager::getProductListByName(const QString& keyword){
    QList<Products*> list;
    QSqlQuery query;
    int limit = 6;

    // Dùng số trực tiếp trong LIMIT (SQLite không hỗ trợ bind LIMIT/OFFSET).
    QString sql = QString("SELECT product_id, product_name, cost, is_value, description "
                          "FROM products WHERE product_name LIKE :keyword LIMIT %1").arg(limit);
    query.prepare(sql);
    query.bindValue(":keyword", "%" + keyword + "%");

    if (!query.exec()) {
        qWarning() << "Failed to search products by name:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Products* p = new Products();
        p->setProductId(query.value(0).toString());
        p->setProductName(query.value(1).toString());
        p->setCost(query.value(2).toDouble());
        p->setIsValue(query.value(3).toBool());
        p->setDescription(query.value(4).toString());
        list.append(p);
    }

    return list;
}

QList<Products*> DatabaseManager::getAProductByName(const QString& keyword){
    QList<Products*> list;
    QSqlQuery query;
    int limit = 1;

    // Dùng số trực tiếp trong LIMIT (SQLite không hỗ trợ bind LIMIT/OFFSET).
    QString sql = QString("SELECT product_id, product_name, cost, is_value, description "
                          "FROM products WHERE product_name LIKE :keyword LIMIT %1").arg(limit);
    query.prepare(sql);
    query.bindValue(":keyword", "%" + keyword + "%");

    if (!query.exec()) {
        qWarning() << "Failed to search products by name:" << query.lastError().text();
        return list;
    }

    if (query.next()) {
        Products* p = new Products();
        p->setProductId(query.value(0).toString());
        p->setProductName(query.value(1).toString());
        p->setCost(query.value(2).toDouble());
        p->setIsValue(query.value(3).toBool());
        p->setDescription(query.value(4).toString());
        list.append(p);
    }

    return list;
}

// ****************************************





// <<<<<<<<<< FOR BATCHES >>>>>>>>>>

QList<Batch*> DatabaseManager::getBatchByPage(const QString& productName, int numPage) {
    QList<Batch*> list;
    QSqlQuery query;
    int limit = 9;
    int offset = numPage * limit;

    query.prepare("SELECT product_name, quantity, cost, import_date, expiry_date "
                  "FROM product_batches "
                  "WHERE product_name = :productName "
                  "LIMIT :limit OFFSET :offset");
    query.bindValue(":productName", productName);
    query.bindValue(":limit", limit);
    query.bindValue(":offset", offset);

    if (!query.exec()) {
        qWarning() << "Failed to fetch batches by page for product:" << productName << "-" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Batch* b = new Batch();
        b->setQuantity(query.value(1).toInt());
        b->setCost(query.value(2).toFloat());
        b->setImportDate(QDateTime::fromString(query.value(3).toString(), "dd-MM-yyyy").date().startOfDay());
        b->setExpiryDate(QDateTime::fromString(query.value(4).toString(), "dd-MM-yyyy").date().startOfDay());
        list.append(b);
    }

    return list;
}

// ****************************************

bool DatabaseManager::insertCustomer(const Customer& customer) {
    QSqlQuery query;
    query.prepare("INSERT INTO customers (name, phone_number, gender, year_of_birth) VALUES (?, ?, ?, ?)");
    query.addBindValue(customer.getCustomerName());
    query.addBindValue(customer.getCustomerPhoneNumber());
    query.addBindValue(GenderToQString(customer.getCustomerGender()));
    query.addBindValue(customer.getCustomerYearOfBirth());

    if (!query.exec()) {
        qWarning() << "Failed to insert customer:" << query.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseManager::deleteCustomerByName(const QString& name) {
    QSqlQuery query;
    query.prepare("DELETE FROM customers WHERE name = ?");
    query.addBindValue(name);

    if (!query.exec()) {
        qWarning() << "Failed to delete customer:" << query.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseManager::deleteCustomerByPhoneNumber(const QString& phoneNumer) {
    QSqlQuery query;
    query.prepare("DELETE FROM customers WHERE phone_number = ?");
    query.addBindValue(phoneNumer);

    if (!query.exec()) {
        qWarning() << "Failed to delete customer:" << query.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseManager::checkCustomerPhoneNumberExists(const QString& phoneNumber) {
    QSqlQuery query;
    query.prepare("SELECT EXISTS (SELECT 1 FROM customers WHERE phone_number = :phone LIMIT 1)");
    query.bindValue(":phone", phoneNumber);

    if (query.exec() && query.next()) {
        return query.value(0).toBool();
    }

    return false;
}

QList<Customer*> DatabaseManager::getCustomersByPage(int numPage) {
    QList<Customer*> list;
    QSqlQuery query;
    int limit = 12;
    int offset = numPage * limit;

    query.prepare("SELECT name, phone_number, gender, year_of_birth FROM customers LIMIT :limit OFFSET :offset");
    query.bindValue(":limit", limit);
    query.bindValue(":offset", offset);

    if (!query.exec()) {
        qWarning() << "Failed to fetch customers by page:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Customer* c = new Customer();
        c->setCustomerName(query.value(0).toString());
        c->setCustomerPhoneNumber(query.value(1).toString());
        c->setCustomerGender(QStringToGender(query.value(2).toString()));
        c->setCustomerYearOfBirth(query.value(3).toInt());
        list.append(c);
    }

    return list;
}

QList<Customer*> DatabaseManager::getCustomerByName(const QString& name) {
    QList<Customer*> list;
    QSqlQuery query;
    int limit = 6;

    QString sql = QString("SELECT name, phone_number, gender, year_of_birth FROM customers WHERE name LIKE :name LIMIT %1").arg(limit);
    query.prepare(sql);
    query.bindValue(":name", "%" + name + "%");

    if (!query.exec()) {
        qWarning() << "Failed to fetch customer by name:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Customer* c = new Customer();
        c->setCustomerName(query.value(0).toString());
        c->setCustomerPhoneNumber(query.value(1).toString());
        c->setCustomerGender(QStringToGender(query.value(2).toString()));
        c->setCustomerYearOfBirth(query.value(3).toInt());
        list.append(c);
    }

    return list;
}

QList<Customer*> DatabaseManager::getACustomerByName(const QString& name) {
    QList<Customer*> list;
    QSqlQuery query;
    query.prepare("SELECT name, phone_number, gender, year_of_birth FROM customers WHERE name = :name LIMIT 1");
    query.bindValue(":name", name);

    if (!query.exec()) {
        qWarning() << "Failed to fetch customer by name:" << query.lastError().text();
        return list;
    }

    if (query.next()) {
        Customer* c = new Customer();
        c->setCustomerName(query.value(0).toString());
        c->setCustomerPhoneNumber(query.value(1).toString());
        c->setCustomerGender(QStringToGender(query.value(2).toString()));
        c->setCustomerYearOfBirth(query.value(3).toInt());
        list.append(c);
    }

    return list;
}

QList<Customer*> DatabaseManager::getCustomerByPhoneNumber(const QString& phone) {
    QList<Customer*> list;
    QSqlQuery query;
    int limit = 6;

    QString sql = QString("SELECT name, phone_number, gender, year_of_birth FROM customers WHERE phone_number LIKE :phone LIMIT %1").arg(limit);
    query.prepare(sql);
    query.bindValue(":phone", "%" + phone + "%");

    if (!query.exec()) {
        qWarning() << "Failed to fetch customer by phone:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Customer* c = new Customer();
        c->setCustomerName(query.value(0).toString());
        c->setCustomerPhoneNumber(query.value(1).toString());
        c->setCustomerGender(QStringToGender(query.value(2).toString()));
        c->setCustomerYearOfBirth(query.value(3).toInt());
        list.append(c);
    }

    return list;
}

QList<Customer*> DatabaseManager::getACustomerByPhoneNumber(const QString& phone) {
    QList<Customer*> list;
    QSqlQuery query;
    query.prepare("SELECT name, phone_number, gender, year_of_birth FROM customers WHERE phone_number = :phone LIMIT 1");
    query.bindValue(":phone", phone);

    if (!query.exec()) {
        qWarning() << "Failed to fetch customer by phone:" << query.lastError().text();
        return list;
    }

    if (query.next()) {
        Customer* c = new Customer();
        c->setCustomerName(query.value(0).toString());
        c->setCustomerPhoneNumber(query.value(1).toString());
        c->setCustomerGender(QStringToGender(query.value(2).toString()));
        c->setCustomerYearOfBirth(query.value(3).toInt());
        list.append(c);
    }

    return list;
}

