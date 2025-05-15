#ifndef STOREAGE_H
#define STOREAGE_H

#include <QObject>
#include "products.h"
#include <QHash>
#include "databasemanager.h"
#include "configcommand.h"

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
    void handleProductCommand(Products pro, cmdContext cmd);

signals:
    void productCommandResult(bool done);

// **********************************************

// ****< Lấy danh sách sản phẩm >****
// tính năng:
// +) Tìm kiếm
// +) Liệt kê

public slots:
    void handleProductListRequest(Cmd cmd, const QString& keyword, int numPage);

signals:
    void productListReady(QList<QVariantMap> list, Cmd cmd);

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
    void handleBatchListRequest(cmdContext cmd, const QString& productName, int numPage);
signals:
    void batchListReady(QList<QVariantMap> list, cmdContext cmd);
};

// ****************************************

#endif // STOREAGE_H
