#ifndef STOREAGE_H
#define STOREAGE_H

#include <QObject>
#include "products.h"
#include <QHash>
#include "databasemanager.h"
#include "configcommand.h"
#include "customer.h"
#include "order.h"

class storeage : public QObject
{
    Q_OBJECT
public:
    explicit storeage(QObject *parent = nullptr);
    Q_INVOKABLE void initialize();

private:
    QHash<QString, Products*> store;
    DatabaseManager* db; 

// ****< Kiểm tra tên trùng lặp >****
public slots:
    void handleCheckProductName(const QString& name);

signals: 
    void productNameCheckResult(bool exists);

// ****************************************

// **********< Thêm/ sửa/ xoá sản phẩm >*********
public slots:
    void handleProductCommand(BaseCommand cmd);

signals:
    void productCommandResult(bool done, BaseCommand cmd);

// **********************************************

// ****< Lấy danh sách sản phẩm >****
// tính năng:
// +) Tìm kiếm
// +) Liệt kê

public slots:
    void handleProductListRequest(BaseCommand cmd);

signals:
    void productListReady(QList<QVariantMap> list, BaseCommand cmd);

// ****************************************

public slots:
    Products* sreachProduct(const QString& id);
    Products* sreachProductByName(const QString& name);
    int totalProductTypes() const;

signals:
    void productCountChanged(int newCount);
    void requestInsertProduct(Products product);


// <<<<<<<<<< FOR BATCHES >>>>>>>>>>
public slots:
    void handleBatchCommand(cmdContext cmd, const QString& name, Batch batch);
signals:
    void batchCommandResult(bool done);

public slots:
    void handleBatchInfoRequest(cmdContext cmd, const QString& productName);
signals:
    void batchInfoResult(double result, cmdContext cmd);

public slots:
    void handleBatchListRequest(cmdContext cmd, const QString& productName, const QString& keyword, int numOfBatch, int numPage);
signals:
    void batchListReady(QList<QVariantMap> list, cmdContext cmd);

// ****************************************



// <<<<<<<<<< FOR CUSTOMER >>>>>>>>>>
public slots:
    void handleCustomerCommand(cmdContext cmd, Customer customer);
signals:
    void customerCommandResult(bool done, cmdContext cmd);

public slots:
    void handleCustomerListRequest(cmdContext cmd, const QString& keyword, int numPage);
signals:
    void customerListReady(QList<QVariantMap> list, cmdContext cmd);
    
// ****************************************





// <<<<<<<<<< FOR ORDER >>>>>>>>>>
public slots:
    void handleOrderCommand(cmdContext cmd, const QJsonObject& data);
signals:
    void orderCommandResult(bool done, cmdContext cmd);

public slots:
    void handleOrderListRequest(cmdContext cmd, const QString& keyword, const QString& dateBegin, const QString& dateEnd, int numOfOrder, int numPage);
signals:
    void orderListReady(QList<QVariantMap> list, cmdContext cmd);
// ****************************************





// <<<<<<<<<< FOR ARRANGE >>>>>>>>>>
public:
    void arrangeForDayLeft(QList<QVariantMap>& list); 

};




#endif // STOREAGE_H
