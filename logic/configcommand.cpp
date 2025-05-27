#include "configcommand.h"

Cmd QStringToCmd(const QString& cmd){
    if(cmd == "ADD"){
        return Cmd::ADD;
    }else if(cmd == "DELETE"){
        return Cmd::DELETE;
    }else if(cmd == "UPDATE"){
        return Cmd::UPDATE;
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
    }else if(cmd == Cmd::UPDATE){
        return "UPDATE";
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

type_of_list QStringToTypeList(const QString& typelist){
    if (typelist == "NAME") {
        return type_of_list::NAME;
    } else if (typelist == "PHONENUMBER") {
        return type_of_list::PHONENUMBER;
    } else if (typelist == "PRICE") {
        return type_of_list::PRICE;
    } else if (typelist == "IMPORTDATE") {
        return type_of_list::IMPORTDATE;
    } else if (typelist == "EXPORTDATE") {
        return type_of_list::EXPORTDATE;
    } else if (typelist == "EXPIREDDATE") {
        return type_of_list::EXPIREDDATE;
    } else if (typelist == "YEAROFBIRTH") {
        return type_of_list::YEAROFBIRTH;
    }
    return type_of_list::TYPELIST_INVALID; // default fallback
}

QString typeListToQString(type_of_list typelist){
    switch (typelist) {
    case type_of_list::NAME:
        return "NAME";
    case type_of_list::PHONENUMBER:
        return "PHONENUMBER";
    case type_of_list::PRICE:
        return "PRICE";
    case type_of_list::IMPORTDATE:
        return "IMPORTDATE";
    case type_of_list::EXPORTDATE:
        return "EXPORTDATE";
    case type_of_list::EXPIREDDATE:
        return "EXPIREDDATE";
    case type_of_list::YEAROFBIRTH:
        return "YEAROFBIRTH";
    }
    return "TYPELIST_INVALID";
}

type_of_info QStringToType(const QString& type){
    if(type == "NUMOFITEM"){
        return type_of_info::NUMOFITEM;
    }else if(type == "TOTALPRICE"){
        return type_of_info::TOTALPRICE;
    }

    return type_of_info::TYPE_INVALUE;

}

QString TypeToQString(type_of_info type){
    if(type == type_of_info::NUMOFITEM){
        return "NUMOFITEM";
    }else if (type == type_of_info::TOTALPRICE){
        return "TOTALPRICE";
    }
    return "TYPE_INVALUE";
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
