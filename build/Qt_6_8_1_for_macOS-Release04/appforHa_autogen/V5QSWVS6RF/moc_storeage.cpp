/****************************************************************************
** Meta object code from reading C++ file 'storeage.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.8.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../logic/storeage.h"
#include <QtCore/qmetatype.h>
#include <QtCore/QList>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'storeage.h' doesn't include <QObject>."
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
struct qt_meta_tag_ZN8storeageE_t {};
} // unnamed namespace


#ifdef QT_MOC_HAS_STRINGDATA
static constexpr auto qt_meta_stringdata_ZN8storeageE = QtMocHelpers::stringData(
    "storeage",
    "productNameCheckResult",
    "",
    "exists",
    "productCommandResult",
    "done",
    "productListReady",
    "QList<QVariantMap>",
    "list",
    "cmdContext",
    "cmd",
    "productCountChanged",
    "newCount",
    "requestInsertProduct",
    "Products",
    "product",
    "batchCommandResult",
    "batchInfoResult",
    "result",
    "batchListReady",
    "customerCommandResult",
    "customerListReady",
    "orderCommandResult",
    "orderListReady",
    "handleCheckProductName",
    "name",
    "handleProductCommand",
    "pro",
    "handleProductListRequest",
    "keyword",
    "numPage",
    "sreachProduct",
    "Products*",
    "id",
    "sreachProductByName",
    "totalProductTypes",
    "handleBatchCommand",
    "Batch",
    "batch",
    "handleBatchInfoRequest",
    "productName",
    "handleBatchListRequest",
    "numOfBatch",
    "handleCustomerCommand",
    "Customer",
    "customer",
    "handleCustomerListRequest",
    "handleOrderCommand",
    "data",
    "handleOrderListRequest",
    "dateBegin",
    "dateEnd",
    "numOfOrder",
    "initialize"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA

Q_CONSTINIT static const uint qt_meta_data_ZN8storeageE[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
      26,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      12,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,  170,    2, 0x06,    1 /* Public */,
       4,    1,  173,    2, 0x06,    3 /* Public */,
       6,    2,  176,    2, 0x06,    5 /* Public */,
      11,    1,  181,    2, 0x06,    8 /* Public */,
      13,    1,  184,    2, 0x06,   10 /* Public */,
      16,    1,  187,    2, 0x06,   12 /* Public */,
      17,    2,  190,    2, 0x06,   14 /* Public */,
      19,    2,  195,    2, 0x06,   17 /* Public */,
      20,    2,  200,    2, 0x06,   20 /* Public */,
      21,    2,  205,    2, 0x06,   23 /* Public */,
      22,    2,  210,    2, 0x06,   26 /* Public */,
      23,    2,  215,    2, 0x06,   29 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
      24,    1,  220,    2, 0x0a,   32 /* Public */,
      26,    2,  223,    2, 0x0a,   34 /* Public */,
      28,    3,  228,    2, 0x0a,   37 /* Public */,
      31,    1,  235,    2, 0x0a,   41 /* Public */,
      34,    1,  238,    2, 0x0a,   43 /* Public */,
      35,    0,  241,    2, 0x10a,   45 /* Public | MethodIsConst  */,
      36,    3,  242,    2, 0x0a,   46 /* Public */,
      39,    2,  249,    2, 0x0a,   50 /* Public */,
      41,    5,  254,    2, 0x0a,   53 /* Public */,
      43,    2,  265,    2, 0x0a,   59 /* Public */,
      46,    3,  270,    2, 0x0a,   62 /* Public */,
      47,    2,  277,    2, 0x0a,   66 /* Public */,
      49,    6,  282,    2, 0x0a,   69 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      53,    0,  295,    2, 0x02,   76 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Bool,    3,
    QMetaType::Void, QMetaType::Bool,    5,
    QMetaType::Void, 0x80000000 | 7, 0x80000000 | 9,    8,   10,
    QMetaType::Void, QMetaType::Int,   12,
    QMetaType::Void, 0x80000000 | 14,   15,
    QMetaType::Void, QMetaType::Bool,    5,
    QMetaType::Void, QMetaType::Double, 0x80000000 | 9,   18,   10,
    QMetaType::Void, 0x80000000 | 7, 0x80000000 | 9,    8,   10,
    QMetaType::Void, QMetaType::Bool, 0x80000000 | 9,    5,   10,
    QMetaType::Void, 0x80000000 | 7, 0x80000000 | 9,    8,   10,
    QMetaType::Void, QMetaType::Bool, 0x80000000 | 9,    5,   10,
    QMetaType::Void, 0x80000000 | 7, 0x80000000 | 9,    8,   10,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,   25,
    QMetaType::Void, 0x80000000 | 14, 0x80000000 | 9,   27,   10,
    QMetaType::Void, 0x80000000 | 9, QMetaType::QString, QMetaType::Int,   10,   29,   30,
    0x80000000 | 32, QMetaType::QString,   33,
    0x80000000 | 32, QMetaType::QString,   25,
    QMetaType::Int,
    QMetaType::Void, 0x80000000 | 9, QMetaType::QString, 0x80000000 | 37,   10,   25,   38,
    QMetaType::Void, 0x80000000 | 9, QMetaType::QString,   10,   40,
    QMetaType::Void, 0x80000000 | 9, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int,   10,   40,   29,   42,   30,
    QMetaType::Void, 0x80000000 | 9, 0x80000000 | 44,   10,   45,
    QMetaType::Void, 0x80000000 | 9, QMetaType::QString, QMetaType::Int,   10,   29,   30,
    QMetaType::Void, 0x80000000 | 9, QMetaType::QJsonObject,   10,   48,
    QMetaType::Void, 0x80000000 | 9, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Int, QMetaType::Int,   10,   29,   50,   51,   52,   30,

 // methods: parameters
    QMetaType::Void,

       0        // eod
};

Q_CONSTINIT const QMetaObject storeage::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ZN8storeageE.offsetsAndSizes,
    qt_meta_data_ZN8storeageE,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_tag_ZN8storeageE_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<storeage, std::true_type>,
        // method 'productNameCheckResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'productCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'productListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'productCountChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'requestInsertProduct'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<Products, std::false_type>,
        // method 'batchCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'batchInfoResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'batchListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'customerCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'customerListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'orderCommandResult'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'orderListReady'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QList<QVariantMap>, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'handleCheckProductName'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'handleProductCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<Products, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        // method 'handleProductListRequest'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'sreachProduct'
        QtPrivate::TypeAndForceComplete<Products *, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'sreachProductByName'
        QtPrivate::TypeAndForceComplete<Products *, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'totalProductTypes'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'handleBatchCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<Batch, std::false_type>,
        // method 'handleBatchInfoRequest'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'handleBatchListRequest'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'handleCustomerCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<Customer, std::false_type>,
        // method 'handleCustomerListRequest'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'handleOrderCommand'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QJsonObject &, std::false_type>,
        // method 'handleOrderListRequest'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<cmdContext, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'initialize'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void storeage::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<storeage *>(_o);
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: _t->productNameCheckResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 1: _t->productCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 2: _t->productListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 3: _t->productCountChanged((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 4: _t->requestInsertProduct((*reinterpret_cast< std::add_pointer_t<Products>>(_a[1]))); break;
        case 5: _t->batchCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 6: _t->batchInfoResult((*reinterpret_cast< std::add_pointer_t<double>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 7: _t->batchListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 8: _t->customerCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 9: _t->customerListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 10: _t->orderCommandResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 11: _t->orderListReady((*reinterpret_cast< std::add_pointer_t<QList<QVariantMap>>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 12: _t->handleCheckProductName((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 13: _t->handleProductCommand((*reinterpret_cast< std::add_pointer_t<Products>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[2]))); break;
        case 14: _t->handleProductListRequest((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3]))); break;
        case 15: { Products* _r = _t->sreachProduct((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< Products**>(_a[0]) = std::move(_r); }  break;
        case 16: { Products* _r = _t->sreachProductByName((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< Products**>(_a[0]) = std::move(_r); }  break;
        case 17: { int _r = _t->totalProductTypes();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 18: _t->handleBatchCommand((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<Batch>>(_a[3]))); break;
        case 19: _t->handleBatchInfoRequest((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 20: _t->handleBatchListRequest((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[5]))); break;
        case 21: _t->handleCustomerCommand((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<Customer>>(_a[2]))); break;
        case 22: _t->handleCustomerListRequest((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[3]))); break;
        case 23: _t->handleOrderCommand((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2]))); break;
        case 24: _t->handleOrderListRequest((*reinterpret_cast< std::add_pointer_t<cmdContext>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[6]))); break;
        case 25: _t->initialize(); break;
        default: ;
        }
    }
    if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _q_method_type = void (storeage::*)(bool );
            if (_q_method_type _q_method = &storeage::productNameCheckResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(bool );
            if (_q_method_type _q_method = &storeage::productCommandResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(QList<QVariantMap> , cmdContext );
            if (_q_method_type _q_method = &storeage::productListReady; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(int );
            if (_q_method_type _q_method = &storeage::productCountChanged; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(Products );
            if (_q_method_type _q_method = &storeage::requestInsertProduct; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 4;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(bool );
            if (_q_method_type _q_method = &storeage::batchCommandResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 5;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(double , cmdContext );
            if (_q_method_type _q_method = &storeage::batchInfoResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 6;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(QList<QVariantMap> , cmdContext );
            if (_q_method_type _q_method = &storeage::batchListReady; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 7;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(bool , cmdContext );
            if (_q_method_type _q_method = &storeage::customerCommandResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 8;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(QList<QVariantMap> , cmdContext );
            if (_q_method_type _q_method = &storeage::customerListReady; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 9;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(bool , cmdContext );
            if (_q_method_type _q_method = &storeage::orderCommandResult; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 10;
                return;
            }
        }
        {
            using _q_method_type = void (storeage::*)(QList<QVariantMap> , cmdContext );
            if (_q_method_type _q_method = &storeage::orderListReady; *reinterpret_cast<_q_method_type *>(_a[1]) == _q_method) {
                *result = 11;
                return;
            }
        }
    }
}

const QMetaObject *storeage::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *storeage::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ZN8storeageE.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int storeage::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 26)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 26;
    }
    if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 26)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 26;
    }
    return _id;
}

// SIGNAL 0
void storeage::productNameCheckResult(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void storeage::productCommandResult(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void storeage::productListReady(QList<QVariantMap> _t1, cmdContext _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void storeage::productCountChanged(int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void storeage::requestInsertProduct(Products _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void storeage::batchCommandResult(bool _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void storeage::batchInfoResult(double _t1, cmdContext _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void storeage::batchListReady(QList<QVariantMap> _t1, cmdContext _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void storeage::customerCommandResult(bool _t1, cmdContext _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void storeage::customerListReady(QList<QVariantMap> _t1, cmdContext _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}

// SIGNAL 10
void storeage::orderCommandResult(bool _t1, cmdContext _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 10, _a);
}

// SIGNAL 11
void storeage::orderListReady(QList<QVariantMap> _t1, cmdContext _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 11, _a);
}
QT_WARNING_POP
