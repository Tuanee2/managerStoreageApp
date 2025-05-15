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
            "import_date TEXT NOT NULL,"
            "expiry_date TEXT NOT NULL,"
            "FOREIGN KEY(product_name) REFERENCES products(product_name))";

        if (!query.exec(createBatchesTableQuery)) {
            qWarning() << "Failed to create product_batches table:" << query.lastError().text();
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
    query.prepare("INSERT INTO product_batches (product_name, quantity, import_date, expiry_date) "
                  "VALUES (?, ?, ?, ?)");
    query.addBindValue(productName);
    query.addBindValue(batch.getQuantity());
    query.addBindValue(batch.getImportDate().toString("dd-MM-yyyy"));
    query.addBindValue(batch.getExpiryDate().toString("dd-MM-yyyy"));

    if (!query.exec()) {
        qWarning() << "❌ Lỗi khi thêm lô hàng:" << query.lastError().text();
        return false;
    }
    qDebug() << "i'm run";

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

    query.prepare("SELECT product_name, quantity, import_date, expiry_date "
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
        b->setImportDate(QDateTime::fromString(query.value(2).toString(), "dd-MM-yyyy").date().startOfDay());
        b->setExpiryDate(QDateTime::fromString(query.value(3).toString(), "dd-MM-yyyy").date().startOfDay());
        list.append(b);
    }

    return list;
}

// ****************************************
