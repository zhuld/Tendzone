#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/Tendzone/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    app.setOrganizationName("Zhuld");
    app.setOrganizationDomain("zld.com");
    app.setApplicationName("Tendzone Control");
    app.setApplicationVersion("V0.3.00");

    engine.load(url);

    return app.exec();
}
