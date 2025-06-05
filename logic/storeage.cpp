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
void storeage::handleProductCommand(Products pro, cmdContext cmd) {
    if(cmd.cmd == Cmd::ADD){
        Products newone;
        newone.setProductId(pro.getProductId());
        newone.setProductName(pro.getProductName());
        newone.setCost(pro.getCost());
        newone.setIsValue(true);
        newone.setDescription(pro.getDescription());
        bool done = db->insertProduct(newone);
        emit productCommandResult(done);
    }else if(cmd.cmd == Cmd::DELETE){
        bool done = db->deleteProduct(pro.getProductName());
        if (done) {
            store.remove(pro.getProductId());
            qDebug() << "✅ Xoá sản phẩm thành công:" << pro.getProductName();
        } else {
            qWarning() << "❌ Xoá sản phẩm thất bại:" << pro.getProductName();
        }
        emit productCommandResult(done);
    }
}

// ****************************************

// ****< Lấy danh sách sản phẩm >****
void storeage::handleProductListRequest(cmdContext cmd, const QString& keyword, int numPage) {
    QList<Products*> fetchedProducts;
    
    if(cmd.cmd == Cmd::LIST){
        fetchedProducts = db->getProductsByPage(numPage);
    }else if(cmd.cmd == Cmd::SEARCH){
        if(cmd.typelist == type_of_list::NAME){
            fetchedProducts = db->getProductListByName(keyword);
        }else if(cmd.typelist == type_of_list::PRICE){
            
            fetchedProducts = db->getProductListByPrice(keyword);
        }
        qDebug() << "it run here";

    }else if(cmd.cmd == Cmd::ONE){
        fetchedProducts = db->getAProductByName(keyword);
    }

    QList<QVariantMap> result;
    for (Products* p : fetchedProducts) {
        QVariantMap item;
        item["productName"] = p->getProductName();
        item["productId"] = p->getProductId();
        item["cost"] = p->getCost();
        item["numOfProduct"] = db->getNumOfItemOfAllBatch(p->getProductName());
        item["description"] = p->getDescription();
        item["isValue"] = p->getIsValue();
        item["totalValue"] = p->totalValue();
        result.append(item);
        delete p;
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
void storeage::handleCustomerCommand(cmdContext cmd, Customer customer){
    bool done;
    if(cmd.cmd == Cmd::ADD){
        done = db->insertCustomer(customer);
    }else if(cmd.cmd == Cmd::CHECKPHONENUMBER){
        done = db->checkCustomerPhoneNumberExists(customer.getCustomerPhoneNumber());
    }else if(cmd.cmd == Cmd::DELETE){
        if(customer.getCustomerPhoneNumber() != ""){
            done = db->deleteCustomerByPhoneNumber(customer.getCustomerPhoneNumber());
        }else{
            done = db->deleteCustomerByName(customer.getCustomerName());
        }
    }

    emit customerCommandResult(done, cmd);
}

void storeage::handleCustomerListRequest(cmdContext cmd, const QString& keyword, int numPage){
    QList<Customer*> fetchedCutomers;

    if(cmd.cmd == Cmd::LIST){
        fetchedCutomers = db->getCustomersByPage(numPage);
    }else if(cmd.cmd == Cmd::SEARCH){
        if(cmd.typelist == type_of_list::NAME){
            fetchedCutomers = db->getCustomerByName(keyword);
        }else if(cmd.typelist == type_of_list::PHONENUMBER){
            fetchedCutomers = db->getCustomerByPhoneNumber(keyword);
        }else if(cmd.typelist == type_of_list::YEAROFBIRTH){
            fetchedCutomers = db->getCustomerByYearOfBirth(keyword);
        }
    }

    QList<QVariantMap> result;

    for(Customer* c : fetchedCutomers){
        QVariantMap item;
        item["name"] = c->getCustomerName();
        item["phone_number"] = c->getCustomerPhoneNumber();
        item["year_of_birth"] = c->getCustomerYearOfBirth();
        item["gender"] = GenderToQString(c->getCustomerGender());
        result.append(item);
        delete c;
    }

    emit customerListReady(result, cmd);
}
// ****************************************




// <<<<<<<<<< FOR ORDER >>>>>>>>>>
void storeage::handleOrderCommand(cmdContext cmd, const QJsonObject& data){
    Order* order = Order::fromJson(data);
    if(cmd.cmd == Cmd::ADD){
        for(Products* p : order->getListItem()){
            for(Batch* b : p->getBatchList()){
                db->updateBatch(p->getProductName(), *b);
            }
        }
        db->insertOrder(*order); 

    }else if(cmd.cmd == Cmd::DELETE){
        db->deleteOrder(order->getCustomerName(), order->getCustomerPhoneNumber(), order->getPurchaseTime());

    }
    delete order;
    emit orderCommandResult(true, cmd);
}



void storeage::handleOrderListRequest(cmdContext cmd, const QString& keyword, const QString& dateBegin, const QString& dateEnd, int numOfOrder, int numPage){
    QList<Order*> fetchedOrders;
    fetchedOrders = db->getOrderByPage(cmd, keyword, numOfOrder, numPage);

    QList<QVariantMap> result;

    for(Order* order : fetchedOrders){
        QVariantMap item;
        item["customer_name"] = order->getCustomerName();
        item["phone_number"] = order->getCustomerPhoneNumber();
        item["purchase_time"] = order->getPurchaseTime();
        item["data"] = Order::itemToQString(order->getListItem());
        item["total_price"] = order->getTotalPrice();
        result.append(item);
        delete order;
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