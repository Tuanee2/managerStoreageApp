#ifndef UPDATEAPP_H
#define UPDATEAPP_H

#include <QObject>
#include <QUrl>
#include <QNetworkAccessManager>

class UpdateApp : public QObject
{
    Q_OBJECT
public:
    explicit UpdateApp(QObject *parent = nullptr);

    Q_INVOKABLE void checkForUpdate();
    Q_INVOKABLE void downloadUpdate();

signals:
    void updateAvailable(const QString &version);
    void updateDownloadProgress(qint64 bytesReceived, qint64 bytesTotal);
    void updateDownloaded(const QString &filePath);
    void updateError(const QString &errorString);

private:
    QNetworkAccessManager *manager;
    QUrl dlurl;
};

#endif // UPDATEAPP_H
