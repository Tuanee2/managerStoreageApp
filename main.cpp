#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QThread>
#include <QQmlContext>
#include "logic/storeage.h"
#include "logic/databasemanager.h"
#include "logic/appcontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QThread* dbThread = new QThread;
    storeage* store = new storeage();
    store->moveToThread(dbThread);
    QMetaObject::invokeMethod(store, "initialize", Qt::QueuedConnection);
    QObject::connect(&app, &QCoreApplication::aboutToQuit, dbThread, &QThread::quit);
    QObject::connect(dbThread, &QThread::finished, store, &QObject::deleteLater);
    dbThread->start();

    appcontroller* controller = new appcontroller(store);


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("controller", controller);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("forHa", "Main");

    return app.exec();
}
