#include "storeage.h"

storeage::storeage(QObject *parent)
    : QObject{parent}
{}

void storeage::initialize() {
    db = new DatabaseManager(this);  // Bây giờ `this` đã ở thread mới!
    qDebug() << "[storeage] Đang khởi tạo cơ sở dữ liệu";
    if (!db->initialize()) {
        qDebug() << "⚠️ Fail to create database";
    } else {
        qDebug() << "✅ Khởi tạo DB hoàn tất";
    }
}

Products* storeage::sreachProduct(const QString& id) {
    return store.value(id, nullptr);
}

Products* storeage::sreachProductByName(const QString& name) {
    for (auto product : store) {
        if (product->getProductName() == name) {
            return product;
        }
    }
    return nullptr;
}

int storeage::totalProductTypes() const{
    return store.size();
}

// ****< Kiểm tra tên trùng lặp >****
void storeage::handleCheckProductName(const QString& name) {
    bool exists = db->checkProductNameExists(name);  
    emit productNameCheckResult(exists);
}

// ****************************************

// ****< Thêm/xoá/cập nhật sản phẩm mới >****
void storeage::handleProductCommand(BaseCommand cmd) {
    bool done = false;
    if(cmd.command == CommandType::ADD){
        Products newone;
        newone.setProductId(cmd.data.value("id").toString());
        newone.setProductName(cmd.data.value("name").toString());
        newone.setCost(cmd.data.value("price").toFloat());
        newone.setUnit(cmd.data.value("unit").toString());
        newone.setIsValue(true);
        newone.setDescription(cmd.data.value("des").toString());
        done = db->insertProduct(newone);
    }else if(cmd.command == CommandType::DELETE){
        QString productName = cmd.data.value("name").toString();
        done = db->deleteProduct(productName);
        if (done) {
            //store.remove(pro.getProductId());
            qDebug() << "✅ Xoá sản phẩm thành công:" << productName;
        } else {
            qWarning() << "❌ Xoá sản phẩm thất bại:" << productName;
        }
    }else if(cmd.command == CommandType::UPDATE){

    }else if(cmd.command == CommandType::CHECK){
        QString productName = cmd.data.value("name").toString();
        done = db->checkProductNameExists(productName); 
    }else{
        qDebug() << "DATABASE_THREAD [ERROR]: command type is INVALID";
        return;
    }
    cmd.data.clear(); 
    emit productCommandResult(done, cmd);
}

// ****************************************

// ****< Lấy danh sách sản phẩm >****
void storeage::handleProductListRequest(BaseCommand cmd) {
    QList<QVariantMap> result;
    QList<Products*> fetchedProducts;

    if(cmd.infoKind == InfoKind::GENERAL){

    }else if(cmd.infoKind == InfoKind::FIELD){

    }else if(cmd.infoKind == InfoKind::OBJECT){
        if(cmd.fetchMode == FetchMode::SINGLE){
            if(cmd.filters.contains("name")){
                fetchedProducts = db->getAProductByName(cmd.filters.value("name").toString());
            }else if(cmd.filters.contains("price")){

            }else{

            }

        }else if(cmd.fetchMode == FetchMode::MULTIPLE){
            
            if(cmd.filters.isEmpty()){
                fetchedProducts = db->getProductsByPage(cmd.pageSize, cmd.page);
            }else if(cmd.filters.contains("name")){
                fetchedProducts = db->getProductListByName(cmd.filters.value("name").toString());
            }else if(cmd.filters.contains("price")){
                fetchedProducts = db->getProductListByPrice(cmd.filters.value("price").toString());
            }
        }else{
            qDebug() << "DATABASE_THREAD [ERROR]: fetchMode is INVALID";
            return;
        }
        for (Products* p : fetchedProducts) {
            QVariantMap item;
            item["productName"] = p->getProductName();
            item["productId"] = p->getProductId();
            item["cost"] = p->getCost();
            item["unit"] = UnitForShow(p->getUnit());
            item["numOfProduct"] = db->getNumOfItemOfAllBatch(p->getProductName());
            item["description"] = p->getDescription();
            item["isValue"] = p->getIsValue();
            item["totalValue"] = p->totalValue();
            result.append(item);
            delete p;
        }
    }else{
        qDebug() << "DATABASE_THREAD [ERROR]: infokind is INVALID";
        return;
    }
    
    emit productListReady(result, cmd);
}

// ****************************************


// <<<<<<<<<< FOR BATCHES >>>>>>>>>>
void storeage::handleBatchCommand(cmdContext cmd, const QString& name, Batch batch) {
    bool done = false;

    if (cmd.cmd == Cmd::ADD) {
        Batch newone;
        newone.setQuantity(batch.getQuantity());
        newone.setCost(batch.getCost());
        newone.setImportDate(batch.getImportDate());
        newone.setExpiryDate(batch.getExpiryDate());
        done = db->addBatch(name, newone);

        if (done) {
            qDebug() << "✅ Thêm lô sản phẩm thành công cho:" << name;
        } else {
            qWarning() << "❌ Thêm lô sản phẩm thất bại cho:" << name;
        }
    }

    emit batchCommandResult(done);
}

void storeage::handleBatchInfoRequest(cmdContext cmd, const QString& productName){
    double result = 0;
    if(cmd.type == type_of_info::NUMOFITEM){
        result = db->getNumOfItemOfAllBatch(productName);
    }else if(cmd.type == type_of_info::TOTALPRICE){

    }

    if(cmd.typelist == type_of_list::EXPIREDDATE){
        if(cmd.duration == Duration::AMONTH){
            QDateTime expiredDate(QDate::currentDate().addMonths(1).startOfDay());
            result = db->getNumOfALLBatchExpired(expiredDate);
        }
    }
    emit batchInfoResult(result, cmd);
}

void storeage::handleBatchListRequest(cmdContext cmd, const QString& productName, const QString& keyword, int numOfBatch, int numPage){
    QList<Batch*> fetchedBatches;
    QDateTime targetDate;
    if(cmd.cmd == Cmd::LIST){
        if(cmd.typelist == type_of_list::TYPELIST_INVALID){
            fetchedBatches = db->getBatchByPage(productName, numPage);
        }else if(cmd.typelist == type_of_list::EXPIREDDATE){
            if(cmd.duration == Duration::AWEEK){
                fetchedBatches = db->getBatchByExpiredDate(productName, QDateTime(QDate::currentDate().addDays(7).startOfDay()), numOfBatch, numPage);
                targetDate = QDateTime(QDate::currentDate().addDays(7).startOfDay());
            }else if(cmd.duration == Duration::AMONTH){
                fetchedBatches = db->getBatchByExpiredDate(productName, QDateTime(QDate::currentDate().addMonths(1).startOfDay()), numOfBatch, numPage);
                targetDate = QDateTime(QDate::currentDate().addMonths(1).startOfDay());
            }else if(cmd.duration == Duration::CUSTOM){

                fetchedBatches = db->getBatchByExpiredDate(productName, QDateTime(QDate::currentDate().addDays(keyword.toInt()).startOfDay()), numOfBatch, numPage);
                targetDate = QDateTime(QDate::currentDate().addDays(keyword.toInt()).startOfDay());
            }
        }

    }else if(cmd.cmd == Cmd::SEARCH){
        if(cmd.typelist == type_of_list::NAME){

        }else if(cmd.typelist == type_of_list::EXPIREDDATE){
            if(cmd.duration == Duration::AWEEK){
                fetchedBatches = db->getBatchByExpiredDate(productName, QDateTime(QDate::currentDate().addDays(7).startOfDay()), numOfBatch, numPage);
                targetDate = QDateTime(QDate::currentDate().addDays(7).startOfDay());
            }else if(cmd.duration == Duration::AMONTH){
                fetchedBatches = db->getBatchByExpiredDate(productName, QDateTime(QDate::currentDate().addMonths(1).startOfDay()), numOfBatch, numPage);
                targetDate = QDateTime(QDate::currentDate().addMonths(1).startOfDay());
            }else if(cmd.duration == Duration::CUSTOM){
                fetchedBatches = db->getBatchByExpiredDate(productName, QDateTime(QDate::currentDate().addDays(keyword.toInt()).startOfDay()), numOfBatch, numPage);
                targetDate = QDateTime(QDate::currentDate().addDays(keyword.toInt()).startOfDay());
            }

        }else if(cmd.typelist == type_of_list::IMPORTDATE){

        }
    }

    QList<QVariantMap> result;
    for(Batch* b : fetchedBatches){
        QVariantMap item;
        item["productName"] = b->getProductName();
        item["quantity"] = b->getQuantity();
        item["cost"] = b->getCost();
        if(cmd.typelist == type_of_list::EXPIREDDATE){
            int daysLeft = QDate::currentDate().daysTo(b->getExpiryDate().date());
            if(daysLeft <=0){
                daysLeft = -1;
            }
            item["days_left"] = daysLeft;
        }
        item["importdate"] = b->getImportDate().toString("yyyy-MM-dd");
        item["expireddate"] = b->getExpiryDate().toString("yyyy-MM-dd");
        result.append(item);
        delete b;
    }
    //arrangeForDayLeft(result);
    emit batchListReady(result, cmd);
}
// ****************************************




// <<<<<<<<<< FOR CUSTOMER >>>>>>>>>>
void storeage::handleCustomerCommand(BaseCommand cmd){
    bool done = false;
    if(cmd.command == CommandType::ADD){
        Customer newone;
        newone.setCustomerName(cmd.data.value("name").toString());
        newone.setCustomerPhoneNumber(cmd.data.value("phonenumber").toString());
        newone.setCustomerYearOfBirth(cmd.data.value("yearofbirth").toInt());
        newone.setCustomerGender(static_cast<Gender>(cmd.data.value("gender").toInt()));
        newone.setCustomerRewardPoints(0);
        newone.setRank("BROZE");
        newone.setDebtPoints(0);
        newone.setDebtStatus("NO_DEBT");
        done = db->insertCustomer(newone);
    }else if(cmd.command == CommandType::DELETE){
        done = db->deleteCustomerByPhoneNumber(cmd.data.value("phonenumber").toString());

    }else if(cmd.command == CommandType::UPDATE){

    }else if(cmd.command == CommandType::CHECK){
        done = db->checkCustomerPhoneNumberExists(cmd.data.value("phonenumber").toString());

    }else{
        qDebug() << "DATABASE_THREAD [ERROR]: command type is INVALID";
        return;
    }

    emit customerCommandResult(done, cmd);
}

void storeage::handleCustomerListRequest(BaseCommand cmd){
    QList<Customer*> fetchedCutomers;
    QList<QVariantMap> result;

    if(cmd.infoKind == InfoKind::GENERAL){

    }else if(cmd.infoKind == InfoKind::FIELD){

    }else if(cmd.infoKind == InfoKind::OBJECT){
        if(cmd.fetchMode == FetchMode::SINGLE){
            if(cmd.filters.contains("phonenumber")){
                fetchedCutomers = db->getACustomerByPhoneNumber(cmd.filters.value("phonenumber").toString());
            }
        }else if(cmd.fetchMode == FetchMode::MULTIPLE){
            if(cmd.filters.isEmpty()){
                fetchedCutomers = db->getCustomersByPage(cmd.pageSize, cmd.page);
            }else{
                if(cmd.filters.contains("phonenumber")){
                    fetchedCutomers = db->getCustomerByPhoneNumber(cmd.filters.value("phonenumber").toString());
                }else if(cmd.filters.contains("name")){
                    fetchedCutomers = db->getCustomerByName(cmd.filters.value("name").toString());
                }else if(cmd.filters.contains("yearofbirth")){
                    fetchedCutomers = db->getCustomerByYearOfBirth(cmd.filters.value("yearofbirth").toString());
                }
            }
        }else{
            return;
        }

        for(Customer* c : fetchedCutomers){
            QVariantMap item;
            item["name"] = c->getCustomerName();
            item["phone_number"] = c->getCustomerPhoneNumber();
            item["year_of_birth"] = c->getCustomerYearOfBirth();
            item["gender"] = GenderToQString(c->getCustomerGender());
            item["rank"] = rankForShow(c->getRank());
            item["reward_points"] = c->getCustomerRewardPoints();
            item["debt"] = debtForShow(c->getDebtStatus());
            item["debt_points"] = c->getDebtPoints();
            result.append(item);
            delete c;
        }

    }else{
        return;
    }

    emit customerListReady(result, cmd);
}
// ****************************************




// <<<<<<<<<< FOR ORDER >>>>>>>>>>
void storeage::handleOrderCommand(BaseCommand cmd){
    bool done = false;
    Order* order = Order::fromJson(cmd.data.value("data").toJsonObject());
    if(cmd.command == CommandType::ADD){
        for(Products* p : order->getListItem()){
            for(Batch* b : p->getBatchList()){
                db->updateBatch(p->getProductName(), *b);
            }
        }
        done = db->insertOrder(*order); 
    }else if(cmd.command == CommandType::DELETE){
        done = db->deleteOrder(order->getCustomerName(), order->getCustomerPhoneNumber(), order->getPurchaseTime());
    }else if(cmd.command == CommandType::UPDATE){

    }else if(cmd.command == CommandType::CHECK){

    }else {
        
    }

    delete order;
    cmd.data.clear();
    emit orderCommandResult(done, cmd);
}



void storeage::handleOrderListRequest(cmdContext cmd, const QString& keyword, const QString& dateBegin, const QString& dateEnd, int numOfOrder, int numPage){
    QList<Order*> fetchedOrders;
    QList<QVariantMap> result;

    if(!dateBegin.isEmpty() && !dateEnd.isEmpty()){
        if(cmd.typelist == type_of_list::ORDER_PROFIT_REVENUE){
                result = db->getOrderProfitAndRevenue(dateBegin, dateEnd, cmd.duration, (cmd.order == SortOrder::DESCENDING) ? 1 : 0);
        }else {

        }
    }else{
        fetchedOrders = db->getOrderByPage(cmd, keyword, numOfOrder, numPage);

        for(Order* order : fetchedOrders){
            QVariantMap item;
            item["customer_name"] = order->getCustomerName();
            item["phone_number"] = order->getCustomerPhoneNumber();
            item["purchase_time"] = order->getPurchaseTime();
            item["data"] = Order::itemToQString(order->getListItem());
            item["total_price"] = order->getTotalPrice();
            double profit = 0;
            for(Products* p : order->getListItem()){
                for(Batch* b : p->getBatchList()){
                    profit += (p->getCost() - b->getCost()) * b->getQuantity();
                }
            }
            
            item["profit"] = profit;
            result.append(item);
            delete order;
        }
    }

    emit orderListReady(result, cmd);

}




void storeage::arrangeForDayLeft(QList<QVariantMap>& list){
    for (int i = 0; i < list.size(); ++i) {
        for (int j = 0; j < list.size() - i - 1; ++j) {
            int day1 = list[j]["days_left"].toInt();
            int day2 = list[j + 1]["days_left"].toInt();
            if (day1 > day2) {
                qSwap(list[j], list[j + 1]);
            }
        }
    }
}
