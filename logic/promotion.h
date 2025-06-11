#ifndef PROMOTION_H
#define PROMOTION_H

#include <QObject>
#include "batch.h"

class Promotion : public QObject
{
    Q_OBJECT
public:
    explicit Promotion(QObject *parent = nullptr);

    static void apply(const Batch* batch);

signals:
};

#endif // PROMOTION_H
