#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>
#include "storeage.h"
#include "configcommand.h"
#include "customer.h"
#include "order.h"
#include "updateapp.h"

class appcontroller : public QObject
{
    Q_OBJECT
public:
    explicit appcontroller(storeage* store, QObject *parent = nullptr);

private:
    storeage* m_store;
    Order order;

//

public:
    Q_INVOKABLE void requestCommandOrder_UI(const QString& cmd);
signals:
    void requestCommandOrderResult_UI(bool result, const QString& cmd);

public:
    Q_INVOKABLE void requestCommandBatchToOrder_UI(const QString& cmd, const QString& productName, int costOfProduct,const QVariantList& batchList);
signals:
    void requestCommandBatchToOrderResult_UI(bool result, const QString& cmd);

public:
    Q_INVOKABLE void orderUpdate_UI();
signals:
    void orderUpdateResult_UI(QList<QVariantMap> list);


// ************************************************************************************************************************
// API giao tiếp đa luồng

// ****< Kiểm tra tên trùng lặp >****

public:
    Q_INVOKABLE void checkProductNameConflict(const QString& name);

signals:
    // for database thread
    void checkProductNameConflictSignal(const QString& name);
    // for UI
    void productNameChecked(bool exists);

public slots:
    void onProductNameChecked(bool exists);

// ****************************************



// <<<<<<<<<< FOR PRODUCTS >>>>>>>>>>

// **********< Thêm/ sửa/ xoá sản phẩm >*********

public:
    Q_INVOKABLE void requestProductCommand(const QString& cmd, const QString& id, const QString& name, double price, bool isValue, const QString &des);

signals:
    // for database thread
    void productCommand(Products pro, cmdContext cmd);
    // for UI
    void productCommandResult(bool done);


public slots:
    void onProductCommandResult(bool done);

// **********************************************

// **********< Lấy số liệu sản phẩm >**********
public:
    Q_INVOKABLE void requestProductParam(QVariantMap cmdData, const QString& keyword);

signals:
    // for thread database
    void productParamRequested(cmdContext cmd, const QString& keyword);
    // for UI
    void productParamResult(double result, const QString& cmd);

public slots:
    void onProductParamResult(double result, cmdContext cmd);

// **********************************************

// **********< Lấy danh sách sản phẩm >**********
public:
    Q_INVOKABLE void requestProductList(QVariantMap CmdData, const QString& keyword, int numPage);

signals:
    // for database thread
    void productListRequested(cmdContext cmd, const QString& keyword, int numPage);
    // for UI
    void productListReady(QList<QVariantMap> list, const QString cmd);

public slots:
    void onProductListReady(QList<QVariantMap> list, cmdContext cmd);

// ****************************************



// <<<<<<<<<< FOR BATCHES >>>>>>>>>>

// **********< thêm / sửa / xoá lô sản phẩm>**********
public:
    Q_INVOKABLE void requestBatchCommand(const QString& cmd, const QString& name, int num, double cost, const QString& importDate, const QString& expiredDate);

signals:
    // for database thread
    void batchCommand(cmdContext cmd, const QString& name, Batch batch);
    // for UI
    void batchCommandResult(bool done);
public slots:
    void onBatchCommandResult(bool done);

// ****************************************

// **********< Lấy thông số lô sản phẩm >**********
public:
    Q_INVOKABLE void requestBatchInformation(const QString& type, const QString& typelist, const QString& duration, const QString& productName);

signals:
    // for database thread
    void batchInfoRequested(cmdContext cmd, const QString& productName);
    // for UI 
    void batchInfoResult(double result, const QString& type);

public slots:
    void onBatchInfoResult(double result, cmdContext cmd);


// ****************************************

// *********< Lấy danh sách các lô sản phẩm >*********


// ****************************************


// *********< Lấy danh sách các lô sản phẩm >*********
public: 
    Q_INVOKABLE void requestBatchList(QVariantMap cmdData, const QString& productName, const QString& keyword, int numOfBatch, int numPage);

signals:
    // for database thread
    void batchListRequested(cmdContext cmd, const QString& productName, const QString& keyword, int numOfBatch, int numPage);
    // for UI
    void batchListReady(QList<QVariantMap> list, const QString& cmd);
    
public slots:
    void onBatchListReady(QList<QVariantMap> list, cmdContext cmd);

// ****************************************




// <<<<<<<<<< FOR CUSTOMERS >>>>>>>>>>
// **********< thêm / sửa / xoá khách hàng>**********
public:
    Q_INVOKABLE void requestCustomerCommand(const QString& cmd, const QString& name, int yearOfBirth, const QString& gender, const QString& phoneNumber);

signals:
    // for database thread
    void customerCommand(cmdContext cmd, Customer customer);
    // for UI
    void customerCommandResult(bool done, const QString& cmd);

public slots:
    void onCustomerCommandResult(bool done, cmdContext cmd);

// ****************************************

// *********< Lấy danh sách khách hàng >*********
public:
    Q_INVOKABLE void requestCustomerList(QVariantMap cmdData, const QString& keyword, int peplerPerPage, int numPage);

signals:
    // for database thread
    void customerListRequested(cmdContext cmd, const QString& keyword, int numPage);
    // for UI
    void customerListReady(QList<QVariantMap> list, const QString& cmd);
public slots:
    void onCustomerListReady(QList<QVariantMap> list, cmdContext cmd);

// ****************************************



// <<<<<<<<<< FOR ORDERS >>>>>>>>>>
// **********< thêm / sửa / xoá đơn hàng>**********
public: 
    Q_INVOKABLE void requestOrderCommand(const QString& cmd, const QString& phoneNumber, const QString& dateExport, const QString& note);

signals:
    // for database thread
    void orderCommandRequested(cmdContext cmd, const QJsonObject& data);
    // for UI
    void orderCommandResult(bool done, const QString& cmd);

public slots:
    void onOrderCommandResult(bool done, cmdContext cmd);

// ****************************************

// **********< Lấy thông số đơn hàng >**********
public: 
    Q_INVOKABLE void requestOrderParam(QVariantMap cmdData, const QString& keyword, const QString& dateBegin, const QString& dateEnd);

signals:
    // for database thread
    void orderParamRequested(cmdContext cmd, const QString& keyword, const QString& dateBegin, const QString& dateEnd);
    // for UI
    void orderParamResult(double param, const QString& cmd);

public slots:
    void onOrderParamResult(double param, cmdContext cmd);

// ****************************************

// **********< Lấy danh sách đơn hàng >**********
public:
    Q_INVOKABLE void requestOrderList(QVariantMap cmdData, const QString& keywword, const QString& dateBegin, const QString& dateEnd, int numOfOrder, int numPage);

signals:
    // for database thread
    void orderListRequested(cmdContext cmd, const QString& keyword, const QString& dateBegin, const QString& dateEnd, int numOfOrder, int numPage);
    // for UI
    void orderListReady(QList<QVariantMap> list, const QString& cmd);

public slots:
    void onOrderListReady(QList<QVariantMap> list, cmdContext cmd);

// ****************************************

};


#endif // APPCONTROLLER_H
