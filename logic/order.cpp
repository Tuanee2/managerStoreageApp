#include "order.h"
#include <QJsonObject>
#include <QJsonArray>

Order::Order(QObject *parent)
    : QObject{parent}
{}

Order::Order(const QString& customerName, const QString& phoneNumber, const QList<Products*>& item, const QDateTime& purchaseTime, QObject *parent) :
    customerName(customerName), phoneNumber(phoneNumber), item(item), purchaseTime(purchaseTime) {}

Order::Order(const Order& other){
    this->customerName = other.customerName;
    this->phoneNumber = other.phoneNumber;
    for (Products* p : other.item) {
        this->item.append(new Products(*p));  // dùng copy constructor của Products
    }
    this->purchaseTime = other.purchaseTime;
}

Order::~Order() {
    for (Products* p : item) {
        delete p;
    }
}

QString Order::getCustomerName() const{
    return customerName;
}

void Order::setCustomerName(const QString& name){
    this->customerName = name;
}

QString Order::getCustomerPhoneNumber() const{
    return phoneNumber;
}

void Order::setCustomerPhoneNumber(const QString& phoneNumber){
    this->phoneNumber = phoneNumber;
}

QDateTime Order::getPurchaseTime() const{
    return purchaseTime;
}

void Order::setPurchaseTime(const QDateTime& time){
    this->purchaseTime = time;
}

QList<Products*>& Order::getListItem(){
    return item;
}

void Order::setListItem(const QList<Products*>& item){
    this->item = item;
}

QList<Products*> Order::QStringToItems(const QString& data){
    QList<Products*> list;
    QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());
    if (!doc.isArray()) return list;

    QJsonArray array = doc.array();
    for (const QJsonValue& val : array) {
        if (val.isObject()) {
            list.append(Products::fromJson(val.toObject()));
        }
    }
    return list;
}

QString Order::itemToQString(const QList<Products*>& item){
    QJsonArray array;
    for (const Products* p : item) {
        array.append(p->toJson());
    }
    QJsonDocument doc(array);
    return QString::fromUtf8(doc.toJson(QJsonDocument::Compact));
}

double Order::getTotalPrice() const{
    double total = 0;
    for(Products* P : item){
        total += P->totalValue();
    }
    return total;
}

void Order::clean(){
    for(Products* p : item){
        for(Batch* b : p->getBatchList()){
            delete b;
        }
        p->getBatchList().clear();
        delete p;
    }
    item.clear();
    customerName = "";
    phoneNumber = "";
    purchaseTime = QDateTime();
}

QJsonObject Order::toJson() const {
    QJsonObject obj;
    obj["customerName"] = customerName;
    obj["phoneNumber"] = phoneNumber;
    obj["purchaseTime"] = purchaseTime.toString("dd-MM-yyyy");

    QJsonArray itemArray;
    for (const Products* p : item) {
        itemArray.append(p->toJson());
    }
    obj["items"] = itemArray;
    return obj;
}

Order* Order::fromJson(const QJsonObject& obj) {
    Order* o = new Order();
    o->setCustomerName(obj["customerName"].toString());
    o->setCustomerPhoneNumber(obj["phoneNumber"].toString());
    o->setPurchaseTime(QDateTime::fromString(obj["purchaseTime"].toString(), "dd-MM-yyyy"));

    QJsonArray itemArray = obj["items"].toArray();
    QList<Products*> list;
    for (const QJsonValue& val : itemArray) {
        list.append(Products::fromJson(val.toObject()));
    }
    o->setListItem(list);
    return o;
}