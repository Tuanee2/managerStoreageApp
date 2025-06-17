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

void appcontroller::requestProductCommand(QVariantMap cmdData){
    BaseCommand command;
    command = MapToBaseCommand(cmdData);
    emit productCommand(command);
}

void appcontroller::onProductCommandResult(bool done, BaseCommand cmd) {
    emit productCommandResult(done, BaseCommandToMap(cmd));
}

// ****************************************

// ****< Lấy danh sách sản phẩm >****
void appcontroller::requestProductList(QVariantMap CmdData) {
    BaseCommand command;
    command = MapToBaseCommand(CmdData);
    emit productListRequested(command);
}

void appcontroller::onProductListReady(QList<QVariantMap> list, BaseCommand cmd){
    emit productListReady(list, BaseCommandToMap(cmd));
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

void appcontroller::requestBatchList(QVariantMap cmdData, const QString& productName, const QString& keyword, int numOfBatch, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmdData.value("cmd").toString());
    CMD.typelist = QStringToTypeList(cmdData.value("typelist").toString());
    CMD.duration = QStringToDuration(cmdData.value("duration").toString());
    emit batchListRequested(CMD, productName, keyword, numOfBatch, numPage);
}

void appcontroller::onBatchListReady(QList<QVariantMap> list, cmdContext cmd){
    
    emit batchListReady(list, CmdToQString(cmd.cmd));
}
// ****************************************





// <<<<<<<<<< FOR CUSTOMERS >>>>>>>>>>

void appcontroller::requestCustomerCommand(QVariantMap cmdData){
    BaseCommand command;
    command = MapToBaseCommand(cmdData);
    emit customerCommand(command);
}

void appcontroller::onCustomerCommandResult(bool done, BaseCommand cmd){
    emit customerCommandResult(done, BaseCommandToMap(cmd));
}

void appcontroller::requestCustomerList(QVariantMap cmdData){
    BaseCommand command;
    command = MapToBaseCommand(cmdData);
    emit customerListRequested(command);
}

void appcontroller::onCustomerListReady(QList<QVariantMap> list, BaseCommand cmd){
    emit customerListReady(list, BaseCommandToMap(cmd));
}

// ****************************************





// <<<<<<<<<< FOR ORDERS >>>>>>>>>>
void appcontroller::requestOrderCommand(const QString& cmd, const QString& phoneNumber, const QString& dateExport, const QString& note){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    order.setCustomerPhoneNumber(phoneNumber);
    order.setPurchaseTime(QDateTime::fromString(dateExport, "dd-MM-yyyy"));
    order.setNote(note);
    QJsonObject data = order.toJson();
    order.clean();
    emit orderCommandRequested(CMD, data);
}

void appcontroller::onOrderCommandResult(bool done, cmdContext cmd){
    emit orderCommandResult(done, CmdToQString(cmd.cmd));
}

void appcontroller::requestOrderParam(QVariantMap cmdData, const QString& keyword, const QString& dateBegin, const QString& dateEnd){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmdData.value("cmd").toString());
    emit orderParamRequested(CMD, keyword, dateBegin, dateEnd);
}

void appcontroller::onOrderParamResult(double param, cmdContext cmd){
    emit orderParamResult(param, CmdToQString(cmd.cmd));
}

void appcontroller::requestOrderList(QVariantMap cmdData, const QString& keyword, const QString& dateBegin, const QString& dateEnd, int numOfOrder, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmdData.value("cmd").toString());
    CMD.typelist = QStringToTypeList(cmdData.value("typelist").toString());
    CMD.order = QStringToSortOrder(cmdData.value("order").toString());
    CMD.typeOder = QStringToTypeOder(cmdData.value("typeorder").toString());
    emit orderListRequested(CMD, keyword, dateBegin, dateEnd, numOfOrder, numPage);
}

void appcontroller::onOrderListReady(QList<QVariantMap> list, cmdContext cmd){
    emit orderListReady(list, CmdToQString(cmd.cmd));
}

// ****************************************

