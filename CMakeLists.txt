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

set(PostgreSQL_ROOT "/Applications/Postgres.app/Contents/Versions/14")
set(CMAKE_PREFIX_PATH "${PostgreSQL_ROOT}")
link_directories("/Applications/Postgres.app/Contents/Versions/14/lib" "/Applications/Postgres.app/Contents/Versions/14/lib/postgresql")

qt_add_executable(appLanHuyStore
    main.cpp
)

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
        logic/promotion.h logic/promotion.cpp
        logic/setting.h logic/setting.cpp
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

link_directories("/opt/homebrew/opt/libpq/lib")
include_directories("/opt/homebrew/opt/libpq/include")
set(PostgreSQL_INCLUDE_DIR "/opt/homebrew/opt/libpq/include")
set(PostgreSQL_LIBRARY "/opt/homebrew/opt/libpq/lib/libpq.dylib")

target_link_libraries(appLanHuyStore
    PRIVATE Qt6::Quick Qt6::Sql Qt6::Charts
    /opt/homebrew/opt/libpq/lib/libpq.5.dylib
)

include(GNUInstallDirs)
install(TARGETS appLanHuyStore
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
