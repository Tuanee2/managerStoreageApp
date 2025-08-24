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
#include "order.h"
#include "configcommand.h"

class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);
    QSqlDatabase db;
    QSqlDatabase supabaseDb;
    bool initialize();
    bool insertProduct(const Products& product);
    bool checkProductNameExists(const QString& name);
    bool updateProduct(const Products& product, const QString& name);

    // ****< xoá sản phẩm >****
    bool deleteProduct(const QString& pro);
    
    // ****************************************

    // ****< Lấy danh sách sản phẩm >****
    QList<Products*> getProductsByPage(int productPerPage, int numPage);
    QList<Products*> getProductListByName(const QString& keyword);
    QList<Products*> getProductListByPrice(const QString& keyword);
    QList<Products*> getAProductByName(const QString& name);
    // ****************************************

    // ************< FOR BATCHES >**********
    bool addBatch(const QString& productName, const Batch& batch);
    bool updateBatch(const QString& productName, const Batch& batch);
    QList<Batch*> getBatchByPage(const QString& productName, int numPage);
    QList<Batch*> getBatchByExpiredDate(const QString& productName, const QDateTime& expiredDate, int numOfBatch, int numpage);

    double getNumOfItemOfAllBatch(const QString& productName);
    double getNumOfALLBatchExpired(const QDateTime& time);
    // ************************************

    // *********< FOR CUSTOMERS >**********
    bool insertCustomer(const Customer& customer);
    bool deleteCustomerByName(const QString& name);
    bool deleteCustomerByPhoneNumber(const QString& phoneNumber);
    bool checkCustomerPhoneNumberExists(const QString& phoneNumber);
    QList<Customer*> getCustomerByName(const QString& name); 
    QList<Customer*> getCustomerByPhoneNumber(const QString& phone);
    QList<Customer*> getCustomersByPage(int peoplePerPage, int numPage);
    QList<Customer*> getCustomerByYearOfBirth(const QString& yearOfBirth);
    QList<Customer*> getACustomerByName(const QString& name);
    QList<Customer*> getACustomerByPhoneNumber(const QString& phone);
    QList<Customer*> getACustomerByYearOfBirth(const QString& yearOfBirth);
    // ************************************

    // **********< FOR ORDERS >**********
    bool insertOrder(Order& order);
    bool deleteOrder(const QString& customerName, const QString& phoneNumber, const QDateTime& purchaseTime);
    QList<Order*> getOrder(const QString& customerName, const QString& phoneNumber, const QDateTime& purchaseTime, int numOfOrder, int numpag);
    QList<Order*> getOrderByPage(cmdContext cmd, const QString& keyword, int numOfOrder,int numpage);
    Order* getOrderById(const QString& id);
    QList<Order*> getOrderByPeriod(const QString& customerName, const QString& phoneNumber, int numOfOrder,int numpage);
    QList<Order*> getOrderByCustomCommand(BaseCommand command);
    QList<QVariantMap> getOrderProfitAndRevenue(const QString& dateBegin, const QString& dateEnd, Duration duration, bool isDescending);
    // ************************************

    bool connectToSupabase();
    bool testInsert();
    // void addToSyncLog(const QString &tableName, const QString &recordId, const QString &action);
    // void syncToSupabase();
};

#endif // DATABASEMANAGER_H
