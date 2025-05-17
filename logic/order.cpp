#include "order.h"

Order::Order(QObject *parent)
    : QObject{parent}
{}

Order::Order(const QString& customerName, const QList<Products*>& item, const QDateTime& purchaseTime, QObject *parent) :
    customerName(customerName), item(item), purchaseTime(purchaseTime) {}

Order::Order(const Order& other){
    this->customerName = other.customerName;
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

QDateTime Order::getPurchaseTime() const{
    return purchaseTime;
}

void Order::setPurchaseTime(const QDateTime& time){
    this->purchaseTime = time;
}

QList<Products*> Order::getListItem() const{
    return item;
}

void Order::setListItem(const QList<Products*>& item){
    this->item = item;
}

double Order::getTotalPrice() const{
    double total = 0;
    for(Products* P : item){
        total += P->totalValue();
    }
    return total;
}