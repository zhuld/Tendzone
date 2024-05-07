cmake_minimum_required(VERSION 3.16)

project(Tendzone VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)

qt_add_executable(Tendzone
    main.cpp
)

qt_add_qml_module(Tendzone
    URI Tendzone
    VERSION 1.0
    RESOURCES pic/tjhospital.png
    RESOURCES pic/haishi.png
    QML_FILES main.qml
    QML_FILES SettingDialog.qml
    QML_FILES ConfirmDialog.qml
    QML_FILES Language.qml
    QML_FILES BordLine.qml
    QML_FILES Logo.qml
    QML_FILES PasswordDialog.qml
    QML_FILES ProcessDialog.qml
    QML_FILES SocketStatus.qml
    QML_FILES WSServer.qml
    QML_FILES tendzone.js
    QML_FILES
    QML_FILES Splash.qml
    RESOURCES pic/splash.jpg
)
# qt6_add_resources(Tendzone
#     PREFIX
#         "/"
#     FILES
#         qtquickcontrols2.conf
# )

# qt6_add_resources(Tendzone "imagine-assets"
#     PREFIX
#         "/imagine-assets"
#     BASE
#         "imagine-assets"
#     FILES
#     "imagine-assets/applicationwindow-background.png"
#     "imagine-assets/applicationwindow-background@2x.png"
#     "imagine-assets/button-background-checked-hovered.9.png"
#     "imagine-assets/button-background-checked-hovered@2x.9.png"
#     "imagine-assets/button-background-checked.9.png"
#     "imagine-assets/button-background-checked@2x.9.png"
#     "imagine-assets/button-background-hovered.9.png"
#     "imagine-assets/button-background-hovered@2x.9.png"
#     "imagine-assets/button-background-pressed.9.png"
#     "imagine-assets/button-background-pressed@2x.9.png"
#     "imagine-assets/button-background.9.png"
#     "imagine-assets/button-background@2x.9.png"
#     "imagine-assets/dial-background-hovered.png"
#     "imagine-assets/dial-background-hovered@2x.png"
#     "imagine-assets/dial-background-pressed.png"
#     "imagine-assets/dial-background-pressed@2x.png"
#     "imagine-assets/dial-background.png"
#     "imagine-assets/dial-background@2x.png"
#     "imagine-assets/dial-handle-pressed.png"
#     "imagine-assets/dial-handle-pressed@2x.png"
#     "imagine-assets/dial-handle.png"
#     "imagine-assets/dial-handle@2x.png"
#     "imagine-assets/dialog-background.png"
#     "imagine-assets/dialog-background@2x.png"
#     "imagine-assets/frame-background.9.png"
#     "imagine-assets/frame-background@2x.9.png"
#     "imagine-assets/itemdelegate-background-checked.9.png"
#     "imagine-assets/itemdelegate-background-checked@2x.9.png"
#     "imagine-assets/itemdelegate-background-hovered.9.png"
#     "imagine-assets/itemdelegate-background-hovered@2x.9.png"
#     "imagine-assets/itemdelegate-background-pressed.9.png"
#     "imagine-assets/itemdelegate-background-pressed@2x.9.png"
#     "imagine-assets/itemdelegate-background.9.png"
#     "imagine-assets/itemdelegate-background@2x.9.png"
#     "imagine-assets/radiobutton-indicator-checked-hovered.png"
#     "imagine-assets/radiobutton-indicator-checked-hovered@2x.png"
#     "imagine-assets/radiobutton-indicator-checked-pressed.png"
#     "imagine-assets/radiobutton-indicator-checked-pressed@2x.png"
#     "imagine-assets/radiobutton-indicator-checked.png"
#     "imagine-assets/radiobutton-indicator-checked@2x.png"
#     "imagine-assets/radiobutton-indicator-hovered.png"
#     "imagine-assets/radiobutton-indicator-hovered@2x.png"
#     "imagine-assets/radiobutton-indicator-pressed.png"
#     "imagine-assets/radiobutton-indicator-pressed@2x.png"
#     "imagine-assets/radiobutton-indicator.png"
#     "imagine-assets/radiobutton-indicator@2x.png"
#     "imagine-assets/scrollindicator-handle.png"
#     "imagine-assets/scrollindicator-handle@2x.png"
#     "imagine-assets/slider-background-horizontal.9.png"
#     "imagine-assets/slider-background-horizontal@2x.9.png"
#     "imagine-assets/slider-handle-hovered.png"
#     "imagine-assets/slider-handle-hovered@2x.png"
#     "imagine-assets/slider-handle-pressed.png"
#     "imagine-assets/slider-handle-pressed@2x.png"
#     "imagine-assets/slider-handle.png"
#     "imagine-assets/slider-handle@2x.png"
#     "imagine-assets/slider-progress-horizontal-pressed.9.png"
#     "imagine-assets/slider-progress-horizontal-pressed@2x.9.png"
#     "imagine-assets/slider-progress-horizontal.9.png"
#     "imagine-assets/slider-progress-horizontal@2x.9.png"
#     "imagine-assets/switchdelegate-background.9.png"
#     "imagine-assets/switchdelegate-background@2x.9.png"
#     "imagine-assets/switchdelegate-handle-checked-hovered.png"
#     "imagine-assets/switchdelegate-handle-checked-hovered@2x.png"
#     "imagine-assets/switchdelegate-handle-checked.png"
#     "imagine-assets/switchdelegate-handle-checked@2x.png"
#     "imagine-assets/switchdelegate-handle-hovered.png"
#     "imagine-assets/switchdelegate-handle-hovered@2x.png"
#     "imagine-assets/switchdelegate-handle-pressed.png"
#     "imagine-assets/switchdelegate-handle-pressed@2x.png"
#     "imagine-assets/switchdelegate-handle.png"
#     "imagine-assets/switchdelegate-handle@2x.png"
#     "imagine-assets/switchdelegate-indicator-pressed.png"
#     "imagine-assets/switchdelegate-indicator-pressed@2x.png"
#     "imagine-assets/switchdelegate-indicator.png"
#     "imagine-assets/switchdelegate-indicator@2x.png"
#     "imagine-assets/toolseparator-separator-vertical.9.png"
#     "imagine-assets/toolseparator-separator-vertical@2x.9.png"
# )
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

target_link_libraries(Tendzone
    PRIVATE Qt6::Quick)

include(GNUInstallDirs)
install(TARGETS Tendzone
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
