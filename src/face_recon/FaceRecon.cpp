#include "FaceRecon.h"

#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/objdetect/objdetect.hpp>

#include <QImage>
#include <QDebug>

//copy the data of cv::Mat to QImage
QImage mat_to_qimage_cpy(cv::Mat const &mat,
                         QImage::Format format)
{
    return QImage(mat.data, mat.cols, mat.rows,
                  mat.step, format).copy();
}

//copy the data of QImage to cv::Mat
cv::Mat qImageToCvMat(const QImage &inImage, bool inCloneImageData = true)
{
    switch (inImage.format()) {
    // 8-bit, 4 channel
    case QImage::Format_RGB32:
    {
        cv::Mat  mat( inImage.height(), inImage.width(), CV_8UC4, const_cast<uchar*>(inImage.bits()), inImage.bytesPerLine() );

        return (inCloneImageData ? mat.clone() : mat);
    }

        // 8-bit, 3 channel
    case QImage::Format_RGB888:
    {
        if ( !inCloneImageData )
            qWarning() << "ASM::QImageToCvMat() - Conversion requires cloning since we use a temporary QImage";

        QImage   swapped = inImage.rgbSwapped();

        return cv::Mat( swapped.height(), swapped.width(), CV_8UC3, const_cast<uchar*>(swapped.bits()), swapped.bytesPerLine() ).clone();
    }

        // 8-bit, 1 channel
    case QImage::Format_Indexed8:
    {
        cv::Mat  mat( inImage.height(), inImage.width(), CV_8UC1, const_cast<uchar*>(inImage.bits()), inImage.bytesPerLine() );

        return (inCloneImageData ? mat.clone() : mat);
    }

    default:
        qWarning() << "ASM::QImageToCvMat() - QImage format not handled in switch:" << inImage.format();
        break;
    }

    return cv::Mat();
}

FaceRecon::FaceRecon(QObject *parent) :
    QObject(parent)
{

}

void FaceRecon::setPhotoPath(const QString &path)
{
    m_filename = path;
    qDebug() << "filename:" << m_filename;
    emit photoPathChanged();
}

const QString FaceRecon::photoPath() const
{
    return m_filename;
}

QList<QObject*> FaceRecon::detectFaces()
{
    QImage img(m_filename);

    cv::Mat cvImg = qImageToCvMat(img);
//    cv::Mat cvImg = cv::imread(m_filename.toStdString());

    qDebug() << m_filename;
    qDebug() << cvImg.cols << cvImg.rows;

    QString face_cascade_name = "C:/opencv/sources/data/haarcascades/haarcascade_frontalface_alt.xml";
    cv::CascadeClassifier frontal_face_classifier;
    frontal_face_classifier.load(face_cascade_name.toStdString());

    std::vector<cv::Rect> frontalFaces;
    cv::Mat grey;
    cv::cvtColor(cvImg, grey, CV_BGR2GRAY);
    cv::Mat eq;
    cv::equalizeHist(grey, eq);

    frontal_face_classifier.detectMultiScale(eq, frontalFaces, 1.1, 2, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    for (size_t j = 0; j < frontalFaces.size(); j++) {
       cv::rectangle(cvImg, frontalFaces[j], cv::Scalar(255, 0, 0), 2);
    }
//    cv::namedWindow("faccia", CV_WINDOW_NORMAL);
//    cv::imshow("faccia", cvImg);

    qDebug() << frontalFaces.size();

    QList<QObject*> faces;
    for (int i=0; i<frontalFaces.size(); ++i) {
        QRectF rect(frontalFaces[i].x, frontalFaces[i].y, frontalFaces[i].width, frontalFaces[i].height);
        qDebug() << "Face" << i << rect;

        Face* f = new Face();
        f->setFile(m_filename);
        f->setBoundingRect(rect);
        f->setImage(img.copy(rect.toRect()));
        faces << f;
    }

    return faces;
}
