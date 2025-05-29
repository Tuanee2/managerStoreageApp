#include "customer.h"

Gender Customer::QStringToGender(const QString& gender){
    if(gender == "MALE") return Gender::MALE;
    if(gender == "FEMALE") return Gender::FEMALE;
    return Gender::UNKNOW;
}

QString Customer::GenderToQString(Gender gender){
    if(gender == Gender::MALE) return "MALE";
    if(gender == Gender::FEMALE) return "FEMALE";
    return "UNKNOW";
}

Customer::Customer(QObject *parent)
    : QObject{parent}
{}

Customer::Customer(const QString& name, const QString& phoneNumber, int yearOfBirth, Gender gender,  QObject *parent) : 
name(name), phoneNumber(phoneNumber), yearOfBirth(yearOfBirth), gender(gender) {}

Customer::Customer(const Customer &other) 
    : QObject(nullptr), 
    name(other.name),
    yearOfBirth(other.yearOfBirth),
    gender(other.gender),
    phoneNumber(other.phoneNumber) {}

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

int Customer::getCustomerYearOfBirth() const{
    return yearOfBirth;
}

void Customer::setCustomerYearOfBirth(int year){
    this->yearOfBirth = year;
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
