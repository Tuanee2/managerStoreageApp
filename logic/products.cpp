#include "products.h"
#include <QJsonArray>

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

Products::~Products(){
    for(Batch* b : batches){
        delete b;
    }
}

QString Products::getProductName() const{
    return productName;
}

void Products::setProductName(const QString &name){
    if(productName != name){
        productName = name;
    }
}

QString Products::getProductId() const {
    return productId;
}

void Products::setProductId(const QString &id){
    if(productId != id){
        productId = id;
    }
}

double Products::getCost() const{
    return cost;
}

void Products::setCost(double price){
    if(cost != price){
        cost = price;
    }
}

Unit Products::getUnit() const{
    return unit;
}
void Products::setUnit(const QString& unit){
    this->unit = QStringToUnit(unit);
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
            total += batches[i]->getQuantity();
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
    }
}

void Products::addBatch(const Batch& bat){
    batches.append(new Batch(bat));
}

int Products::getNumOfItem(){
    int num = 0;
    for(Batch* b : batches){
        num += b->getQuantity();
    }
    return num;
}

QList<Batch*>& Products::getBatchList(){
    return batches;
}

void Products::deleteBatchByImportTime(const QDateTime& time) {
    for (int i = batches.size() - 1; i >= 0; --i) {
        if (batches[i]->getImportDate() == time) {
            batches.removeAt(i);
        }
    }
}

void Products::deleteBatchByExpiryDate(const QDateTime& time) {
    for (int i = batches.size() - 1; i >= 0; --i) {
        if (batches[i]->getExpiryDate() == time) {
            batches.removeAt(i);
        }
    }
}



QJsonObject Products::toJson() const {
    QJsonObject obj;
    obj["productName"] = productName;
    obj["productId"] = productId;
    obj["cost"] = cost;
    obj["isValue"] = isValue;
    obj["description"] = description;

    QJsonArray batchArray;
    for (const Batch* b : batches) {
        batchArray.append(b->toJson());
    }
    obj["batches"] = batchArray;
    return obj;
}

Products* Products::fromJson(const QJsonObject& obj) {
    Products* p = new Products();
    p->setProductName(obj["productName"].toString());
    p->setProductId(obj["productId"].toString());
    p->setCost(obj["cost"].toDouble());
    p->setIsValue(obj["isValue"].toBool());
    p->setDescription(obj["description"].toString());

    QJsonArray batchArray = obj["batches"].toArray();
    for (const QJsonValue& val : batchArray) {
        p->addBatch(Batch::fromJson(val.toObject()));
    }

    return p;
}
