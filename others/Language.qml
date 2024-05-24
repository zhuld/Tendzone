import QtQuick

import "../dialog/"

Item {
    id:languageStates
    states: [
        State {
            name: "chinese"
            PropertyChanges {
                target: whiteBoard; text: "白板上课" }
            PropertyChanges {
                target: systemOn; text: "上课" }
            PropertyChanges {
                target: systemOff; text: "下课" }
            PropertyChanges {
                target: menuDialog; language: "EN" }
            PropertyChanges {
                target: menuDialog; settingLable: "设置" }
            PropertyChanges {
                target: menuDialog; languageLable: "语言" }
            PropertyChanges {
                target: menuDialog; volLabel: "音量" }
            PropertyChanges {
                target: menuDialog; helpLabel: "帮助" }
            PropertyChanges {
                target: menuDialog; guideLabel: "指引" }
            PropertyChanges {
                target: signalLabel; text: "信号切换" }
            PropertyChanges {
                target: computer; text: "台式机" }
            PropertyChanges {
                target: laptop; text: "笔记本" }
            PropertyChanges {
                target: wireless; text: "无线投屏" }
            PropertyChanges {
                target: projectorLabel; text: "投影机" }
            PropertyChanges {
                target: projectorOn; text: "投影机开" }
            PropertyChanges {
                target: projectorOff; text: "投影机关" }
            PropertyChanges {
                target: confirmDialog; confirmTitle: "提示" }
            PropertyChanges {
                target: confirmDialog; confirmContent: "确定执行操作？" }
            PropertyChanges {
                target: confirmDialog; confirmOK: "确定" }
            PropertyChanges {
                target: confirmDialog; confirmCancel: "取消" }
            PropertyChanges {
                target: settingDialog; settingTitle: "系统设置 "+Application.version }
            PropertyChanges {
                target: settingDialog; settingOK: "确定" }
            PropertyChanges {
                target: settingDialog; settingCancel: "取消" }
            PropertyChanges {
                target: settingDialog; settingApply: "应用" }
            PropertyChanges {
                target: processDialog; processTitle: "提示" }
            PropertyChanges {
                target: processDialog; processContent: "执行操作中..." }
            PropertyChanges {
                target: passwordDialog; passwordTitle: "请输入"+(passwordDialog.passtype === PasswordDialog.Type.Settings ? "设置" : "锁屏")+"密码解锁" }
            PropertyChanges {
                target: passwordDialog; passwordLabel: "如有问题可拨打电话："+settings.phoneNumber }
            PropertyChanges {
                target: volumeDialog; volumeLabel: "总音量"}
            PropertyChanges {
               target: volumeDialog; volumeHDMiLabel: "电脑"}

        },
        State {
            name: "english"
            PropertyChanges {
                target: whiteBoard; text: "WhiteBoard" }
            PropertyChanges {
                target: systemOn; text: "System On" }
            PropertyChanges {
                target: systemOff; text: "System Off" }
            PropertyChanges {
                target: menuDialog; language: "中" }
            PropertyChanges {
                target: menuDialog; settingLable: "Setting" }
            PropertyChanges {
                target: menuDialog; languageLable: "Language" }
            PropertyChanges {
                target: menuDialog; volLabel: "Volume" }
            PropertyChanges {
                target: menuDialog; helpLabel: "Help" }
            PropertyChanges {
                target: menuDialog; guideLabel: "Guide" }
            PropertyChanges {
                target: signalLabel; text: "Signal" }
            PropertyChanges {
                target: computer; text: "Computer" }
            PropertyChanges {
                target: laptop; text: "Laptop" }
            PropertyChanges {
                target: wireless; text: "Wireless" }
            PropertyChanges {
                target: projectorLabel; text: "Projector" }
            PropertyChanges {
                target: projectorOn; text: "Turn On" }
            PropertyChanges {
                target: projectorOff; text: "Turn Off" }
            PropertyChanges {
                target: confirmDialog; confirmTitle: "Notice" }
            PropertyChanges {
                target: confirmDialog; confirmContent: "Confirm this Operation?" }
            PropertyChanges {
                target: confirmDialog; confirmOK: "Confirm" }
            PropertyChanges {
                target: confirmDialog; confirmCancel: "Cancel" }
            PropertyChanges {
                target: settingDialog; settingTitle: "System Setup " + Application.version}
            PropertyChanges {
                target: settingDialog; settingOK: "OK" }
            PropertyChanges {
                target: settingDialog; settingCancel: "Cancel" }
            PropertyChanges {
                target: settingDialog; settingApply: "Apply" }
            PropertyChanges {
                target: processDialog; processTitle: "Notice" }
            PropertyChanges {
                target: processDialog; processContent: "Process Operation..." }
            PropertyChanges {
                target: passwordDialog; passwordTitle: "Enter "+(passwordDialog.passtype === PasswordDialog.Type.Settings ? "Setting" : "LockScreen")+" Password to Unlock" }
            PropertyChanges {
                target: passwordDialog; passwordLabel: "Pls Call "+settings.phoneNumber +" for Help"}
            PropertyChanges {
                target: volumeDialog; volumeLabel: "Main"}
            PropertyChanges {
               target: volumeDialog; volumeHDMiLabel: "PC"}
        }
    ]
}
