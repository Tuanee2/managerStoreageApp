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
    Q_INVOKABLE void downloadUpdate(const QUrl &url);

signals:
    void updateAvailable(const QString &version, const QUrl &downloadUrl);
    void updateDownloadProgress(qint64 bytesReceived, qint64 bytesTotal);
    void updateDownloaded(const QString &filePath);
    void updateError(const QString &errorString);

private:
    QNetworkAccessManager *manager;
};

#endif // UPDATEAPP_H
