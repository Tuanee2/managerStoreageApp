#include "configcommand.h"


// new structure: Conversion functions for enum classes

QString commandTypeToQString(CommandType type) {
    switch (type) {
        case CommandType::ADD: return "ADD";
        case CommandType::DELETE: return "DELETE";
        case CommandType::UPDATE: return "UPDATE";
        case CommandType::GET: return "GET";
        case CommandType::CHECK: return "CHECK";
        default: return "INVALID";
    }
}

CommandType QStringToCommandType(const QString& str) {
    if (str == "ADD") return CommandType::ADD;
    if (str == "DELETE") return CommandType::DELETE;
    if (str == "UPDATE") return CommandType::UPDATE;
    if (str == "GET") return CommandType::GET;
    if (str == "CHECK") return CommandType::CHECK;
    return CommandType::INVALID;
}

QString targetTypeToQString(TargetType type) {
    switch (type) {
        case TargetType::PRODUCT: return "PRODUCT";
        case TargetType::BATCH: return "BATCH";
        case TargetType::CUSTOMER: return "CUSTOMER";
        case TargetType::ORDER: return "ORDER";
        default: return "UNKNOWN";
    }
}

TargetType QStringToTargetType(const QString& str) {
    if (str == "PRODUCT") return TargetType::PRODUCT;
    if (str == "BATCH") return TargetType::BATCH;
    if (str == "CUSTOMER") return TargetType::CUSTOMER;
    if (str == "ORDER") return TargetType::ORDER;
    return TargetType::UNKNOWN;
}

QString infoKindToQString(InfoKind kind) {
    switch (kind) {
        case InfoKind::GENERAL: return "GENERAL";
        case InfoKind::FIELD: return "FIELD";
        case InfoKind::OBJECT: return "OBJECT";
        default: return "INVALID";
    }
}

InfoKind QStringToInfoKind(const QString& str) {
    if (str == "GENERAL") return InfoKind::GENERAL;
    if (str == "FIELD") return InfoKind::FIELD;
    if (str == "OBJECT") return InfoKind::OBJECT;
    return InfoKind::INVALID;
}

QString getTypeToQString(GetType type) {
    switch (type) {
        case GetType::LIST: return "LIST";
        case GetType::SEARCH: return "SEARCH";
        default: return "INVALID";
    }
}

GetType QStringToGetType(const QString& str) {
    if (str == "LIST") return GetType::LIST;
    if (str == "SEARCH") return GetType::SEARCH;
    return GetType::INVALID;
}

QString sortFieldToQString(SortField field) {
    switch (field) {
        case SortField::NONE: return "NONE";
        case SortField::NAME: return "NAME";
        case SortField::PRICE: return "PRICE";
        case SortField::DATE: return "DATE";
        case SortField::RANK: return "RANK";
        case SortField::VALUE: return "VALUE";
        default: return "NONE";
    }
}

SortField QStringToSortField(const QString& str) {
    if (str == "NONE") return SortField::NONE;
    if (str == "NAME") return SortField::NAME;
    if (str == "PRICE") return SortField::PRICE;
    if (str == "DATE") return SortField::DATE;
    if (str == "RANK") return SortField::RANK;
    if (str == "VALUE") return SortField::VALUE;
    return SortField::NONE;
}

QString sortOrderToQString(SortOrderNew order) {
    switch (order) {
        case SortOrderNew::ASCENDING: return "ASCENDING";
        case SortOrderNew::DESCENDING: return "DESCENDING";
        case SortOrderNew::NONE: return "NONE";
        default: return "NONE";
    }
}

SortOrderNew QStringToSortOrderNew(const QString& str) {
    if (str == "ASCENDING") return SortOrderNew::ASCENDING;
    if (str == "DESCENDING") return SortOrderNew::DESCENDING;
    if (str == "NONE") return SortOrderNew::NONE;
    return SortOrderNew::NONE;
}

QString durationToQString(DurationNew duration) {
    switch (duration) {
        case DurationNew::ALL: return "ALL";
        case DurationNew::AMONTH: return "AMONTH";
        case DurationNew::AWEEK: return "AWEEK";
        case DurationNew::ADAY: return "ADAY";
        case DurationNew::CUSTOM: return "CUSTOM";
        default: return "ALL";
    }
}

DurationNew QStringToDurationNew(const QString& str) {
    if (str == "ALL") return DurationNew::ALL;
    if (str == "AMONTH") return DurationNew::AMONTH;
    if (str == "AWEEK") return DurationNew::AWEEK;
    if (str == "ADAY") return DurationNew::ADAY;
    if (str == "CUSTOM") return DurationNew::CUSTOM;
    return DurationNew::ALL;
}

// old structure
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
    } else if (typelist == "ORDER_PROFIT_REVENUE") {
        return type_of_list::ORDER_PROFIT_REVENUE;
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
    case type_of_list::ORDER_PROFIT_REVENUE:
        return "ORDER_PROFIT_REVENUE";
    default: return"TYPELIST_INVALID";
    }
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

SortOrder QStringToSortOrder(const QString& str) {
    if (str == "ASCENDING") return SortOrder::ASCENDING;
    if (str == "DESCENDING") return SortOrder::DESCENDING;
    return SortOrder::ORDER_INVALID;
}

QString SortOrderToQString(SortOrder ord) {
    switch (ord) {
        case SortOrder::ASCENDING: return "ASCENDING";
        case SortOrder::DESCENDING: return "DESCENDING";
        default: return "ORDER_INVALID";
    }
}

type_of_order QStringToTypeOder(const QString& typeorder) {
    if (typeorder == "TOPRICE") return type_of_order::TOPRICE;
    if (typeorder == "TOYEAROFBIRTH") return type_of_order::TOYEAROFBIRTH;
    if (typeorder == "TOPURCHASETIME") return type_of_order::TOPURCHASETIME;
    if (typeorder == "TOIMPORTDATE") return type_of_order::TOIMPORTDATE;
    if (typeorder == "TOEXPIREDDATE") return type_of_order::TOEXPIREDDATE;
    return type_of_order::TYPEORDER_INVALID;
}

QString TypeOrderToQString(type_of_order typeorder) {
    switch (typeorder) {
        case type_of_order::TOPRICE: return "TOPRICE";
        case type_of_order::TOYEAROFBIRTH: return "TOYEAROFBIRTH";
        case type_of_order::TOPURCHASETIME: return "TOPURCHASETIME";
        case type_of_order::TOIMPORTDATE: return "TOIMPORTDATE";
        case type_of_order::TOEXPIREDDATE: return "TOEXPIREDDATE";
        default: return "TYPEORDER_INVALID";
    }
}

Rank QSTringToRank(const QString& rank){
    if(rank == "BRONZE"){
        return Rank::BRONZE;
    }else if(rank == "SILVER"){
        return Rank::SILVER;
    }else if(rank == "GOLD"){
        return Rank::GOLD;
    }else if(rank == "PLATINUM"){
        return Rank::PLATINUM;
    }else if(rank == "DIAMOND"){
        return Rank::DIAMOND;
    }else{
        return Rank::RANK_INVALID;
    }
}

QString rankToQString(Rank rank){
     if(rank == Rank::BRONZE){
        return "BRONZE";
    }else if(rank == Rank::SILVER){
        return "SILVER";
    }else if(rank == Rank::GOLD){
        return "GOLD";
    }else if(rank == Rank::PLATINUM){
        return "PLATINUM";
    }else if(rank == Rank::DIAMOND){
        return "DIAMOND";
    }else{
        return "RANK_INVALID";
    }
}