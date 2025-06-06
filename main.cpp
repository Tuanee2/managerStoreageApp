#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QThread>
#include <QQmlContext>
#include <QDir>
#include <QIcon>
#include "logic/storeage.h"
#include "logic/databasemanager.h"
#include "logic/appcontroller.h"
#include "logic/updateapp.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationVersion("1.0.0");
    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon("qrc:/images/Icon/main_logo.png"));
    QDir::setCurrent(QCoreApplication::applicationDirPath());

    QThread* dbThread = new QThread;
    storeage* store = new storeage();
    store->moveToThread(dbThread);
    QMetaObject::invokeMethod(store, "initialize", Qt::QueuedConnection);
    QObject::connect(&app, &QCoreApplication::aboutToQuit, dbThread, &QThread::quit);
    QObject::connect(dbThread, &QThread::finished, store, &QObject::deleteLater);
    dbThread->start();

    UpdateApp *updater = new UpdateApp();
    appcontroller* controller = new appcontroller(store);


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("controller", controller);
    engine.rootContext()->setContextProperty("updater", updater);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("LanHuyStore", "Main");

    return app.exec();
}
