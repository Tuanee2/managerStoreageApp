#ifndef PRODUCTS_H
#define PRODUCTS_H

#include <QObject>
#include <QDateTime>
#include "batch.h"

class Products : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString productName READ getProductName WRITE setProductName NOTIFY productNameChanged)
    Q_PROPERTY(QString productId READ getProductId WRITE setProductId NOTIFY productIdChanged)
    Q_PROPERTY(double cost READ getCost WRITE setCost NOTIFY costChanged)
    Q_PROPERTY(bool isValue READ getIsValue WRITE setIsValue)
    Q_PROPERTY(QString description READ getDescription WRITE setDescription NOTIFY descriptionChanged)
    Q_PROPERTY(double totalValue READ totalValue)
    
public:
    explicit Products(QObject *parent = nullptr);
    Products(const QString &id, const QString &name, double price, bool value, const QString& des, QObject *parent = nullptr);
    Products(const Products &other);
    ~Products();

    QString getProductName() const;
    void setProductName(const QString &name);
    QString getProductId() const;
    void setProductId(const QString &id);
    double getCost() const;
    void setCost(double price);
    double totalValue();
    bool getIsValue() const;
    void setIsValue(bool value);
    QString getDescription() const;
    void setDescription(const QString &des);
    void addBatch(const Batch& bat);
    QList<Batch*> getBatchList() const;
    void deleteBatchByImportTime(const QDateTime& time);
    void deleteBatchByExpiryDate(const QDateTime& time);

private:
    QString productName;
    QString productId;
    double cost;
    bool isValue;
    QString description;
    QList<Batch*> batches;

signals:
    void productNameChanged(const QString &newName);
    void productIdChanged(const QString &newId);
    void numOfProductChanged(int newNum);
    void costChanged(double newCost);
    void descriptionChanged(const QString &des);
    void importTimeChanged(const QDateTime &time);
};

#endif // PRODUCTS_H
