#ifndef BATCH_H
#define BATCH_H
#include <QDateTime>
#include <QJsonObject>

class Batch
{
public:
    Batch();
    Batch(const QString& productName, int quantity, const QDateTime& importDate, const QDateTime& expiryDate);
    Batch(const Batch& other);

    QString getProductName() const;
    void setProductName(const QString& productName);

    int getQuantity() const;
    void setQuantity(int num);

    double getCost() const;
    void setCost(double cost);

    QDateTime getImportDate() const;
    void setImportDate(const QDateTime& time);

    QDateTime getExpiryDate() const;
    void setExpiryDate(const QDateTime& time);

    QJsonObject toJson() const;
    static Batch fromJson(const QJsonObject& obj);

private:
    QString productName;
    int quantity = 0;
    double cost = 0;
    QDateTime importDate;
    QDateTime expiryDate;
};

#endif // BATCH_H
