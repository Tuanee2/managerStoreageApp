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





    // <<<<<<<<<< FOR ORDERS >>>>>>>>>>
    connect(this, &appcontroller::orderCommandRequested,
        m_store, &storeage::handleOrderCommand, Qt::QueuedConnection);

    connect(m_store, &storeage::orderCommandResult,
        this, &appcontroller::onOrderCommandResult, Qt::QueuedConnection);

    connect(this, &appcontroller::orderListRequested,
        m_store, &storeage::handleOrderListRequest, Qt::QueuedConnection);

    connect(m_store, &storeage::orderListReady,
        this, &appcontroller::onOrderListReady, Qt::QueuedConnection);
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

void appcontroller::requestCommandBatchToOrder_UI(const QString& cmd, const QString& productName, int costOfProduct, const QVariantList& batchList){
    if(cmd == "ADD"){
        Products* product = nullptr;
        for (Products* p : order.getListItem()) {
            if (p->getProductName() == productName) {
                product = p;
                break;
            }
        }
        

        if (!product) {
            product = new Products();
            product->setProductName(productName);
            product->setCost(costOfProduct);
            order.getListItem().append(product);
        }

        qDebug() << order.getListItem().size();

        for (const QVariant& v : batchList) {
            QVariantMap b = v.toMap();
            Batch* batch = new Batch();
            batch->setQuantity(b["quantity"].toInt());
            batch->setCost(b["cost"].toDouble());
            batch->setImportDate(QDateTime::fromString(b["importdate"].toString(), "dd-MM-yyyy"));
            batch->setExpiryDate(QDateTime::fromString(b["expireddate"].toString(), "dd-MM-yyyy"));
            product->getBatchList().append(batch);
        }
    }

    emit requestCommandBatchToOrderResult_UI(true, cmd);
}

void appcontroller::orderUpdate_UI(){
    QList<QVariantMap> list;
    for(Products* p : order.getListItem()){
        QVariantMap product;
        product["productName"] = p->getProductName();
        product["price"] = p->getCost();
        product["numOfItem"] = p->getNumOfItem();
        list.append(product);
    }

    emit orderUpdateResult_UI(list);
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

void appcontroller::requestBatchInformation(const QString& type, const QString& typelist, const QString& duration, const QString& productName){
    cmdContext CMD;
    CMD.type = QStringToType(type);
    CMD.typelist = QStringToTypeList(typelist);
    CMD.duration = QStringToDuration(duration);
    emit batchInfoRequested(CMD, productName);
}

void appcontroller::onBatchInfoResult(double result, cmdContext cmd){
    emit batchInfoResult(result , TypeToQString(cmd.type));
}

void appcontroller::requestBatchList(const QString& cmd, const QString& cmdExtension, const QString& productName, const QString& keyword, int numOfBatch, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    CMD.typelist = QStringToTypeList(cmdExtension);
    if(CMD.typelist == type_of_list::EXPIREDDATE){
        CMD.duration = QStringToDuration(keyword);
    }
    emit batchListRequested(CMD, productName, keyword, numOfBatch, numPage);
}

void appcontroller::onBatchListReady(QList<QVariantMap> list, cmdContext cmd){
    
    emit batchListReady(list, CmdToQString(cmd.cmd));
}
// ****************************************





// <<<<<<<<<< FOR CUSTOMERS >>>>>>>>>>

void appcontroller::requestCustomerCommand(const QString& cmd, Customer* customer){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    Customer data(*customer);
    emit customerCommand(CMD, data);
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
void appcontroller::requestOrderCommand(const QString& cmd, const QString& phoneNumber, const QString& dateExport){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    qDebug() << phoneNumber;
    order.setCustomerPhoneNumber(phoneNumber);
    order.setPurchaseTime(QDateTime::fromString(dateExport, "dd-MM-yyyy"));
    QJsonObject data = order.toJson();
    order.clean();
    emit orderCommandRequested(CMD, data);
}

void appcontroller::onOrderCommandResult(bool done, cmdContext cmd){
    emit orderCommandResult(done, CmdToQString(cmd.cmd));
}

void appcontroller::requestOrderList(const QString& cmd, const QString& dateBegin, const QString& dateEnd, int numOfOrder, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    emit orderListRequested(CMD, "", dateBegin, dateEnd, numOfOrder, numPage);
}

void appcontroller::requestOrderList(const QString& cmd, const QString& keywword, const QString& dateBegin, const QString& dateEnd, int numOfOrder, int numPage){

}

void appcontroller::onOrderListReady(QList<QVariantMap> list, cmdContext cmd){
    emit orderListReady(list, CmdToQString(cmd.cmd));
}

// ****************************************