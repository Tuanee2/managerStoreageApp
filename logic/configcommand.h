#ifndef CONFIGCOMMAND_H
#define CONFIGCOMMAND_H

#include <QString>
#include <QVariantMap>

// new structure

enum class CommandType { ADD, DELETE, UPDATE, GET, CHECK, INVALID };
enum class TargetType { PRODUCT, BATCH, CUSTOMER, ORDER, UNKNOWN };
enum class InfoKind { GENERAL, FIELD, OBJECT, INVALID };
enum class FetchMode {SINGLE, MULTIPLE, INVALID };
enum class GetType {LIST, SEARCH, INVALID };
enum class SortField { NONE, NAME, PRICE, DATE, RANK, VALUE };
enum class SortOrderNew { ASCENDING, DESCENDING, NONE };
enum class DurationNew { ALL, AMONTH, AWEEK, ADAY, CUSTOM };

// Conversion functions for new enum classes
QString commandTypeToQString(CommandType type);
CommandType QStringToCommandType(const QString& str);
QString targetTypeToQString(TargetType type);
TargetType QStringToTargetType(const QString& str);
QString infoKindToQString(InfoKind kind);
InfoKind QStringToInfoKind(const QString& str);
QString getTypeToQString(GetType type);
FetchMode QStringToFetchMode(const QString& str);
QString FetchModeToQString(FetchMode mode);
GetType QStringToGetType(const QString& str);
QString sortFieldToQString(SortField field);
SortField QStringToSortField(const QString& str);
QString sortOrderToQString(SortOrderNew order);
SortOrderNew QStringToSortOrderNew(const QString& str);
QString durationToQString(DurationNew duration);
DurationNew QStringToDurationNew(const QString& str);

struct BaseCommand {
    CommandType command = CommandType::INVALID;
    TargetType target = TargetType::UNKNOWN;
    InfoKind infoKind = InfoKind::INVALID;
    GetType getType = GetType::INVALID;
    FetchMode fetchMode = FetchMode::INVALID;
    QVariantMap filters;    // keyword, status, range, etc.
    QVariantMap data;       // dùng cho ADD, UPDATE
    SortField sortField = SortField::NONE;
    SortOrderNew sortOrder = SortOrderNew::NONE;
    DurationNew duration = DurationNew::ALL;
    int page = -1;
    int pageSize = -1;
};

BaseCommand MapToBaseCommand(QVariantMap cmdData);
QVariantMap BaseCommandToMap(BaseCommand cmdData);
// old structure

typedef enum{
    ADD,
    DELETE,
    UPDATE,
    SEARCH,
    LIST,
    ONE,
    CHECKNAME,
    CHECKPHONENUMBER,
    CMD_INVALID
} Cmd;

Cmd QStringToCmd(const QString& cmd);
QString CmdToQString(Cmd cmd);

typedef enum {
    NAME,
    PHONENUMBER,
    PRICE,
    IMPORTDATE,
    EXPORTDATE,
    EXPIREDDATE,
    YEAROFBIRTH,
    ORDER_PROFIT_REVENUE,
    TYPELIST_INVALID
}  type_of_list;

type_of_list QStringToTypeList(const QString& typelist);
QString typeListToQString(type_of_list typelist);

typedef enum {
    NUMOFITEM,
    TOTALPRICE,
    TYPE_INVALUE
} type_of_info;

type_of_info QStringToType(const QString& type);
QString TypeToQString(type_of_info type);

typedef enum {
    ASCENDING,
    DESCENDING,
    ORDER_INVALID
} SortOrder;

SortOrder QStringToSortOrder(const QString& str);
QString SortOrderToQString(SortOrder ord);

typedef enum {
    TOPRICE,
    TOYEAROFBIRTH,
    TOPURCHASETIME,
    TOIMPORTDATE,
    TOEXPIREDDATE,
    TYPEORDER_INVALID
} type_of_order;

type_of_order QStringToTypeOder(const QString& typeorder);
QString TypeOrderToQString(type_of_order typeorder);

typedef enum {
    ALL,
    AMONTH,
    AWEEK,
    ADAY,
    CUSTOM
} Duration;

Duration QStringToDuration(const QString& duration);

typedef struct {
    Cmd cmd;
    type_of_info type;
    type_of_list typelist;
    Duration duration;
    QString date;
    SortOrder order;
    type_of_order typeOder;
}cmdContext;

cmdContext QStringToCmdContext(const QString& cmd, const QString& type,const QString& duration);


enum class Unit{
    BOTTLE,
    BAG,
    BOX,
    PACK,
    KILO,
    LITER,
    INVALID
};

Unit QStringToUnit(const QString& str);
QString UnitToQString(Unit unit);
QString UnitForShow(Unit unit);

#endif // CONFIGCOMMAND_H
