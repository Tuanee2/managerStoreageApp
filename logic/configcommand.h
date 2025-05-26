#ifndef CONFIGCOMMAND_H
#define CONFIGCOMMAND_H

#include <QString>

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
    YEAROFBIRTH
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
}cmdContext;

cmdContext QStringToCmdContext(const QString& cmd, const QString& type,const QString& duration);

#endif // CONFIGCOMMAND_H
