#include "appcontroller.h"

appcontroller::appcontroller(storeage* store, QObject* parent)
    : QObject(parent), m_store(store)
{
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

    connect(this, &appcontroller::batchListRequested,
        m_store, &storeage::handleBatchListRequest, Qt::QueuedConnection);

    connect(m_store, &storeage::batchListReady,
        this, &appcontroller::onBatchListReady, Qt::QueuedConnection);
    // ****************************************
    
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
    emit productListRequested(QStringToCmd(cmd), keyword, numPage);
}

void appcontroller::onProductListReady(QList<QVariantMap> list, Cmd cmd){
    emit productListReady(list, CmdtoQString(cmd));
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

void appcontroller::requestBatchList(const QString& cmd, const QString& productName, int numPage){
    cmdContext CMD;
    CMD.cmd = QStringToCmd(cmd);
    emit batchListRequested(CMD, productName, numPage);
}

void appcontroller::onBatchListReady(QList<QVariantMap> list, cmdContext cmd){
    
    emit batchListReady(list, CmdtoQString(cmd.cmd));
}
// ****************************************





// <<<<<<<<<< FOR CUSTOMERS >>>>>>>>>>

// ****************************************