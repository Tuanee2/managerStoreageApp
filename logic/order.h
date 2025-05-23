#ifndef ORDER_H
#define ORDER_H

#include <QObject>
#include <QString>
#include <QDateTime>
#include <QJsonObject>
#include "products.h"

class Order : public QObject
{
    Q_OBJECT
public:
    explicit Order(QObject *parent = nullptr);
    Order(const QString& customerName, const QString& phoneNumber, const QList<Products*>& item, const QDateTime& purchaseTime, QObject *parent = nullptr);
    Order(const Order& other);
    ~Order();

private:
    QString customerName;
    QString phoneNumber;
    QList<Products*> item;
    QDateTime purchaseTime;

public:
    QString getCustomerName() const;
    void setCustomerName(const QString& name);
    QString getCustomerPhoneNumber() const;
    void setCustomerPhoneNumber(const QString& phoneNumber);
    QDateTime getPurchaseTime() const;
    void setPurchaseTime(const QDateTime& time);
    QList<Products*> getListItem() const;
    void setListItem(const QList<Products*>& item);
    static QList<Products*> QStringToItems(const QString& data);
    double getTotalPrice() const;
    void clean();

    QJsonObject toJson() const;
    static Order* fromJson(const QJsonObject& obj);

signals:
};

#endif // ORDER_H
