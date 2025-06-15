#ifndef PRODUCTS_H
#define PRODUCTS_H

#include <QObject>
#include <QDateTime>
#include "batch.h"
#include "configcommand.h"

class Products : public QObject
{
    Q_OBJECT
    
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
    Unit getUnit() const;
    void setUnit(const QString& unit);
    double totalValue();
    bool getIsValue() const;
    void setIsValue(bool value);
    QString getDescription() const;
    void setDescription(const QString &des);
    void addBatch(const Batch& bat);
    int getNumOfItem();
    QList<Batch*>& getBatchList();
    void deleteBatchByImportTime(const QDateTime& time);
    void deleteBatchByExpiryDate(const QDateTime& time);

    QJsonObject toJson() const;
    static Products* fromJson(const QJsonObject& obj);

private:
    QString productName;
    QString productId;
    double cost;
    Unit unit;
    bool isValue;
    QString description;
    QList<Batch*> batches;
};

#endif // PRODUCTS_H
