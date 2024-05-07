import QtQuick

Item {
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
                target: lang; text: "E" }
            PropertyChanges {
                target: signalLabel; text: "信号切换" }
            PropertyChanges {
                target: computer; text: "台式机" }
            PropertyChanges {
                target: lantop; text: "笔记本" }
            PropertyChanges {
                target: wireless; text: "无线投屏" }
            PropertyChanges {
                target: projectorLabel; text: "投影机" }
            PropertyChanges {
                target: projectorOn; text: "投影机开" }
            PropertyChanges {
                target: projectorOff; text: "投影机关" }
            PropertyChanges {
                target: settingDialog; settingTitle: "系统设置 "+Application.version }
            PropertyChanges {
                target: confirmDialog; confirmTitle: "提示" }
            PropertyChanges {
                target: confirmDialog; confirmContent: "确定执行操作？" }
            PropertyChanges {
                target: confirmDialog; confirmOK: "确定" }
            PropertyChanges {
                target: confirmDialog; confirmCancel: "取消" }
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
                target: passwordDialog; passwordTitle: "请输入密码解锁" }
            PropertyChanges {
                target: passwordDialog; passwordLabel: "如有问题可拨打电话："+settings.phoneNumber }
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
                target: lang; text: "中" }
            PropertyChanges {
                target: signalLabel; text: "Signal" }
            PropertyChanges {
                target: computer; text: "Computer" }
            PropertyChanges {
                target: lantop; text: "Lantop" }
            PropertyChanges {
                target: wireless; text: "Wireless" }
            PropertyChanges {
                target: projectorLabel; text: "Projector" }
            PropertyChanges {
                target: projectorOn; text: "On" }
            PropertyChanges {
                target: projectorOff; text: "Off" }
            PropertyChanges {
                target: settingDialog; settingTitle: "System Setup " + Application.version}
            PropertyChanges {
                target: confirmDialog; confirmTitle: "Notice" }
            PropertyChanges {
                target: confirmDialog; confirmContent: "Confirm this Operation?" }
            PropertyChanges {
                target: confirmDialog; confirmOK: "Confirm" }
            PropertyChanges {
                target: confirmDialog; confirmCancel: "Cancel" }
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
                target: passwordDialog; passwordTitle: "Enter Password to Unlock" }
            PropertyChanges {
                target: passwordDialog; passwordLabel: "Pls Call "+settings.phoneNumber +" for Help"}
        }
    ]
}
