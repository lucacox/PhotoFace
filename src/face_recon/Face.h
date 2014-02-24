#ifndef FACE_H
#define FACE_H

#include <QImage>
#include <QObject>
#include <QRect>

class Face : public QObject {

    Q_OBJECT

    Q_PROPERTY(QString file READ file WRITE setFile NOTIFY fileChanged)
    Q_PROPERTY(QRectF boundingRect READ boundingRect WRITE setBoundingRect NOTIFY boundingRectChanged)
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)

    public:
        explicit Face(QObject* parent = NULL);
        Face(const Face& face);

        Q_INVOKABLE const QString file() const;
        Q_INVOKABLE const QRectF boundingRect() const;

        Q_INVOKABLE void setFile(const QString& file);
        Q_INVOKABLE void setBoundingRect(const QRectF& rect);

        Q_INVOKABLE QImage image() const;
        Q_INVOKABLE void setImage(const QImage& image);

    signals:
        void fileChanged();
        void boundingRectChanged();
        void imageChanged();

    private:
        QString m_filename;
        QRectF m_boundingRect;
        QImage m_image;
};

#endif // FACE_H
