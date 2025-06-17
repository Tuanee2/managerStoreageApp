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

Rank QStringToRank(const QString& rank){
    if(rank == "BRONZE"){
        return Rank::BRONZE;
    }else if(rank == "SILVER"){
        return Rank::SILVER;
    }else if(rank == "GOLD"){
        return Rank::GOLD;
    }else if(rank == "PLATINUM"){
        return Rank::PLATINUM;
    }else if(rank == "DIAMOND"){
        return Rank::DIAMOND;
    }else{
        return Rank::RANK_INVALID;
    }
}

QString rankToQString(Rank rank){
    if(rank == Rank::BRONZE){
        return "BRONZE";
    }else if(rank == Rank::SILVER){
        return "SILVER";
    }else if(rank == Rank::GOLD){
        return "GOLD";
    }else if(rank == Rank::PLATINUM){
        return "PLATINUM";
    }else if(rank == Rank::DIAMOND){
        return "DIAMOND";
    }else{
        return "RANK_INVALID";
    }
}

QString rankForShow(Rank rank){
    if(rank == Rank::BRONZE){
        return "Đồng";
    }else if(rank == Rank::SILVER){
        return "Bạc";
    }else if(rank == Rank::GOLD){
        return "Đồng";
    }else if(rank == Rank::PLATINUM){
        return "Bạc Kim";
    }else if(rank == Rank::DIAMOND){
        return "Kim Cương";
    }else{
        return "Không xác định";
    }
}

Debt QStringToDebt(const QString& debt){
    if(debt == "NO_DEBT") return Debt::NO_DEBT;
    if(debt == "DEBT_BY_DATE") return Debt::DEBT_BY_DATE;
    if(debt == "DEBT_BY_SEASON") return Debt::DEBT_BY_SEASON;
    return Debt::INVALID;
}

QString debtToQString(Debt debt){
    switch(debt) {
        case Debt::NO_DEBT: return "NO_DEBT";
        case Debt::DEBT_BY_DATE: return "DEBT_BY_DATE";
        case Debt::DEBT_BY_SEASON: return "DEBT_BY_SEASON";
        default: return "INVALID";
    }
}

QString debtForShow(Debt debt){
    switch(debt) {
        case Debt::NO_DEBT: return "Không nợ";
        case Debt::DEBT_BY_DATE: return "Nợ ngày";
        case Debt::DEBT_BY_SEASON: return "Nợ mùa";
        default: return "INVALID";
    }
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

int Customer::getCustomerRewardPoints() const{
    return rewardPoints;
}

void Customer::setCustomerRewardPoints(int reward){
    rewardPoints = reward;
}

Rank Customer::getRank() const{
    return rank;
}

void Customer::setRank(const QString& rank){
    this->rank = QStringToRank(rank);
}

int Customer::getDebtPoints() const{
    return debtPoints;
}

void Customer::setDebtPoints(int points){
    this->debtPoints = points;
}

Debt Customer::getDebtStatus() const{
    return debt;
}

void Customer::setDebtStatus(const QString& status){
    this->debt = QStringToDebt(status);
}