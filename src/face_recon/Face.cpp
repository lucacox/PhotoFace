#include "Face.h"

Face::Face(QObject *parent)
    : QObject(parent)
{
}

Face::Face(const Face &face)
{
    m_filename = face.file();
    m_boundingRect = face.boundingRect();
}

const QString Face::file() const
{
    return m_filename;
}

const QRectF Face::boundingRect() const
{
    return m_boundingRect;
}

QImage Face::image() const
{
    return m_image;
}

void Face::setImage(const QImage& image)
{
    m_image = image;
}

void Face::setFile(const QString &file)
{
    m_filename = file;
    emit fileChanged();
}

void Face::setBoundingRect(const QRectF &rect)
{
    m_boundingRect = rect;
    emit boundingRectChanged();
}
