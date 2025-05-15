#ifndef CUSTOMER_H
#define CUSTOMER_H

#include <QObject>

class customer : public QObject
{
    Q_OBJECT
public:
    explicit customer(QObject *parent = nullptr);

signals:
};

#endif // CUSTOMER_H
