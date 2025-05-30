/****************************************************************************
** Meta object code from reading C++ file 'appcontroller.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../logic/appcontroller.h"
#include <QtCore/qmetatype.h>
#include <QtCore/QList>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'appcontroller.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.8.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN13appcontrollerE_t {};
} // unnamed namespace


#ifdef QT_MOC_HAS_STRINGDATA
static constexpr auto qt_meta_stringdata_ZN13appcontrollerE = QtMocHelpers::stringData(
    "appcontroller",
    "requestCommandOrderResult_UI",
    "",
    "result",
    "cmd",
    "requestCommandBatchToOrderResult_UI",
    "orderUpdateResult_UI",
    "QList<QVariantMap>",
    "list",
    "checkProductNameConflictSignal",
    "name",
    "productNameChecked",
    "exists",
    "productCommand",
    "Products",
    "pro",
    "cmdContext",
    "productCommandResult",
    "done",
    "productListRequested",
    "keyword",
    "numPage",
    "productListReady",
    "batchCommand",
    "Batch",
    "batch",
    "batchCommandResult",
    "batchInfoRequested",
    "productName",
    "batchInfoResult",
    "type",
    "batchListRequested",
    "numOfBatch",
    "batchListReady",
    "customerCommand",
    "Customer",
    "customer",
    "customerCommandResult",
    "customerListRequested",
    "customerListReady",
    "orderCommandRequested",
    "data",
    "orderCommandResult",
    "orderListRequested",
    "dateBegin",
    "dateEnd",
    "numOfOrder",
    "orderListReady",
    "onProductNameChecked",
    "onProductCommandResult",
    "onProductListReady",
    "onBatchCommandResult",
    "onBatchInfoResult",
    "onBatchListReady",
    "onCustomerCommandResult",
    "onCustomerListReady",
    "onOrderCommandResult",
    "onOrderListReady",
    "requestCommandOrder_UI",
    "requestCommandBatchToOrder_UI",
    "costOfProduct",
    "QVariantList",
    "batchList",
    "orderUpdate_UI",
    "checkProductNameConflict",
    "requestProductCommand",
    "id",
    "price",
    "isValue",
    "des",
    "requestProductList",
    "cmdExtension",
    "requestBatchCommand",
    "num",
    "cost",
    "importDate",
    "expiredDate",
    "requestBatchInformation",
    "typelist",
    "duration",
    "requestBatchList",
    "requestCustomerCommand",
    "yearOfBirth",
    "gender",
    "phoneNumber",
    "requestCustomerList",
    "requestOrderCommand",
    "dateExport",
    "requestOrderList",
    "keywword"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA

Q_CONSTINIT static const uint qt_meta_data_ZN13appcontrollerE[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
      49,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      23,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    2,  308,    2, 0x06,    1 /* Public */,
       5,    2,  313,    2, 0x06,    4 /* Public */,
       6,    1,  318,    2, 0x06,    7 /* Public */,
       9,    1,  321,    2, 0x06,    9 /* Public */,
      11,    1,  324,    2, 0x06,   11 /* Public */,
      13,    2,  327,    2, 0x06,   13 /* Public */,
      17,    1,  332,    2, 0x06,   16 /* Public */,
      19,    3,  335,    2, 0x06,   18 /* Public */,
      22,    2,  342,    2, 0x06,   22 /* Public */,
      23,    3,  347,    2, 0x06,   25 /* Public */,
      26,    1,  354,    2, 0x06,   29 /* Public */,
      27,    2,  357,    2, 0x06,   31 /* Public */,
      29,    2,  362,    2, 0x06,   34 /* Public */,
      31,    5,  367,    2, 0x06,   37 /* Public */,
      33,    2,  378,    2, 0x06,   43 /* Public */,
      34,    2,  383,    2, 0x06,   46 /* Public */,
      37,    2,  388,    2, 0x06,   49 /* Public */,
      38,    3,  393,    2, 0x06,   52 /* Public */,
      39,    2,  400,    2, 0x06,   56 /* Public */,
      40,    2,  405,    2, 0x06,   59 /* Public */,
      42,    2,  410,    2, 0x06,   62 /* Public */,
      43,    6,  415,    2, 0x06,   65 /* Public */,
      47,    2,  428,    2, 0x06,   72 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
      48,    1,  433,    2, 0x0a,   75 /* Public */,
      49,    1,  436,    2, 0x0a,   77 /* Public */,
      50,    2,  439,    2, 0x0a,   79 /* Public */,
      51,    1,  444,    2, 0x0a,   82 /* Public */,
      52,    2,  447,    2, 0x0a,   84 /* Public */,
      53,    2,  452,    2, 0x0a,   87 /* Public */,
      54,    2,  457,    2, 0x0a,   90 /* Public */,
      55,    2,  462,    2, 0x0a,   93 /* Public */,
      56,    2,  467,    2, 0x0a,   96 /* Public */,
      57,    2,  472,    2, 0x0a,   99 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      58,    1,  477,    2, 0x02,  102 /* Public */,
      59,    4,  480,    2, 0x02,  104 /* Public */,
      63,    0,  489,    2, 0x02,  109 /* Public */,
      64,    1,  490,    2, 0x02,  110 /* Public */,
      65,    6,  493,    2, 0x02,  112 /* Public */,
      70,    3,  506,    2, 0x02,  119 /* Public */,
      70,    4,  513,    2, 0x02,  123 /* Public */,
      72,    6,  522,    2, 0x02,  128 /* Public */,
      77,    4,  535,    2, 0x02,  135 /* Public */,
      80,    6,  544,    2, 0x02,  140 /* Public */,
      81,    5,  557,    2, 0x02,  147 /* Public */,
      85,    3,  568,    2, 0x02,  153 /* Public */,
      85,    4,  575,    2, 0x02,  157 /* Public */,
      86,    3,  584,    2, 0x02,  162 /* Public */,
      88,    5,  591,    2, 0x02,  166 /* Public */,
      88,    6,  602,    2, 0x02,  172 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Bool, QMetaType::QString,    3,    4,
    QMetaType::Void, QMetaType::Bool, QMetaType::QString,    3,    4,
    QMetaType::Void, 0x80000000 | 7,    8,
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::Void, QMetaType::Bool,   12,
    QMetaType::Void, 0x80000000 | 14, 0x80000000 | 16,   15,    4,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Void, 0x80000000 | 16, QMetaType::QString, QMetaType::Int,    4,   20,   21,
    QMetaType::Void, 0x80000000 | 7, QMetaType::QString,    8,    4,
    QMetaType::Void, 0x80000000 | 16, QMetaType::QString, 0x80000000 | 24,    4,   10,   25,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Void, 0x80000000 | 16, QMetaType::QString,    4,   28,
    QMetaType::Void, QMetaType::Double, QMetaType::QString,    3,   30,
    QMetaType::Void, 0x80000000 | 16, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int,    4,   28,   20,   32,   21,
    QMetaType::Void, 0x80000000 | 7, QMetaType::QString,    8,    4,
    QMetaType::Void, 0x80000000 | 16, 0x80000000 | 35,    4,   36,
    QMetaType::Void, QMetaType::Bool, QMetaType::QString,   18,    4,
    QMetaType::Void, 0x80000000 | 16, QMetaType::QString, QMetaType::Int,    4,   20,   21,
    QMetaType::Void, 0x80000000 | 7, QMetaType::QString,    8,    4,
    QMetaType::Void, 0x80000000 | 16, QMetaType::QJsonObject,    4,   41,
    QMetaType::Void, QMetaType::Bool, QMetaType::QString,   18,    4,
    QMetaType::Void, 0x80000000 | 16, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int,    4,   20,   44,   45,   46,   21,
    QMetaType::Void, 0x80000000 | 7, QMetaType::QString,    8,    4,

 // slots: parameters
    QMetaType::Void, QMetaType::Bool,   12,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Void, 0x80000000 | 7, 0x80000000 | 16,    8,    4,
    QMetaType::Void, QMetaType::Bool,   18,
    QMetaType::Void, QMetaType::Double, 0x80000000 | 16,    3,    4,
    QMetaType::Void, 0x80000000 | 7, 0x80000000 | 16,    8,    4,
    QMetaType::Void, QMetaType::Bool, 0x80000000 | 16,   18,    4,
    QMetaType::Void, 0x80000000 | 7, 0x80000000 | 16,    8,    4,
    QMetaType::Void, QMetaType::Bool, 0x80000000 | 16,   18,    4,
    QMetaType::Void, 0x80000000 | 7, 0x80000000 | 16,    8,    4,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,    4,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int, 0x80000000 | 61,    4,   28,   60,   62,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Double, QMetaType::Bool, QMetaType::QString,    4,   66,   10,   67,   68,   69,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int,    4,   20,   21,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Int,    4,   71,   20,   21,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Double, QMetaType::QString, QMetaType::QString,    4,   10,   73,   74,   75,   76,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,   30,   78,   79,   28,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int,    4,   71,   28,   20,   32,   21,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::QString, QMetaType::QString,    4,   10,   82,   83,   84,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int,    4,   20,   21,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Int,    4,   71,   20,   21,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    4,   84,   87,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int,    4,   44,   45,   46,   21,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int,    4,   89,   44,   45,   46,   21,

       0        // eod
};

Q_CONSTINIT const QMetaObject appcontroller::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ZN13appcontrollerE.offsetsAndSizes,
    qt_meta_data_ZN13appcontrollerE,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_tag_ZN13appcontrollerE_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<appcontroller, std::true_type>,
        // method 'requestCommandOrderResult_UI'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'requestCommandBatchToOrderResult_UI'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'orderUpdateResult_UI'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        // method 'checkProductNameConflictSignal'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'productNameChecked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'productCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<Products, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'productCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'productListRequested'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'productListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString, std::false_type>,
        // method 'batchCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<Batch, std::false_type>,
        // method 'batchCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'batchInfoRequested'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'batchInfoResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'batchListRequested'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'batchListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'customerCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<Customer, std::false_type>,
        // method 'customerCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'customerListRequested'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'customerListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'orderCommandRequested'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QJsonObject &, std::false_type>,
        // method 'orderCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'orderListRequested'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'orderListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'onProductNameChecked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'onProductCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'onProductListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'onBatchCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'onBatchInfoResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'onBatchListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'onCustomerCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'onCustomerListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'onOrderCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'onOrderListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'requestCommandOrder_UI'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'requestCommandBatchToOrder_UI'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QVariantList &, std::false_type>,
        // method 'orderUpdate_UI'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'checkProductNameConflict'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'requestProductCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'requestProductList'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'requestProductList'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'requestBatchCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'requestBatchInformation'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'requestBatchList'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'requestCustomerCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'requestCustomerList'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'requestCustomerList'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'requestOrderCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'requestOrderList'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'requestOrderList'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>
    >,
    nullptr
} };

void appcontroller::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<appcontroller *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->requestCommandOrderResult_UI((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 1: _t->requestCommandBatchToOrderResult_UI((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 2: _t->orderUpdateResult_UI((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1]))); break;
        case 3: _t->checkProductNameConflictSignal((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 4: _t->productNameChecked((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 5: _t->productCommand((*reinterpret_cast< std::add_pointer_t<Products>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 6: _t->productCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 7: _t->productListRequested((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3]))); break;
        case 8: _t->productListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 9: _t->batchCommand((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<Batch>>(_a[3]))); break;
        case 10: _t->batchCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 11: _t->batchInfoRequested((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 12: _t->batchInfoResult((*reinterpret_cast< std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 13: _t->batchListRequested((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[5]))); break;
        case 14: _t->batchListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 15: _t->customerCommand((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<Customer>>(_a[2]))); break;
        case 16: _t->customerCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 17: _t->customerListRequested((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3]))); break;
        case 18: _t->customerListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 19: _t->orderCommandRequested((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2]))); break;
        case 20: _t->orderCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 21: _t->orderListRequested((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[6]))); break;
        case 22: _t->orderListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 23: _t->onProductNameChecked((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 24: _t->onProductCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 25: _t->onProductListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 26: _t->onBatchCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 27: _t->onBatchInfoResult((*reinterpret_cast< std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 28: _t->onBatchListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 29: _t->onCustomerCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 30: _t->onCustomerListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 31: _t->onOrderCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 32: _t->onOrderListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 33: _t->requestCommandOrder_UI((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 34: _t->requestCommandBatchToOrder_UI((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QVariantList>>(_a[4]))); break;
        case 35: _t->orderUpdate_UI(); break;
        case 36: _t->checkProductNameConflict((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 37: _t->requestProductCommand((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<bool>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[6]))); break;
        case 38: _t->requestProductList((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3]))); break;
        case 39: _t->requestProductList((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4]))); break;
        case 40: _t->requestBatchCommand((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[6]))); break;
        case 41: _t->requestBatchInformation((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4]))); break;
        case 42: _t->requestBatchList((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[6]))); break;
        case 43: _t->requestCustomerCommand((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[5]))); break;
        case 44: _t->requestCustomerList((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3]))); break;
        case 45: _t->requestCustomerList((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4]))); break;
        case 46: _t->requestOrderCommand((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
        case 47: _t->requestOrderList((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[5]))); break;
        case 48: _t->requestOrderList((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[6]))); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _q_method_type = void (appcontroller::*)(bool , const QString & );
            if (_q_method_type _q_method = &appcontroller::requestCommandOrderResult_UI; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(bool , const QString & );
            if (_q_method_type _q_method = &appcontroller::requestCommandBatchToOrderResult_UI; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(QList<QVariantMap> );
            if (_q_method_type _q_method = &appcontroller::orderUpdateResult_UI; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(const QString & );
            if (_q_method_type _q_method = &appcontroller::checkProductNameConflictSignal; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(bool );
            if (_q_method_type _q_method = &appcontroller::productNameChecked; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 4;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(Products , cmdContext );
            if (_q_method_type _q_method = &appcontroller::productCommand; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 5;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(bool );
            if (_q_method_type _q_method = &appcontroller::productCommandResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 6;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(cmdContext , const QString & , int );
            if (_q_method_type _q_method = &appcontroller::productListRequested; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 7;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(QList<QVariantMap> , const QString );
            if (_q_method_type _q_method = &appcontroller::productListReady; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 8;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(cmdContext , const QString & , Batch );
            if (_q_method_type _q_method = &appcontroller::batchCommand; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 9;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(bool );
            if (_q_method_type _q_method = &appcontroller::batchCommandResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 10;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(cmdContext , const QString & );
            if (_q_method_type _q_method = &appcontroller::batchInfoRequested; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 11;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(double , const QString & );
            if (_q_method_type _q_method = &appcontroller::batchInfoResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 12;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(cmdContext , const QString & , const QString & , int , int );
            if (_q_method_type _q_method = &appcontroller::batchListRequested; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 13;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(QList<QVariantMap> , const QString & );
            if (_q_method_type _q_method = &appcontroller::batchListReady; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 14;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(cmdContext , Customer );
            if (_q_method_type _q_method = &appcontroller::customerCommand; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 15;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(bool , const QString & );
            if (_q_method_type _q_method = &appcontroller::customerCommandResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 16;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(cmdContext , const QString & , int );
            if (_q_method_type _q_method = &appcontroller::customerListRequested; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 17;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(QList<QVariantMap> , const QString & );
            if (_q_method_type _q_method = &appcontroller::customerListReady; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 18;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(cmdContext , const QJsonObject & );
            if (_q_method_type _q_method = &appcontroller::orderCommandRequested; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 19;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(bool , const QString & );
            if (_q_method_type _q_method = &appcontroller::orderCommandResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 20;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(cmdContext , const QString & , const QString & , const QString & , int , int );
            if (_q_method_type _q_method = &appcontroller::orderListRequested; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 21;
                return;
            }
        }
        {
            using _q_method_type = void (appcontroller::*)(QList<QVariantMap> , const QString & );
            if (_q_method_type _q_method = &appcontroller::orderListReady; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 22;
                return;
            }
        }
    }
}

const QMetaObject *appcontroller::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *appcontroller::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ZN13appcontrollerE.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int appcontroller::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 49)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 49;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 49)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 49;
    }
    return _id;
}

// SIGNAL 0
void appcontroller::requestCommandOrderResult_UI(bool _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void appcontroller::requestCommandBatchToOrderResult_UI(bool _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void appcontroller::orderUpdateResult_UI(QList<QVariantMap> _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void appcontroller::checkProductNameConflictSignal(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void appcontroller::productNameChecked(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void appcontroller::productCommand(Products _t1, cmdContext _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void appcontroller::productCommandResult(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void appcontroller::productListRequested(cmdContext _t1, const QString & _t2, int _t3)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void appcontroller::productListReady(QList<QVariantMap> _t1, const QString _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void appcontroller::batchCommand(cmdContext _t1, const QString & _t2, Batch _t3)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}

// SIGNAL 10
void appcontroller::batchCommandResult(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 10, _a);
}

// SIGNAL 11
void appcontroller::batchInfoRequested(cmdContext _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 11, _a);
}

// SIGNAL 12
void appcontroller::batchInfoResult(double _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 12, _a);
}

// SIGNAL 13
void appcontroller::batchListRequested(cmdContext _t1, const QString & _t2, const QString & _t3, int _t4, int _t5)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t5))) };
    QMetaObject::activate(this, &staticMetaObject, 13, _a);
}

// SIGNAL 14
void appcontroller::batchListReady(QList<QVariantMap> _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 14, _a);
}

// SIGNAL 15
void appcontroller::customerCommand(cmdContext _t1, Customer _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 15, _a);
}

// SIGNAL 16
void appcontroller::customerCommandResult(bool _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 16, _a);
}

// SIGNAL 17
void appcontroller::customerListRequested(cmdContext _t1, const QString & _t2, int _t3)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))) };
    QMetaObject::activate(this, &staticMetaObject, 17, _a);
}

// SIGNAL 18
void appcontroller::customerListReady(QList<QVariantMap> _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 18, _a);
}

// SIGNAL 19
void appcontroller::orderCommandRequested(cmdContext _t1, const QJsonObject & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 19, _a);
}

// SIGNAL 20
void appcontroller::orderCommandResult(bool _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 20, _a);
}

// SIGNAL 21
void appcontroller::orderListRequested(cmdContext _t1, const QString & _t2, const QString & _t3, const QString & _t4, int _t5, int _t6)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t5))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t6))) };
    QMetaObject::activate(this, &staticMetaObject, 21, _a);
}

// SIGNAL 22
void appcontroller::orderListReady(QList<QVariantMap> _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 22, _a);
}
QT_WARNING_POP
