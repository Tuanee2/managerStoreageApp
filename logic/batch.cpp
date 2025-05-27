#include "batch.h"
#include <QJsonObject>

Batch::Batch() {}

Batch::Batch(const QString& productName, int quantity, const QDateTime& importDate, const QDateTime& expiryDate)
    : productName(productName), quantity(quantity), importDate(importDate), expiryDate(expiryDate) {}

Batch::Batch(const Batch& other){
    this->productName = other.productName;
    this->quantity = other.quantity;
    this->cost = other.cost;
    this->importDate = other.importDate;
    this->expiryDate = other.expiryDate;
}

QString Batch::getProductName() const{
    return productName;
}

void Batch::setProductName(const QString& productName){
    this->productName = productName;
}

int Batch::getQuantity() const {
    return quantity;
}

void Batch::setQuantity(int num) {
    quantity = num;
}

double Batch::getCost() const{
    return cost;
}

void Batch::setCost(double cost){
    this->cost = cost;
}

QDateTime Batch::getImportDate() const {
    return importDate;
}

void Batch::setImportDate(const QDateTime& time) {
    importDate = time;
}

QDateTime Batch::getExpiryDate() const {
    return expiryDate;
}

void Batch::setExpiryDate(const QDateTime& time) {
    expiryDate = time;
}

QJsonObject Batch::toJson() const {
    QJsonObject obj;
    obj["quantity"] = quantity;
    obj["cost"] = cost;
    obj["importDate"] = importDate.toString("dd-MM-yyyy");
    obj["expiryDate"] = expiryDate.toString("dd-MM-yyyy");
    return obj;
}

Batch Batch::fromJson(const QJsonObject& obj) {
    Batch b;
    b.setQuantity(obj["quantity"].toInt());
    b.setCost(obj["cost"].toDouble());
    b.setImportDate(QDateTime::fromString(obj["importDate"].toString(), "dd-MM-yyyy"));
    b.setExpiryDate(QDateTime::fromString(obj["expiryDate"].toString(), "dd-MM-yyyy"));
    return b;
}
