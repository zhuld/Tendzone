import QtQuick

import "../dialog/"
import "../"

Item {
    states: [
        State {
            name: "zh_CN"
            PropertyChanges {
                target: whiteBoard
                text: qsTr("白板模式\n上课")
            }
            PropertyChanges {
                target: systemOn
                text: Global.settings.whiteboard ? "多媒体模式\n上课" : "上课"
            }
            PropertyChanges {
                target: systemOff
                text: "下课"
            }
            PropertyChanges {
                target: menuDialog
                languageLabel: "EN"
            }
            PropertyChanges {
                target: menuDialog
                setting: "设置"
            }
            PropertyChanges {
                target: menuDialog
                language: "语言"
            }
            PropertyChanges {
                target: menuDialog
                vol: "音量"
            }
            // PropertyChanges {
            //     target: menuDialog
            //     help: "帮助"
            // }
            // PropertyChanges {
            //     target: menuDialog
            //     guide: "指引"
            // }
            PropertyChanges {
                target: signalLabel
                text: "信号切换"
            }
            PropertyChanges {
                target: computer
                text: "台式机"
            }
            PropertyChanges {
                target: laptop
                text: "笔记本"
            }
            PropertyChanges {
                target: wireless
                text: "无线投屏"
            }
            PropertyChanges {
                target: projectorLabel
                text: "投影机控制"
            }
            PropertyChanges {
                target: projectorOn
                text: "投影开"
            }
            PropertyChanges {
                target: projectorOff
                text: "投影关"
            }
            PropertyChanges {
                target: confirmDialog
                confirmTitle: "提示"
            }
            PropertyChanges {
                target: confirmDialog
                confirmContent: "确定执行 " + confirmDialog.name.replace(
                                    /\n/g, "") + " 操作？"
            }
            PropertyChanges {
                target: confirmDialog
                confirmOK: "确定"
            }
            PropertyChanges {
                target: confirmDialog
                confirmCancel: "取消 (" + confirmDialog.during + ")"
            }
            PropertyChanges {
                target: settingDialog
                settingTitle: "系统设置 " + Application.version
            }
            PropertyChanges {
                target: settingDialog
                settingOK: "确定"
            }
            PropertyChanges {
                target: settingDialog
                settingCancel: "取消"
            }
            PropertyChanges {
                target: settingDialog
                settingApply: "应用"
            }
            PropertyChanges {
                target: processDialog
                processTitle: "提示"
            }
            PropertyChanges {
                target: processDialog
                processContent: "执行 " + processDialog.name.replace(
                                    /\n/g, "") + " 操作..."
            }
            PropertyChanges {
                target: passwordDialog
                passwordTitle: "请输入" + (passwordDialog.passtype
                                        === PasswordDialog.Type.Settings ? "设置" : "锁屏") + "密码解锁"
                               + (passwordDialog.passtype
                                  === PasswordDialog.Type.Settings ? " (" + passwordDialog.during
                                                                     + ")" : "")
            }
            PropertyChanges {
                target: passwordDialog
                passwordLabel: "如有问题可拨打电话：" + Global.settings.phoneNumber
            }
            PropertyChanges {
                target: volumeDialog
                volumeLabel: "总音量"
            }
            PropertyChanges {
                target: volumeDialog
                volumeHDMiLabel: "电脑"
            }
        },
        State {
            name: "en_US"
            PropertyChanges {
                target: whiteBoard
                text: "WhiteBoard Mode"
            }
            PropertyChanges {
                target: systemOn
                text: Global.settings.whiteboard ? "Multimedia Mode" : "System On"
            }
            PropertyChanges {
                target: systemOff
                text: "System Off"
            }
            PropertyChanges {
                target: menuDialog
                languageLabel: "中"
            }
            PropertyChanges {
                target: menuDialog
                setting: "Setting"
            }
            PropertyChanges {
                target: menuDialog
                language: "Language"
            }
            PropertyChanges {
                target: menuDialog
                vol: "Volume"
            }
            // PropertyChanges {
            //     target: menuDialog
            //     help: "Help"
            // }
            // PropertyChanges {
            //     target: menuDialog
            //     guide: "Guide"
            // }
            PropertyChanges {
                target: signalLabel
                text: "Signal"
            }
            PropertyChanges {
                target: computer
                text: "Computer"
            }
            PropertyChanges {
                target: laptop
                text: "Laptop"
            }
            PropertyChanges {
                target: wireless
                text: "Wireless"
            }
            PropertyChanges {
                target: projectorLabel
                text: "Projector"
            }
            PropertyChanges {
                target: projectorOn
                text: "Turn On"
            }
            PropertyChanges {
                target: projectorOff
                text: "Turn Off"
            }
            PropertyChanges {
                target: confirmDialog
                confirmTitle: "Notice"
            }
            PropertyChanges {
                target: confirmDialog
                confirmContent: "Confirm " + confirmDialog.name.replace(
                                    /\n/g, "") + " Operation?"
            }
            PropertyChanges {
                target: confirmDialog
                confirmOK: "Confirm"
            }
            PropertyChanges {
                target: confirmDialog
                confirmCancel: "Cancel (" + confirmDialog.during + ")"
            }
            PropertyChanges {
                target: settingDialog
                settingTitle: "System Setup " + Application.version
            }
            PropertyChanges {
                target: settingDialog
                settingOK: "OK"
            }
            PropertyChanges {
                target: settingDialog
                settingCancel: "Cancel"
            }
            PropertyChanges {
                target: settingDialog
                settingApply: "Apply"
            }
            PropertyChanges {
                target: processDialog
                processTitle: "Notice"
            }
            PropertyChanges {
                target: processDialog
                processContent: "Process " + processDialog.name.replace(
                                    /\n/g, "") + " Operation..."
            }
            PropertyChanges {
                target: passwordDialog
                passwordTitle: "Enter " + (passwordDialog.passtype === PasswordDialog.Type.Settings ? "Setting" : "LockScreen") + " Password to Unlock" + (passwordDialog.passtype === PasswordDialog.Type.Settings ? " (" + passwordDialog.during + ")" : "")
            }
            PropertyChanges {
                target: passwordDialog
                passwordLabel: "Pls Call " + Global.settings.phoneNumber + " for Help"
            }
            PropertyChanges {
                target: volumeDialog
                volumeLabel: "Main"
            }
            PropertyChanges {
                target: volumeDialog
                volumeHDMiLabel: "PC"
            }
        }
    ]
}
