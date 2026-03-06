import QtQuick

import "../dialog/"
import "../"

Item {
    states: [
        State {
            name: "zh_CN"
            PropertyChanges {
                roomNameConnect {
                    text: qsTr("连接中...")
                }
            }
            PropertyChanges {
                whiteBoard {
                    text: qsTr("白板模式\n上课")
                }
            }
            PropertyChanges {
                systemOn {
                    text: Global.settings.whiteboard ? "多媒体模式\n上课" : "上课"
                }
            }
            PropertyChanges {
                systemOff {
                    text: "下课"
                }
            }
            PropertyChanges {
                menuDialog {
                    languageLabel: "EN"
                    setting: "设置"
                    language: "语言"
                    vol: "音量"
                }
            }
            PropertyChanges {
                signalLabel {
                    text: "信号切换"
                }
            }
            PropertyChanges {
                computer {
                    text: "台式机"
                }
            }
            PropertyChanges {
                laptop {
                    text: "笔记本"
                }
            }
            PropertyChanges {
                wireless {
                    text: "无线投屏"
                }
            }
            PropertyChanges {
                projectorLabel {
                    text: "投影机控制"
                }
            }
            PropertyChanges {
                projectorOn {
                    text: "投影开"
                }
            }
            PropertyChanges {
                projectorOff {
                    text: "投影关"
                }
            }
            PropertyChanges {
                confirmDialog {
                    confirmTitle: "提示"
                    confirmContent: "确定执行 " + confirmDialog.name.replace(
                                        /\n/g, "") + " 操作？"
                    confirmOK: "确定"
                    confirmCancel: "取消 (" + confirmDialog.during + ")"
                }
            }
            PropertyChanges {
                settingDialog {
                    settingTitle: "系统设置 " + Application.version
                    settingOK: "确定"
                    settingCancel: "取消"
                    settingApply: "应用"
                }
            }
            PropertyChanges {
                processDialog {
                    processTitle: "提示"
                    processContent: "执行 " + processDialog.name.replace(
                                        /\n/g, "") + " 操作..."
                }
            }
            PropertyChanges {
                passwordDialog {
                    passwordTitle: "请输入" + (passwordDialog.passtype
                                            === PasswordDialog.Type.Settings ? "设置" : "锁屏") + "密码解锁"
                                   + (passwordDialog.passtype === PasswordDialog.Type.Settings ? " (" + passwordDialog.during + ")" : "")
                    passwordLabel: "如有问题可拨打电话：" + Global.settings.phoneNumber
                }
            }
            PropertyChanges {
                volumeDialog {
                    volumeLabel: "总音量"
                    volumeHDMiLabel: "电脑"
                }
            }
        },
        State {
            name: "en_US"
            PropertyChanges {
                roomNameConnect {
                    text: qsTr("Connecting...")
                }
            }
            PropertyChanges {
                whiteBoard {
                    text: "WhiteBoard Mode"
                }
            }
            PropertyChanges {
                systemOn {
                    text: Global.settings.whiteboard ? "Multimedia Mode" : "System On"
                }
            }
            PropertyChanges {
                systemOff {
                    text: "System Off"
                }
            }
            PropertyChanges {
                menuDialog {
                    languageLabel: "中"
                    setting: "Setting"
                    language: "Language"
                    vol: "Volume"
                }
            }
            PropertyChanges {
                signalLabel {
                    text: "Signal"
                }
            }
            PropertyChanges {
                computer {
                    text: "Computer"
                }
            }
            PropertyChanges {
                laptop {
                    text: "Laptop"
                }
            }
            PropertyChanges {
                wireless {
                    text: "Wireless"
                }
            }
            PropertyChanges {
                projectorLabel {
                    text: "Projector"
                }
            }
            PropertyChanges {
                projectorOn {
                    text: "Turn On"
                }
            }
            PropertyChanges {
                projectorOff {
                    text: "Turn Off"
                }
            }
            PropertyChanges {
                confirmDialog {
                    confirmTitle: "Notice"
                    confirmContent: "Confirm " + confirmDialog.name.replace(
                                        /\n/g, "") + " Operation?"
                    confirmOK: "Confirm"
                    confirmCancel: "Cancel (" + confirmDialog.during + ")"
                }
            }
            PropertyChanges {
                settingDialog {
                    settingTitle: "System Setup " + Application.version
                    settingOK: "OK"
                    settingCancel: "Cancel"
                    settingApply: "Apply"
                }
            }
            PropertyChanges {
                processDialog {
                    processTitle: "Notice"
                    processContent: "Process " + processDialog.name.replace(
                                        /\n/g, "") + " Operation..."
                }
            }
            PropertyChanges {
                passwordDialog {
                    passwordTitle: "Enter " + (passwordDialog.passtype === PasswordDialog.Type.Settings ? "Setting" : "LockScreen") + " Password to Unlock" + (passwordDialog.passtype === PasswordDialog.Type.Settings ? " (" + passwordDialog.during + ")" : "")
                    passwordLabel: "Pls Call " + Global.settings.phoneNumber + " for Help"
                }
            }
            PropertyChanges {
                volumeDialog {
                    volumeLabel: "Main"
                    volumeHDMiLabel: "PC"
                }
            }
        }
    ]
}
