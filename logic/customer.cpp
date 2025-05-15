#include "customer.h"

Gender QStringToGender(const QString& gender){
    if(gender == "MALE") return Gender::MALE;
    if(gender == "FEMALE") return Gender::FEMALE;
    return Gender::UNKNOW;
}

QString GenderToQString(Gender gender){
    if(gender == Gender::MALE) return "MALE";
    if(gender == Gender::FEMALE) return "FEMALE";
    return "UNKNOW";
}

Customer::Customer(QObject *parent)
    : QObject{parent}
{}

QString Customer::getCustomerName() const {
    return name;
}

void Customer::setCustomerName(const QString& name) {
    this->name = name;
}

QString Customer::getCustomerPhoneNumber() const{
    return phoneNumber;
}

void Customer::setCustomerPhoneNumber(const QString& phoneNumber){
    this->phoneNumber = phoneNumber;
}

int Customer::getCustomerAge() const{
    return age;
}

void Customer::setCustomerAge(int age){
    this->age = age;
}

Gender Customer::getCustomerGender() const{
    return gender;
}

void Customer::setCustomerGender(Gender gender){
    this->gender = gender;
}
