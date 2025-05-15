#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>
#include "storeage.h"
#include "configcommand.h"

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

// **********< thêm / sửa / xoá lô sản phẩm>
public:
    Q_INVOKABLE void requestBatchCommand(const QString& cmd, const QString& name, int num, const QString& importDate, const QString& expiredDate);

signals:
    // for database thread
    void batchCommand(cmdContext cmd, const QString& name, Batch batch);
    // for UI
    void batchCommandResult(bool done);
public slots:
    void onBatchCommandResult(bool done);

// ****************************************

// ****< Lấy thông tin các lô sản phẩm theo lệnh >****
public:
    Q_INVOKABLE void requestToTakeBatchInfo(const QString& name, const QString& type, const QString& cmd, const QString& duration);

signals:
    // for database thread
    void batchInfo(const QString& name, cmdContext context);
    //for UI
    void listOfBatch(QList<QVariantMap> list);

public slots:
    void onListOfBatch(QList<QVariantMap> list);

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

// ****************************************
};

#endif // APPCONTROLLER_H
