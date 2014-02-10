#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);

    QString mainQmlApp("../qml/MainView.qml");

    QQmlApplicationEngine engine;
    engine.load(mainQmlApp);
    QObject* topLevel = engine.rootObjects().value(0);
    QQuickWindow* window = qobject_cast<QQuickWindow*>(topLevel);
    window->show();

    int ret = app.exec();

    // post exit code

    return ret;
}
