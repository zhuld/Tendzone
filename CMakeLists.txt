cmake_minimum_required(VERSION 3.16)

project(Tendzone VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.10 COMPONENTS Quick REQUIRED)

set_source_files_properties(
    Global.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_executable(Tendzone
    main.cpp Resources.qrc
)

qt_add_qml_module(Tendzone
    URI Tendzone
    VERSION 1.0
    QML_FILES main.qml
    QML_FILES dialog/ConfirmDialog.qml
    QML_FILES dialog/PasswordDialog.qml
    QML_FILES dialog/ProcessDialog.qml
    QML_FILES dialog/VolumeDialog.qml
    QML_FILES dialog/SettingDialog.qml
    QML_FILES dialog/MenuDialog.qml
    QML_FILES others/Language.qml
    QML_FILES others/Splash.qml
    QML_FILES others/Background.qml

    QML_FILES websocket/WSServer.qml
    QML_FILES websocket/WSClient.qml

    QML_FILES Global.qml

    QML_FILES websocket/SocketStatus.qml
    QML_FILES js/tendzone.js
    QML_FILES button/MyButton.qml
    QML_FILES button/MyIconLabel.qml
    RESOURCES Resources.qrc
    QML_FILES others/DialogBackground.qml
    QML_FILES others/InputBackground.qml
    QML_FILES button/MySwitch.qml
    QML_FILES button/MyDelayButton.qml
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
    QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
)

target_link_libraries(Tendzone
    PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(TARGETS Tendzone
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
