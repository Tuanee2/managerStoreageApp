#include "products.h"

Products::Products(QObject *parent)
    : QObject{parent}
{}

Products::Products(const QString &id, const QString &name, double price, bool value, const QString& des, QObject *parent) : 
productId(id), productName(name), cost(price), isValue(value), description(des) {}

Products::Products(const Products &other)
    : QObject(nullptr),  // không copy parent!
    productId(other.productId),
    productName(other.productName),
    cost(other.cost),
    isValue(other.isValue) {}

QString Products::getProductName() const{
    return productName;
}

void Products::setProductName(const QString &name){
    if(productName != name){
        productName = name;
        emit productNameChanged(name);
    }
}

QString Products::getProductId() const {
    return productId;
}

void Products::setProductId(const QString &id){
    if(productId != id){
        productId = id;
        emit productIdChanged(id);
    }
}

double Products::getCost() const{
    return cost;
}

void Products::setCost(double price){
    if(cost != price){
        cost = price;
        emit costChanged(price);
    }
}

bool Products::getIsValue() const{
    return isValue;
}

void Products::setIsValue(bool value){
    isValue = value;
}

double Products::totalValue(){
    if(batches.size() != 0){
        int total = 0;
        for(int i = 0; i < batches.size(); i++){
            total += batches[i].getQuantity();
        }
        return static_cast<double>(total) * cost;;
    }
    return 0.0;
}

QString Products::getDescription() const{
    return description;
}

void Products::setDescription(const QString &des){
    if(description != des){
        description = des;
        emit descriptionChanged(des);
    }
}

void Products::addBatch(const Batch& bat){
    batches.append(bat);
}

void Products::deleteBatchByImportTime(const QDateTime& time) {
    for (int i = batches.size() - 1; i >= 0; --i) {
        if (batches[i].getImportDate() == time) {
            batches.removeAt(i);
        }
    }
}

void Products::deleteBatchByExpiryDate(const QDateTime& time) {
    for (int i = batches.size() - 1; i >= 0; --i) {
        if (batches[i].getExpiryDate() == time) {
            batches.removeAt(i);
        }
    }
}
