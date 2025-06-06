#include <QStandardPaths>
#include <QFileInfo>
#include "databasemanager.h"
#include <QDir>

DatabaseManager::DatabaseManager(QObject *parent)
    : QObject{parent}
{}

bool DatabaseManager::initialize(){
    QString dbPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/database.db";
    QDir().mkpath(QFileInfo(dbPath).absolutePath());  // tạo thư mục nếu chưa tồn tại
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

        QString createOrdersTableQuery = 
            "CREATE TABLE IF NOT EXISTS orders ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "customer_name TEXT NOT NULL,"
            "phone_number TEXT NOT NULL,"
            "export_date TEXT NOT NULL,"
            "data TEXT NOT NULL,"
            "notes TEXT NOT NULL"
            ")";

        if(!query.exec(createOrdersTableQuery)) {
            qWarning() << "Failed to create orders table:" << query.lastError().text();
            return false;
        }
    }
    qDebug() << "Database file is located at:" << dbPath;
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
    query.addBindValue(batch.getImportDate().toString("yyyy-MM-dd"));
    query.addBindValue(batch.getExpiryDate().toString("yyyy-MM-dd"));

    if (!query.exec()) {
        qWarning() << "❌ Lỗi khi thêm lô hàng:" << query.lastError().text();
        return false;
    }

    return true;
}

bool DatabaseManager::updateBatch(const QString& productName, const Batch& batch) {
    int currentQuantity = 0;
    QSqlQuery selectQuery;
    selectQuery.prepare("SELECT quantity FROM product_batches WHERE product_name = ? AND import_date = ? AND expiry_date = ?");
    selectQuery.addBindValue(productName);
    selectQuery.addBindValue(batch.getImportDate().toString("yyyy-MM-dd"));
    selectQuery.addBindValue(batch.getExpiryDate().toString("yyyy-MM-dd"));

    if (selectQuery.exec() && selectQuery.next()) {
        currentQuantity = selectQuery.value(0).toInt();
    } else {
        qWarning() << "❌ Không tìm thấy lô hàng để cập nhật.";
        return false;
    }

    QSqlQuery updateQuery;
    int newQuantity = currentQuantity - batch.getQuantity();
    if (newQuantity < 0) {
        qWarning() << "❌ Số lượng cập nhật âm!";
        return false;
    } else if(newQuantity == 0){
        updateQuery.prepare("DELETE FROM product_batches WHERE product_name = ? AND import_date = ? AND expiry_date = ?");
    }else{
        updateQuery.prepare("UPDATE product_batches SET quantity = ? WHERE product_name = ? AND import_date = ? AND expiry_date = ?");
        updateQuery.addBindValue(newQuantity);
    }
    updateQuery.addBindValue(productName);
    updateQuery.addBindValue(batch.getImportDate().toString("yyyy-MM-dd"));
    updateQuery.addBindValue(batch.getExpiryDate().toString("yyyy-MM-dd"));

    if (!updateQuery.exec()) {
        qWarning() << "❌ Lỗi khi cập nhật số lượng lô hàng:" << updateQuery.lastError().text();
        return false;
    }

    return true;
}

// ****< xoá sản phẩm >****
bool DatabaseManager::deleteProduct(const QString& pro){
    QSqlQuery query;

    // First delete all batches associated with the product
    query.prepare("DELETE FROM product_batches WHERE product_name = ?");
    query.addBindValue(pro);
    if (!query.exec()) {
        qWarning() << "Failed to delete product batches:" << query.lastError().text();
        return false;
    }

    // Then delete the product itself
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
    int limit = 14;
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

QList<Products*> DatabaseManager::getProductListByPrice(const QString& keyword){
    QList<Products*> list;
    QSqlQuery query;
    int limit = 6;

    bool ok = false;
    double price = keyword.toInt(&ok);
    if (!ok) {
        qWarning() << "Invalid price keyword:" << keyword;
        return list;
    }

    QString sql = QString("SELECT product_id, product_name, cost, is_value, description "
                          "FROM products WHERE cost = :price LIMIT %1").arg(limit);
    query.prepare(sql);
    query.bindValue(":price", price);

    if (!query.exec()) {
        qWarning() << "Failed to search products by price:" << query.lastError().text();
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
    int limit = 6;
    int offset = numPage * limit;

    query.prepare("SELECT product_name, quantity, cost, import_date, expiry_date "
                  "FROM product_batches "
                  "WHERE product_name = :productName "
                  "LIMIT :limit OFFSET :offset");
    query.bindValue(":productName", productName);
    query.bindValue(":limit", limit);
    query.bindValue(":offset", offset);

    if (!query.exec()) {
        qWarning() << "Failed to fetch batches by page for batch:" << productName << "-" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Batch* b = new Batch();
        b->setProductName(query.value(0).toString());
        b->setQuantity(query.value(1).toInt());
        b->setCost(query.value(2).toFloat());
        b->setImportDate(QDateTime::fromString(query.value(3).toString(), "yyyy-MM-dd").date().startOfDay());
        b->setExpiryDate(QDateTime::fromString(query.value(4).toString(), "yyyy-MM-dd").date().startOfDay());
        list.append(b);
    }

    return list;
}

QList<Batch*> DatabaseManager::getBatchByExpiredDate(const QString& productName, const QDateTime& expiredDate, int numOfBatch, int numpage){
    QList<Batch*> list;
    QSqlQuery query;
    
    if(productName.isEmpty()){
        query.prepare("SELECT product_name, quantity, cost, import_date, expiry_date "
                    "FROM product_batches "
                    "WHERE expiry_date <= :expiry_date "
                    "LIMIT :limit OFFSET :offset");
        
    }else{
        query.prepare("SELECT product_name, quantity, cost, import_date, expiry_date "
                    "FROM product_batches "
                    "WHERE expiry_date <= :expiry_date "
                    "AND product_name = :product_name "
                    "LIMIT :limit OFFSET :offset");
        query.bindValue(":product_name", productName);

       
    }
    query.bindValue(":expiry_date", expiredDate.toString("yyyy-MM-dd"));
    query.bindValue(":limit", numOfBatch);
    query.bindValue(":offset", numpage * numOfBatch);

    if (!query.exec()) {
        qWarning() << "Failed to fetch batches by page for batch:" << productName << "-" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Batch* b = new Batch();
        b->setProductName(query.value(0).toString());
        b->setQuantity(query.value(1).toInt());
        b->setCost(query.value(2).toFloat());
        b->setImportDate(QDateTime::fromString(query.value(3).toString(), "yyyy-MM-dd").date().startOfDay());
        b->setExpiryDate(QDateTime::fromString(query.value(4).toString(), "yyyy-MM-dd").date().startOfDay());
        list.append(b);
    }

    return list;
}

double DatabaseManager::getNumOfItemOfAllBatch(const QString& productName){
    QSqlQuery query;
    query.prepare("SELECT product_name, quantity "
                  "FROM product_batches "
                  "WHERE product_name = :productName ");
    query.bindValue(":productName", productName);

    if (!query.exec()) {
        qWarning() << "Failed to fetch batches by page for product:" << productName << "-" << query.lastError().text();
        return 0.0;
    }

    int result = 0;

    while (query.next()){
        result += query.value(1).toInt();
    }

    return static_cast<double>(result);
}

double DatabaseManager::getNumOfALLBatchExpired(const QDateTime& time){
    QSqlQuery query;
    qDebug() << time.toString("dd-MM-yyyy");
    query.prepare("SELECT COUNT(*) FROM product_batches WHERE expiry_date <= :targetDate");
    query.bindValue(":targetDate", time.toString("yyyy-MM-dd"));

    if (!query.exec()) {
        qWarning() << "❌ Lỗi khi đếm số lô hết hạn:" << query.lastError().text();
        return 0.0;
    }

    if (query.next()) {
        return query.value(0).toDouble();
    }

    return 0.0;
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

QList<Customer*> DatabaseManager::getCustomerByYearOfBirth(const QString& yearOfBirth) {
    QList<Customer*> list;
    QSqlQuery query;
    int limit = 6;

    QString sql = QString("SELECT name, phone_number, gender, year_of_birth FROM customers WHERE year_of_birth LIKE :year_of_birth LIMIT %1").arg(limit);
    query.prepare(sql);
    query.bindValue(":year_of_birth", "%" + yearOfBirth + "%");

    if (!query.exec()) {
        qWarning() << "Failed to fetch customer by year of birth:" << query.lastError().text();
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


QList<Customer*> DatabaseManager::getACustomerByYearOfBirth(const QString& yearOfBirth){
    QList<Customer*> list;
    QSqlQuery query;
    query.prepare("SELECT name, phone_number, gender, year_of_birth FROM customers WHERE year_of_birth = :year_of_birth LIMIT 1");
    query.bindValue(":year_of_birth", yearOfBirth);

    if (!query.exec()) {
        qWarning() << "Failed to fetch customer by year of birth:" << query.lastError().text();
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

bool DatabaseManager::insertOrder(Order& order){
    QString name;
    QSqlQuery queryforname;
    queryforname.prepare("SELECT name FROM customers WHERE phone_number = :phone_number LIMIT 1");
    queryforname.bindValue(":phone_number", order.getCustomerPhoneNumber());
    if (!queryforname.exec()) {
        qWarning() << "❌ Lỗi khi lấy tên khách hàng :" << queryforname.lastError().text();
        return false;
    }
    if(queryforname.next()){
        name = queryforname.value(0).toString();
    }

    QSqlQuery query;
    query.prepare("INSERT INTO orders (customer_name, phone_number, export_date, data, notes) "
                  "VALUES (?, ?, ?, ?, ?)");
    query.addBindValue(name);
    query.addBindValue(order.getCustomerPhoneNumber());
    query.addBindValue(order.getPurchaseTime().toString("yyyy-MM-dd"));
    query.addBindValue(Order::itemToQString(order.getListItem()));
    query.addBindValue("Ghi chú"); // hoặc order.getNote() nếu có

    if (!query.exec()) {
        qWarning() << "❌ Lỗi khi thêm đơn hàng:" << query.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseManager::deleteOrder(const QString& customerName, const QString& phoneNumber, const QDateTime& purchaseTime){
    QSqlQuery query;
    QString sql = "DELETE FROM orders WHERE 1=1";
    if(!customerName.isEmpty()){
        sql += " AND customer_name = :customerName";
    }
    if(!phoneNumber.isEmpty()){
        sql += " AND phone_number = :phoneNumber";
    }
    if(!purchaseTime.isValid()){
        sql += " AND export_date = :purchaseTime";
    }

    query.prepare(sql);

    if(!customerName.isEmpty()){
        query.bindValue(":customerName", customerName);
    }
    if(!phoneNumber.isEmpty()){
        query.bindValue(":phoneNumber", phoneNumber);
    }
    if(!purchaseTime.isValid()){
         query.bindValue(":purchaseTime", purchaseTime.toString("yyyy-MM-dd"));
    }

    if (!query.exec()) {
        qWarning() << "❌ Lỗi khi xoá đơn hàng:" << query.lastError().text();
        return false;
    }
    return query.numRowsAffected() > 0;
}

QList<Order*> DatabaseManager::getOrder(const QString& customerName, const QString& phoneNumber, const QDateTime& purchaseTime, int numOfOrder, int numpage){
    QList<Order*> list;
    QSqlQuery query;
    QString sql = "SELECT customer_name, phone_number, export_date, data, notes FROM orders WHERE 1=1";

    if (!customerName.isEmpty()) {
        sql += " AND customer_name = :customer_name";
    }
    if (!phoneNumber.isEmpty()) {
        sql += " AND phone_number = :phone_number";
    }
    if (purchaseTime.isValid()) {
        sql += " AND export_date = :export_date";
    }

    sql += " LIMIT :limit OFFSET :offset";

    query.prepare(sql);

    if (!customerName.isEmpty()) {
        query.bindValue(":customer_name", customerName);
    }
    if (!phoneNumber.isEmpty()) {
        query.bindValue(":phone_number", phoneNumber);
    }
    if (purchaseTime.isValid()) {
        query.bindValue(":export_date", purchaseTime.toString("yyyy-MM-dd"));
    }

    query.bindValue(":limit", numOfOrder);
    query.bindValue(":offset", numpage * numOfOrder);

    if (!query.exec()) {
        qWarning() << "Failed to fetch order:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Order* o = new Order();
        o->setCustomerName(query.value(0).toString());
        o->setCustomerPhoneNumber(query.value(1).toString());
        o->setPurchaseTime(QDateTime::fromString(query.value(2).toString(), "yyyy-MM-dd"));
        o->QStringToItems(query.value(3).toString());
        list.append(o);
    }

    return list;
}

QList<Order*> DatabaseManager::getOrderByPage(cmdContext cmd, const QString& keyword, int numOfOrder,int numpage){
    QList<Order*> list;
    QSqlQuery query;
    QString sql;
    if(!keyword.isEmpty()){
        if(cmd.typelist == type_of_list::NAME){

        }else if(cmd.typelist == type_of_list::PHONENUMBER){
            sql = "SELECT customer_name, phone_number, export_date, data, notes FROM orders "
                    "WHERE phone_number = :phone_number "
                    "ORDER BY export_date DESC "
                    "LIMIT :limit OFFSET :offset";
        }
    }else{
        sql = "SELECT customer_name, phone_number, export_date, data, notes FROM orders "
              "LIMIT :limit OFFSET :offset";
    }

    query.prepare(sql);

    if(!keyword.isEmpty()){
        if(cmd.typelist == type_of_list::NAME){

        }else if(cmd.typelist == type_of_list::PHONENUMBER){
            query.bindValue(":phone_number", keyword);
        }
    }
    query.bindValue(":limit", numOfOrder);
    query.bindValue(":offset", numpage * numOfOrder);
    

    if(!query.exec()){
        qWarning() << "Failed to fetch orders by page for order";
        return list;
    }

    while(query.next()){
        Order* order = new Order();
        order->setCustomerName(query.value(0).toString());
        order->setCustomerPhoneNumber(query.value(1).toString());
        order->setPurchaseTime(QDateTime::fromString(query.value(2).toString(), "yyyy-MM-dd"));
        order->setListItem(Order::QStringToItems(query.value(3).toString()));
        list.append(order);
    }

    return list;
}

QList<Order*> DatabaseManager::getOrderByPeriod(const QString& customerName, const QString& phoneNumber, int numOfOrder,int numpage){

}