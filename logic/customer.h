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

private:
    QString name;
    QString phoneNumber;
    int age = 0;
    Gender gender = Gender::UNKNOW;

public:
    QString getCustomerName() const;
    void setCustomerName(const QString& name);
    QString getCustomerPhoneNumber() const;
    void setCustomerPhoneNumber(const QString& phoneNumber);
    int getCustomerAge() const;
    void setCustomerAge(int age);
    Gender getCustomerGender() const;
    void setCustomerGender(Gender gender);
signals:
};

#endif // CUSTOMER_H
