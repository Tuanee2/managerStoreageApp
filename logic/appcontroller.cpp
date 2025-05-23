#include "appcontroller.h"

appcontroller::appcontroller(storeage* store, QObject* parent)
    : QObject(parent), m_store(store)
{

    // <<<<<<<<<< FOR PRODUCTS >>>>>>>>>>
    // ****< Kiểm tra tên trùng lặp >****
    connect(this, &appcontroller::checkProductNameConflictSignal,
        m_store, &storeage::handleCheckProductName, Qt::QueuedConnection);

    connect(m_store, &storeage::productNameCheckResult,
        this, &appcontroller::onProductNameChecked, Qt::QueuedConnection);

    // ****************************************

    // **********< Thêm/ sửa/ xoá sản phẩm >*********
    connect(this, &appcontroller::productCommand,
        m_store, &storeage::handleProductCommand, Qt::QueuedConnection);

    connect(m_store, &storeage::productCommandResult,
        this, &appcontroller::onProductCommandResult, Qt::QueuedConnection);

    // **********************************************

    // ****< Lấy danh sách sản phẩm >****
    connect(this, &appcontroller::productListRequested,
        m_store, &storeage::handleProductListRequest, Qt::QueuedConnection);

    connect(m_store, &storeage::productListReady,
        this, &appcontroller::onProductListReady, Qt::QueuedConnection);

    // ****************************************





    // <<<<<<<<<< FOR BATCHES >>>>>>>>>>
    connect(this, &appcontroller::batchCommand,
        m_store, &storeage::handleBatchCommand, Qt::QueuedConnection);

    connect(m_store, &storeage::batchCommandResult,
        this, &appcontroller::onBatchCommandResult, Qt::QueuedConnection);

    connect(this, &appcontroller::batchInfoRequested,
        m_store, &storeage::handleBatchInfoRequest, Qt::QueuedConnection);

    connect(m_store, &storeage::batchInfoResult,
        this, &appcontroller::onBatchInfoResult, Qt::QueuedConnection);

    connect(this, &appcontroller::batchListRequested,
        m_store, &storeage::handleBatchListRequest, Qt::QueuedConnection);

    connect(m_store, &storeage::batchListReady,
        this, &appcontroller::onBatchListReady, Qt::QueuedConnection);
    // ****************************************





    // <<<<<<<<<< FOR CUSTOMER >>>>>>>>>>
    connect(this, &appcontroller::customerCommand,
        m_store, &storeage::handleCustomerCommand, Qt::QueuedConnection);

    connect(m_store, &storeage::customerCommandResult,
        this, &appcontroller::onCustomerCommandResult, Qt::QueuedConnection);

    connect(this, &appcontroller::customerListRequested,
        m_store, &storeage::handleCustomerListRequest, Qt::QueuedConnection);

    connect(m_store, &storeage::customerListReady,
        this, &appcontroller::onCustomerListReady, Qt::QueuedConnection);
    
    // ****************************************

}

void appcontroller::requestCommandOrder_UI(const QString& cmd){
    Cmd CMD = QStringToCmd(cmd);
    if(CMD == Cmd::ADD){
        order.clean();
    }else if(CMD == Cmd::DELETE){
        order.clean();
    }
    emit requestCommandOrderResult_UI(true, cmd);
}

void appcontroller::addProductToOrder_UI(const QString& productName){
    Products* product = new Products();
    product->setProductName(productName);
    order.getListItem().push_back(product);
    emit addProductToOrderResult_UI(true);
}

void appcontroller::addBatchToOrder_UI(const QString& productName, const QString& expiredDate, const QString& importDate, int quantity){
    Products* product = nullptr;
    for (Products* p : order.getListItem()) {
        if (p->getProductName() == productName) {
            product = p;
            break;
        }
    }

    if (!product) {
        emit addBatchToOrderResult_UI(false);
        return;
    }

    Batch* batch = new Batch();
    batch->setQuantity(quantity);
    batch->setExpiryDate(QDateTime::fromString(expiredDate, "dd-MM-yyyy"));
    batch->setImportDate(QDateTime::fromString(importDate, "dd-MM-yyyy"));
    product->getBatchList().append(batch);

    emit addBatchToOrderResult_UI(true);
}


// ****< Kiểm tra tên trùng lặp >****
void appcontroller::checkProductNameConflict(const QString& name){
    emit checkProductNameConflictSignal(name);
}

void appcontroller::onProductNameChecked(bool exists) {
    emit productNameChecked(exists); // để QML xử lý tiếp
}

// ****************************************





// <<<<<<<<<< FOR PRODUCTS >>>>>>>>>>

// **********< Thêm/ sửa/ xoá sản phẩm >*********

void appcontroller::requestProductCommand(const QString& cmd, const QString& id, const QString& name, double price, bool isValue, const QString &des){
    Products pro;
    pro.setProductId(id);
    pro.setProductName(name);
    pro.setCost(price);
    pro.setIsValue(true);
    pro.setDescription(des);
    cmdContext command;
    command.cmd = QStringToCmd(cmd);
    emit productCommand(pro, command);
}

void appcontroller::onProductCommandResult(bool done) {
    emit productCommandResult(done);
}

// ****************************************

// ****< Lấy danh sách sản phẩm >****
void appcontroller::requestProductList(const QString& cmd, const QString& keyword,int numPage) {
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    emit productListRequested(CMD, keyword, numPage);
}

void appcontroller::requestProductList(const QString& cmd, const QString& cmdExtension, const QString& keyword, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    CMD.typelist = QStringToTypeList(cmdExtension);
    emit productListRequested(CMD, keyword, numPage);
}

void appcontroller::onProductListReady(QList<QVariantMap> list, cmdContext cmd){
    emit productListReady(list, CmdToQString(cmd.cmd));
}

// ****************************************




// <<<<<<<<<< FOR BATCHES >>>>>>>>>>
// ****< thêm lô sản phẩm >****

void appcontroller::requestBatchCommand(const QString& cmd, const QString& name, int num, double cost, const QString& importDate, const QString& expiredDate){
    Batch batch;
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);

    if(cmd == "ADD"){
        batch.setQuantity(num);
        batch.setCost(cost);
        QDateTime dtImport = QDateTime::fromString(importDate, "dd-MM-yyyy");
        batch.setImportDate(dtImport);
        QDateTime dtExpired = QDateTime::fromString(expiredDate, "dd-MM-yyyy");
        batch.setExpiryDate(dtExpired);
    }

    emit batchCommand(CMD, name, batch);
}

void appcontroller::onBatchCommandResult(bool done){

}

void appcontroller::requestBatchInformation(const QString& type, const QString& productName){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(type);
    emit batchInfoRequested(CMD, productName);
}

void appcontroller::onBatchInfoResult(double result, cmdContext cmd){
    emit batchInfoResult(result , TypeToQString(cmd.type));
}

void appcontroller::requestBatchList(const QString& cmd, const QString& productName, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    emit batchListRequested(CMD, productName, numPage);
}

void appcontroller::requestBatchList(const QString& cmd, const QString& cmdExtension, const QString& productName, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    CMD.typelist = QStringToTypeList(cmdExtension);
    emit batchListRequested(CMD, productName, numPage);
}

void appcontroller::onBatchListReady(QList<QVariantMap> list, cmdContext cmd){
    
    emit batchListReady(list, CmdToQString(cmd.cmd));
}
// ****************************************





// <<<<<<<<<< FOR CUSTOMERS >>>>>>>>>>

void appcontroller::requestCustomerCommand(const QString& cmd, const QString& name, int yearOfBirth, const QString& gender, const QString& phoneNumber){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    Customer customer;
    customer.setCustomerName(name);
    customer.setCustomerYearOfBirth(yearOfBirth);
    customer.setCustomerGender(QStringToGender(gender));
    customer.setCustomerPhoneNumber(phoneNumber);

    emit customerCommand(CMD, customer);
}

void appcontroller::onCustomerCommandResult(bool done, cmdContext cmd){
    emit customerCommandResult(done, CmdToQString(cmd.cmd));
}

void appcontroller::requestCustomerList(const QString& cmd, const QString& keyword, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    emit customerListRequested(CMD, keyword, numPage);
}

void appcontroller::requestCustomerList(const QString& cmd, const QString& cmdExtension, const QString& keyword, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    CMD.typelist = QStringToTypeList(cmdExtension);
    emit customerListRequested(CMD, keyword, numPage);
}

void appcontroller::onCustomerListReady(QList<QVariantMap> list, cmdContext cmd){
    emit customerListReady(list, CmdToQString(cmd.cmd));
}

// ****************************************





// <<<<<<<<<< FOR ORDERS >>>>>>>>>>
void appcontroller::requestOrderCommand(const QString& cmd, const QString& phoneNumber, const QString& dateExport, const QString& data){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    Order order;
    order.setCustomerPhoneNumber(phoneNumber);
    order.setListItem(Order::QStringToItems(data));
    emit orderCommand(CMD, phoneNumber, order);
}

void appcontroller::onOrderCommandResult(bool done, cmdContext cmd){
    emit orderCommandResult(done, CmdToQString(cmd.cmd));
}

void appcontroller::requestOrderList(const QString& cmd, const QString& dateBegin, const QString& dateEnd, int numPage){

}

void appcontroller::onOrderListReady(QList<QVariantMap> list, cmdContext cmd){

}

// ****************************************