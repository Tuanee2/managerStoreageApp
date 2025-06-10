#ifndef ORDER_H
#define ORDER_H

#include <QObject>
#include <QString>
#include <QDateTime>
#include <QJsonObject>
#include "products.h"
#include <QJsonDocument>

class Order : public QObject
{
    Q_OBJECT
public:
    explicit Order(QObject *parent = nullptr);
    Order(const QString& customerName, const QString& phoneNumber, const QList<Products*>& item, const QDateTime& purchaseTime, const QString& note, QObject *parent = nullptr);
    Order(const Order& other);
    ~Order();

private:
    QString customerName;
    QString phoneNumber;
    QList<Products*> item;
    QDateTime purchaseTime;
    QString note;

public:
    QString getCustomerName() const;
    void setCustomerName(const QString& name);
    QString getCustomerPhoneNumber() const;
    void setCustomerPhoneNumber(const QString& phoneNumber);
    QDateTime getPurchaseTime() const;
    void setPurchaseTime(const QDateTime& time);
    QList<Products*>& getListItem();
    void setListItem(const QList<Products*>& item);
    QString getNote() const;
    void setNote(const QString& note);
    static QList<Products*> QStringToItems(const QString& data);
    static QString itemToQString(const QList<Products*>& item);
    double getTotalPrice() const;
    void clean();

    QJsonObject toJson() const;
    static Order* fromJson(const QJsonObject& obj);
};

#endif // ORDER_H
