#include <QGuiApplication>
#include <QQmlApplicationEngine>

// #include <QTimer>
// #include <QtAndroid>

int main(int argc, char *argv[])
{
    if(QSysInfo::productType() != "android"){
        qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));
    }
    QGuiApplication app(argc, argv);

    // QTimer::singleShot(3000,NULL,[=](){
    //     QtAndroid::hideSplashScreen(500)
    // });

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

    engine.load(url);

    return app.exec();
}
