cmake_minimum_required(VERSION 3.16)

project(Tendzone VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(Tendzone
    main.cpp
)
qt_add_qml_module(Tendzone
    URI Tendzone
    VERSION 1.0
    RESOURCES pic/tjhospital.png
    RESOURCES pic/haishi.png
    RESOURCES pic/splash.jpg
    QML_FILES main.qml
    QML_FILES dialog/ConfirmDialog.qml
    QML_FILES dialog/PasswordDialog.qml
    QML_FILES dialog/ProcessDialog.qml
    QML_FILES dialog/VolumeDialog.qml
    QML_FILES dialog/SettingDialog.qml
    QML_FILES dialog/MenuDialog.qml
    QML_FILES others/Language.qml
    QML_FILES others/BordLine.qml
    QML_FILES others/Logo.qml
    QML_FILES others/Splash.qml
    QML_FILES others/Background.qml
    QML_FILES websocket/SocketStatus.qml
    QML_FILES websocket/WSServer.qml
    QML_FILES websocket/WSClient.qml
    QML_FILES button/ColorButton.qml
    QML_FILES button/MenuButton.qml
    QML_FILES js/tendzone.js
)
# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(Tendzone PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.Tendzone
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)
set_property(TARGET Tendzone
    APPEND PROPERTY  QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)

target_link_libraries(Tendzone
    PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(TARGETS Tendzone
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
