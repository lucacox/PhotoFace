#ifndef FACERECON_H
#define FACERECON_H

#include "Face.h"

#include <QObject>
#include <QRect>

typedef QList<Face*> FaceList;

class FaceRecon : public QObject {

    Q_OBJECT

    Q_PROPERTY(QString photoPath READ photoPath WRITE setPhotoPath NOTIFY photoPathChanged)

    public:
        explicit FaceRecon(QObject *parent = 0);

        void setPhotoPath(const QString& path);
        const QString photoPath() const;
        Q_INVOKABLE QList<QObject*> detectFaces();

    signals:
        void photoPathChanged();

    public slots:

    private:
        QString m_filename;

};

#endif // FACERECON_H
