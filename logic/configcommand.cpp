#include "configcommand.h"

Cmd QStringToCmd(const QString& cmd){
    if(cmd == "ADD"){
        return Cmd::ADD;
    }else if(cmd == "DELETE"){
        return Cmd::DELETE;
    }else if(cmd == "SEARCH"){
        return Cmd::SEARCH;
    }else if(cmd == "LIST"){
        return Cmd::LIST;
    }else if(cmd == "ONE"){
        return Cmd::ONE;
    }else if(cmd == "CHECKNAME"){
        return Cmd::CHECKNAME;
    }else if(cmd == "CHECKPHONENUMBER"){
        return Cmd::CHECKPHONENUMBER;
    }
        
    return Cmd::CMD_INVALID;
}

QString CmdToQString(Cmd cmd){
    if(cmd == Cmd::ADD){
        return "ADD";
    }else if(cmd == Cmd::DELETE){
        return "DELETE";
    }else if(cmd == Cmd::SEARCH){
        return "SEARCH";
    }else if(cmd == Cmd::LIST){
        return "LIST";
    }else if(cmd == Cmd::ONE){
        return "ONE";
    }else if(cmd == Cmd::CHECKNAME){
        return "CHECKNAME";
    }else if(cmd == Cmd::CHECKPHONENUMBER){
        return "CHECKPHONENUMBER";
    }
    
    return "CMD_INVALID";
}

Duration QStringToDuration(const QString& duration) {
    if(duration == "ALL"){
        return Duration::ALL;
    }else if(duration == "AMONTH"){
        return Duration::AMONTH;
    }else if(duration == "AWEEK"){
        return Duration::AWEEK;
    }else if(duration == "ADAY"){
        return Duration::ADAY;
    }else{
        return Duration::CUSTOM;
    }
}

cmdContext QStringToCmdContext(const QString& cmd, const QString& type, const QString& duration){
    cmdContext con;
    con.cmd = QStringToCmd(cmd);
    con.duration = QStringToDuration(duration);
    if(con.duration == Duration::CUSTOM){
        con.date = duration;
    }
    return con;
}
