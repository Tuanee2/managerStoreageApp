#ifndef CONFIGCOMMAND_H
#define CONFIGCOMMAND_H

#include <QString>

typedef enum{
    ADD,
    DELETE,
    SEARCH,
    LIST,
    ONE,
    CMD_INVALID
} Cmd;

Cmd QStringToCmd(const QString& cmd);
QString CmdtoQString(Cmd cmd);

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
    Duration duration;
    QString date;
}cmdContext;

cmdContext QStringToCmdContext(const QString& cmd, const QString& type,const QString& duration);

#endif // CONFIGCOMMAND_H
