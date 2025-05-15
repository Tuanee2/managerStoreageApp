#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QFile>
#include "products.h"

class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);
    QSqlDatabase db;
    bool initialize();
    bool insertProduct(const Products& product);
    bool checkProductNameExists(const QString& name);

    // ****< xoá sản phẩm >****
    bool deleteProduct(const QString& pro);
    
    // ****************************************

    // ****< Lấy danh sách sản phẩm >****
    QList<Products*> getProductsByPage(int numPage);
    QList<Products*> getProductListByName(const QString& keyword);
    QList<Products*> getAProductByName(const QString& name);
    // ****************************************

    //
    bool addBatch(const QString& productName, const Batch& batch);
    QList<Batch*> getBatchByPage(const QString& productName, int numPage);
    //

};

#endif // DATABASEMANAGER_H
