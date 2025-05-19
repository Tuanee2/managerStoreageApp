#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>
#include "storeage.h"
#include "configcommand.h"
#include "customer.h"
#include "order.h"

class appcontroller : public QObject
{
    Q_OBJECT
public:
    explicit appcontroller(storeage* store, QObject *parent = nullptr);

private:
    storeage* m_store;

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

// **********< Lấy danh sách sản phẩm >**********
public:
    Q_INVOKABLE void requestProductList(const QString& cmd, const QString& keyword, int numPage);

signals:
    // for database thread
    void productListRequested(Cmd cmd, const QString& keyword, int numPage);
    // for UI
    void productListReady(QList<QVariantMap> list, const QString cmd);

public slots:
    void onProductListReady(QList<QVariantMap> list, Cmd cmd);

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

// *********< Lấy danh sách các lô sản phẩm >*********
public: 
    Q_INVOKABLE void requestBatchList(const QString& cmd, const QString& productName, int numPage);
signals:
    // for database thread
    void batchListRequested(cmdContext cmd, const QString& name, int numPage);
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
    Q_INVOKABLE void requestCustomerList(const QString& cmd, const QString& keyword,int numPage);

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
    Q_INVOKABLE void requestOrderCommand(const QString& cmd, const QString& phoneNumber, const QString& dateExport, const QString& data);

signals:
    // for database thread
    void orderCommand(cmdContext cmd, const QString& phoneNumber, Order order);
    // for UI
    void orderCommandResult(bool done, const QString& cmd);

public slots:
    void onOrderCommandResult(bool done, cmdContext cmd);

// ****************************************

// *********< Lấy danh sách đơn hàng >*********
public:
    Q_INVOKABLE void requestOrderList(const QString& cmd, const QString& dateBegin, const QString& dateEnd, int numPage);

signals:
    // for database thread
    void orderListRequested(cmdContext cmd, const QString& dateBegin, const QString& dateEnd, int numPage);
    // for UI
    void orderListReady(QList<QVariantMap> list, const QString& cmd);

public slots:
    void onOrderListReady(QList<QVariantMap> list, cmdContext cmd);

// ****************************************

};


#endif // APPCONTROLLER_H
