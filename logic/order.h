#ifndef ORDER_H
#define ORDER_H

#include <QObject>
#include <QString>
#include <QDateTime>
#include "products.h"

class Order : public QObject
{
    Q_OBJECT
public:
    explicit Order(QObject *parent = nullptr);
    Order(const QString& customerName, const QList<Products*>& item, const QDateTime& purchaseTime, QObject *parent = nullptr);
    Order(const Order& other);
    ~Order();

private:
    QString customerName;
    QList<Products*> item;
    QDateTime purchaseTime;

public:
    QString getCustomerName() const;
    void setCustomerName(const QString& name);
    QDateTime getPurchaseTime() const;
    void setPurchaseTime(const QDateTime& time);
    QList<Products*> getListItem() const;
    void setListItem(const QList<Products*>& item);
    double getTotalPrice() const;
signals:
};

#endif // ORDER_H
