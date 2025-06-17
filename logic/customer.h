#ifndef CUSTOMER_H
#define CUSTOMER_H

#include <QObject>
#include <QString>

typedef enum {
    MALE,
    FEMALE,
    UNKNOW
}Gender;

Gender QStringToGender(const QString& gender);
QString GenderToQString(Gender gender);


enum class Rank{
    BRONZE,
    SILVER,
    GOLD,
    PLATINUM,
    DIAMOND,
    RANK_INVALID
};

Rank QStringToRank(const QString& rank);
QString rankToQString(Rank rank);

enum class Debt{
    NO_DEBT,
    DEBT_BY_DATE,
    DEBT_BY_SEASON,
    INVALID
};

Debt QStringToDebt(const QString& debt);
QString debtToQString(Debt debt);

class Customer : public QObject
{
    Q_OBJECT
public:
    explicit Customer(QObject *parent = nullptr);
    Customer(const QString& name, const QString& phoneNumber, int yearOfBirth, Gender gender, QObject *parent = nullptr);
    Customer(const Customer &other);

private:
    QString name;
    QString phoneNumber;
    int yearOfBirth;
    int age = 0;
    Gender gender = Gender::UNKNOW;
    int rewardPoints;
    Rank rank;
    int debtPoints;
    Debt debt;

public:
    QString getCustomerName() const;
    void setCustomerName(const QString& name);
    QString getCustomerPhoneNumber() const;
    void setCustomerPhoneNumber(const QString& phoneNumber);
    int getCustomerYearOfBirth() const;
    void setCustomerYearOfBirth(int year);
    int getCustomerAge() const;
    void setCustomerAge(int age);
    Gender getCustomerGender() const;
    void setCustomerGender(Gender gender);
    int getCustomerRewardPoints() const;
    void setCustomerRewardPoints(int reward);
    Rank getRank() const;
    void setRank(const QString& rank);
    int getDebtPoints() const;
    void setDebtPoints(int points);
    Debt getDebtStatus() const;
    void setDebtStatus(const QString& status);

};

#endif // CUSTOMER_H
