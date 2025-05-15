#include "batch.h"

Batch::Batch() {}

Batch::Batch(int quantity, const QDateTime& importDate, const QDateTime& expiryDate)
    : quantity(quantity), importDate(importDate), expiryDate(expiryDate) {}

int Batch::getQuantity() const {
    return quantity;
}

void Batch::setQuantity(int num) {
    quantity = num;
}

QDateTime Batch::getImportDate() const {
    return importDate;
}

void Batch::setImportDate(const QDateTime& time) {
    importDate = time;
}

QDateTime Batch::getExpiryDate() const {
    return expiryDate;
}

void Batch::setExpiryDate(const QDateTime& time) {
    expiryDate = time;
}
