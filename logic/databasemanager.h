#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QFile>
#include "products.h"
#include "customer.h"

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
    QList<Products*> getProductListByPrice(const QString& keyword);
    QList<Products*> getAProductByName(const QString& name);
    // ****************************************

    // ************< FOR BATCHES >**********
    bool addBatch(const QString& productName, const Batch& batch);
    QList<Batch*> getBatchByPage(const QString& productName, int numPage);
    QList<Batch*> getBatchByExpiredDate(const QString& productName, const QString& expiredDate, int numpage);

    double getNumOfItemOfAllBatch(const QString& productName);
    // ************************************

    // *********< FOR CUSTOMERS >**********
    bool insertCustomer(const Customer& customer);
    bool deleteCustomerByName(const QString& name);
    bool deleteCustomerByPhoneNumber(const QString& phoneNumber);
    bool checkCustomerPhoneNumberExists(const QString& phoneNumber);
    QList<Customer*> getCustomerByName(const QString& name); 
    QList<Customer*> getCustomerByPhoneNumber(const QString& phone);
    QList<Customer*> getCustomersByPage(int numPage);
    QList<Customer*> getCustomerByYearOfBirth(const QString& yearOfBirth);
    QList<Customer*> getACustomerByName(const QString& name);
    QList<Customer*> getACustomerByPhoneNumber(const QString& phone);
    QList<Customer*> getACustomerByYearOfBirth(const QString& yearOfBirth);
    // ************************************
};

#endif // DATABASEMANAGER_H
