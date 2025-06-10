cmake_minimum_required(VERSION 3.16)

project(LanHuyStore VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)
find_package(Qt6 REQUIRED COMPONENTS Sql)
find_package(Qt6 REQUIRED COMPONENTS Charts)

qt_standard_project_setup(REQUIRES 6.5)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)

qt_add_executable(appLanHuyStore
    main.cpp
)

# qt_add_qml_module(appLanHuyStore
#     URI LanHuyStore
#     VERSION 1.0
#     QML_FILES
#         Main.qml
#         RESOURCES resource.qrc
#         QML_FILES components/Dashboard.qml
#         QML_FILES components/ProductForm.qml
#         QML_FILES components/ProductList.qml
#         SOURCES logic/DatabaseManager.cpp
#         SOURCES logic/databasemanager.h logic/databasemanager.cpp
#         QML_FILES
#         QML_FILES components/HeaderBar.qml
#         QML_FILES components/Sales.qml
#         QML_FILES components/Setting.qml
#         SOURCES logic/products.h logic/products.cpp
#         SOURCES logic/storeage.h logic/storeage.cpp
#         SOURCES logic/appcontroller.h logic/appcontroller.cpp
#         QML_FILES components/AddNewProduct.qml
#         QML_FILES components/Toast.qml
#         SOURCES logic/batch.h logic/batch.cpp
#         SOURCES logic/batch.h logic/batch.cpp
#         SOURCES logic/configcommand.h
#         SOURCES logic/configcommand.cpp
#         SOURCES logic/customer.h logic/customer.cpp
#         QML_FILES components/ImportBatch.qml
#         QML_FILES
#         QML_FILES components/MainDrawer.qml
#         QML_FILES components/ProductDrawer.qml
#         QML_FILES components/SuggestionBox.qml
#         QML_FILES components/CustomerDrawer.qml
#         QML_FILES components/AddNewCustomer.qml
#         QML_FILES components/CustomerList.qml
#         QML_FILES components/CreateTransaction.qml
#         QML_FILES components/CustomSearchTextField.qml
#         SOURCES logic/order.h logic/order.cpp
#         QML_FILES components/CustomChart.qml
#         QML_FILES components/ProductListForTransaction.qml
#         QML_FILES components/ProductFormForTransaction.qml
#         QML_FILES components/TransactionDrawer.qml
#         QML_FILES components/Notification.qml
#         QML_FILES components/TransactionHistory.qml
#         QML_FILES components/OrderForm.qml
#         SOURCES logic/updateapp.h logic/updateapp.cpp
#         QML_FILES components/CustomerForm.qml
# )

qt_add_qml_module(appLanHuyStore
    URI LanHuyStore
    VERSION 1.0
    QML_FILES
        Main.qml
        components/Dashboard.qml
        components/ProductForm.qml
        components/ProductList.qml
        components/HeaderBar.qml
        components/Sales.qml
        components/Setting.qml
        components/AddNewProduct.qml
        components/Toast.qml
        components/ImportBatch.qml
        components/MainDrawer.qml
        components/ProductDrawer.qml
        components/SuggestionBox.qml
        components/CustomerDrawer.qml
        components/AddNewCustomer.qml
        components/CustomerList.qml
        components/CreateTransaction.qml
        components/CustomSearchTextField.qml
        components/CustomChart.qml
        components/ProductListForTransaction.qml
        components/ProductFormForTransaction.qml
        components/TransactionDrawer.qml
        components/Notification.qml
        components/TransactionHistory.qml
        components/OrderForm.qml
        components/CustomerForm.qml
    SOURCES
        logic/databasemanager.h logic/DatabaseManager.cpp
        logic/products.h logic/products.cpp
        logic/storeage.h logic/storeage.cpp
        logic/appcontroller.h logic/appcontroller.cpp
        logic/batch.h logic/batch.cpp
        logic/configcommand.h logic/configcommand.cpp
        logic/customer.h logic/customer.cpp
        logic/order.h logic/order.cpp
        logic/updateapp.h logic/updateapp.cpp
    RESOURCES
        resource.qrc

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.

set_target_properties(appLanHuyStore PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)


target_link_libraries(appLanHuyStore
    PRIVATE Qt6::Quick  Qt6::Sql Qt6::Charts
)

include(GNUInstallDirs)
install(TARGETS appLanHuyStore
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
