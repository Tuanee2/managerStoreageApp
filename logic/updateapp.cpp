#include "updateapp.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QXmlStreamReader>
#include <QFile>
#include <QStandardPaths>
#include <QCoreApplication>
#include <QDebug>

UpdateApp::UpdateApp(QObject *parent)
    : QObject{parent}
{
    manager = new QNetworkAccessManager(this);
}

void UpdateApp::checkForUpdate() {
    QUrl url("https://tuanee2.github.io/managerStoreageApp/Updates.xml");
    QNetworkRequest request(url);
    QNetworkReply *reply = manager->get(request);

    connect(reply, &QNetworkReply::finished, this, [=]() {
        if (reply->error() != QNetworkReply::NoError) {
            emit updateError(reply->errorString());
            reply->deleteLater();
            return;
        }

        QByteArray xmlData = reply->readAll();
        QXmlStreamReader xml(xmlData);

        QString latestVersion;
        QString downloadFileName;

        while (!xml.atEnd() && !xml.hasError()) {
            xml.readNext();
            if (xml.isStartElement()) {
                if (xml.name() == "Version") {
                    latestVersion = xml.readElementText();
                } else if (xml.name() == "DownloadableArchives") {
                    downloadFileName = xml.readElementText();
                }
            }
        }

        reply->deleteLater();

        if (xml.hasError()) {
            emit updateError("❌ Failed to parse Updates.xml");
            return;
        }

        QString currentVersion = QCoreApplication::applicationVersion();

        if (latestVersion > currentVersion && !downloadFileName.isEmpty()) {
            QUrl downloadUrl("https://tuanee2.github.io/managerStoreageApp/" + downloadFileName);
            emit updateAvailable(latestVersion, downloadUrl);
        } else {
            qDebug() << "✅ No update available.";
        }
    });
}

void UpdateApp::downloadUpdate(const QUrl &url) {
    QNetworkRequest request(url);
    QNetworkReply *reply = manager->get(request);

    QString downloadPath = QStandardPaths::writableLocation(QStandardPaths::DownloadLocation)
                           + "/update_installer.7z";
    QFile *file = new QFile(downloadPath);

    if (!file->open(QIODevice::WriteOnly)) {
        emit updateError("❌ Cannot open file for writing");
        delete file;
        return;
    }

    connect(reply, &QNetworkReply::readyRead, this, [=]() {
        file->write(reply->readAll());
    });

    connect(reply, &QNetworkReply::downloadProgress, this, &UpdateApp::updateDownloadProgress);

    connect(reply, &QNetworkReply::finished, this, [=]() {
        file->flush();
        file->close();
        emit updateDownloaded(file->fileName());
        reply->deleteLater();
        file->deleteLater();
    });
}