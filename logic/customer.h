#ifndef CUSTOMER_H
#define CUSTOMER_H

#include <QObject>
#include <QString>

class Customer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString customerName READ getCustomerName WRITE setCustomerName)
    Q_PROPERTY(QString customerPhoneNumber READ getCustomerPhoneNumber WRITE setCustomerPhoneNumber)
    Q_PROPERTY(int customerYearOfBirth READ getCustomerYearOfBirth WRITE setCustomerYearOfBirth)
    Q_PROPERTY(int customerAge READ getCustomerAge WRITE setCustomerAge)
    Q_PROPERTY(Gender customerGender READ getCustomerGender WRITE setCustomerGender)

public:
    typedef enum {
        MALE,
        FEMALE,
        UNKNOW
    } Gender;
    Q_ENUM(Gender)

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
    Q_INVOKABLE QString getCustomerName() const;
    Q_INVOKABLE void setCustomerName(const QString& name);
    Q_INVOKABLE QString getCustomerPhoneNumber() const;
    Q_INVOKABLE void setCustomerPhoneNumber(const QString& phoneNumber);
    Q_INVOKABLE int getCustomerYearOfBirth() const;
    Q_INVOKABLE void setCustomerYearOfBirth(int year);
    Q_INVOKABLE int getCustomerAge() const;
    Q_INVOKABLE void setCustomerAge(int age);
    Q_INVOKABLE Gender getCustomerGender() const;
    Q_INVOKABLE void setCustomerGender(Gender gender);
    Q_INVOKABLE Gender QStringToGender(const QString& gender);
    Q_INVOKABLE QString GenderToQString(Gender gender);
signals:
};

#endif // CUSTOMER_H

Q_DECLARE_METATYPE(Customer::Gender)
