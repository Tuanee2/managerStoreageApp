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
signals:
};

#endif // CUSTOMER_H
