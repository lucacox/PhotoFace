#include <QApplication>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QStandardPaths>
#include <QtQml>

#include "face_recon/FaceRecon.h"

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);

    QString mainQmlApp("../qml/MainView.qml");

//    qmlRegisterType<FaceList>("FaceList", 1, 0, "FaceList");

    // pictures path
    QStringList locations = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    QString pic_path = locations.at(0);
    if (pic_path.split(":").size() > 1) {
        pic_path = pic_path.split(":").at(1);
    }

    FaceRecon* recon = new FaceRecon();

    QQmlApplicationEngine engine;
    QQmlContext* context = engine.rootContext();
    context->setContextProperty("pictures_folder", pic_path);
    context->setContextProperty("recognizer", recon);
    engine.load(mainQmlApp);
    QObject* topLevel = engine.rootObjects().value(0);
    QQuickWindow* window = qobject_cast<QQuickWindow*>(topLevel);
    window->show();

    int ret = app.exec();

    // post exit code

    return ret;
}
