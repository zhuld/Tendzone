const op_code_UNSUBSCRIBE = 0x8005;
const op_code_SUBSCRIBE = 0x8002;
const op_code_SETTING = 0x8003;
const op_code_REPORT = 0x8004;

const uuid_HOST_PARAMS = 0x1100;
const uuid_NET_PARAMS = 0x1101;
const uuid_BLE_PARAMS = 0x1200;
const uuid_AUDIO_PARAM = 0x1303;
//const uuid_AUDIO_INPUT = 0x1303;
//const uuid_AUDIO_OUTPUT = 0x1303;
//const uuid_GLOBAL_VOL = 0x1303;
const uuid_IR_MIC_CONFIG = 0x1302;

const uuid_HDMI_PARAMS = 0x1400;
const uuid_POWER_PARAMS = 0x1500;
const uuid_T8040_PARAMS = 0x1700;

//uuid_POWER_PARAMS
const id_Power_Sub = 0x0000;
const id_Power = 0x0001;
const val_Power_Mubu = 1;
const val_Power_Projector = 2;
const val_Power_Extension = 3;
const val_Power_Lock = 4;

//uuid_HOST_PARAMS
const id_Machine_Name = 0x0000
const id_Fireware_Version = 0x0001
const id_Machine_Type = 0x0002
const id_Manufacture_Date = 0x0003
const id_Hardware_Version = 0x0004
const id_Serial_Number = 0x0005
const id_Connected = 0x0007
const id_Password = 0x0008
const id_Reboot = 0x0009
const id_Reset = 0x000A
const id_Date_Time = 0x000B
const id_Heart_Beat = 0x000C

//uuid_AUDIO_PARAM
const id_Audio_SetParam = 0x0000
const id_Audio_LineIn = 0x0001
const id_Audio_MicIn = 0x0002
const id_Audio_TDIRIn = 0x0003
const id_Audio_LineOut = 0x0004
const id_Audio_AMPOut = 0x0005
const id_Audio_Level = 0x0006
const id_Audio_GlobalVol = 0x0007
const id_Audio_HDMI = 0x0008

//uuid_T8040_PARAMS
const id_Key = 0x0000;
const id_CPU = 0x0000;

//uuid_HDMI_PARAMS
const id_Extend = 0x0001;
const id_Monitor = 0x0002;
const id_Projector = 0x0003;
const val_PC = 1;
const val_Laptop = 2;
const val_Wireless = 3;
const val_Camera = 4;

//uuid_POWER_PARAMS
const id_Uart_Set = 0x0004;
const id_Uart = 0x0006;
const val_Uart1 = 6;
const val_Uart2 = 7;
const val_Uart3 = 8;

//val
const val_On = 0x01;
const val_Off = 0x00;
const val_Stop = 0x00;
const val_Up = 0x01;
const val_Down = 0x02;

const Command = {
    Projector_On: Symbol("Projector_On"),
    Projector_Off: Symbol("Projector_Off"),
    Extension_On: Symbol("Extension_On"),
    Extension_Off: Symbol("Extension_Off"),
    Lock_On: Symbol("Lock_On"),
    Lock_Off: Symbol("Lock_Off"),
    Amp_On: Symbol("Amp_On"),
    Amp_Off: Symbol("Amp_Off"),
    Mubu_Up: Symbol("Mubu_Up"),
    Mubu_Stop: Symbol("Mubu_Stop"),
    Mubu_Down: Symbol("Mubu_Down"),
    Uart_1_Projector_On: Symbol("Uart_1_Projector_On"),
    Uart_1_Projector_Off: Symbol("Uart_1_Projector_Off"),
    Uart_2_Projector_On: Symbol("Uart_2_Projector_On"),
    Uart_2_Projector_Off: Symbol("Uart_2_Projector_Off"),
    Projector_PC: Symbol("Projector_PC"),
    Projector_Lantop: Symbol("Projector_Lantop"),
    Projector_Wireless: Symbol("Projector_Wireless"),
    Projector_Camera: Symbol("Projector_Camera"),
    Extender_PC: Symbol("Extender_PC"),
    Extender_Lantop: Symbol("Extender_Lantop"),
    Extender_Wireless: Symbol("Extender_Wireless"),
    Extender_Camera: Symbol("Extender_Camera"),
    Monitor_PC: Symbol("Monitor_PC"),
    Monitor_Lantop: Symbol("Monitor_Lantop"),
    Monitor_Wireless: Symbol("Monitor_Wireless"),
    Monitor_Camera: Symbol("Monitor_Camera"),
    subHDMIProjector: Symbol("subHDMIProjector"),
    subHDMIExtend: Symbol("subHDMIExtend"),
    subPowerParm: Symbol("subPowerParm"),
    subMachineName: Symbol("subMachineName"),
    reboot: Symbol("reboot"),
}

const Projectors = ["Epson","Sony"]
//Projector Cdoe
const Projectors_Code = {
    Sony:[
        {Code:new Uint8Array([0xA9, 0x17, 0x2F, 0x00, 0x00, 0x00, 0x3F, 0x9A])}, //val_Off:0
        {Code:new Uint8Array([0xA9, 0x17, 0x2E, 0x00, 0x00, 0x00, 0x3F, 0x9A])}, //val_On:1
    ],
    Epson:[
        {Code:new Uint8Array([0x50, 0x57, 0x52, 0x20, 0x4F, 0x46, 0x46, 0x0D])},
        {Code:new Uint8Array([0x50, 0x57, 0x52, 0x20, 0x4F, 0x4E, 0x0D])},
    ]
}



const TJHospital = {
    Logo:{Url:"pic/tjhospital.png"},
    WhiteBoard:{
        Confirm:true,
        Commands:[
            {Name: Command.Lock_Off, Delay: 1},
            {Name: Command.Extension_On, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Uart_2_Projector_Off, Delay: 1},
            {Name: Command.Mubu_Up, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Uart_2_Projector_Off, Delay: 25},
            {Name: Command.Projector_Off, Delay: 1},
            {Name: Command.Monitor_PC, Delay: 1},
            {Name: Command.Amp_On, Delay: 1},
        ]
    },
    SystemOn:{
        Confirm:true,
        Commands:[
            {Name: Command.Lock_On, Delay: 1},
            {Name: Command.Extension_On, Delay: 1},
            {Name: Command.Projector_On, Delay: 1},
            {Name: Command.Mubu_Down, Delay: 10},
            {Name: Command.Uart_1_Projector_On, Delay: 1},
            {Name: Command.Uart_2_Projector_On, Delay: 1},
            {Name: Command.Uart_1_Projector_On, Delay: 1},
            {Name: Command.Uart_2_Projector_On, Delay: 25},
            {Name: Command.Monitor_PC, Delay: 1},
            {Name: Command.Projector_PC, Delay: 1},
            {Name: Command.Extender_PC, Delay: 1},
            {Name: Command.Amp_On, Delay: 1},
        ]
    },
    SystemOff:{
        Confirm:true,
        Commands:[
            {Name: Command.Amp_Off, Delay: 1},
            {Name: Command.Lock_Off, Delay: 1},
            {Name: Command.Extension_Off, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Uart_2_Projector_Off, Delay: 1},
            {Name: Command.Mubu_Up, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Uart_2_Projector_Off, Delay: 25},
            {Name: Command.Projector_Off, Delay: 1},
        ]
    },
    ProjectorOn:{
        Confirm:true,
        Commands:[
            {Name: Command.Projector_On, Delay: 1},
            {Name: Command.Mubu_Down, Delay: 10},
            {Name: Command.Uart_1_Projector_On, Delay: 1},
            {Name: Command.Uart_2_Projector_On, Delay: 1},
            {Name: Command.Uart_1_Projector_On, Delay: 1},
            {Name: Command.Uart_2_Projector_On, Delay: 1},
        ]
    },
    ProjectorOff:{
        Confirm:true,
        Commands:[
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Uart_2_Projector_Off, Delay: 1},
            {Name: Command.Mubu_Up, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Uart_2_Projector_Off, Delay: 25},
            {Name: Command.Projector_Off, Delay: 1},
        ]
    },
    ProjectorPC:{
        Commands:[
            {Name: Command.Projector_PC, Delay: 1},
            {Name: Command.Extender_PC, Delay: 1},
        ]
    },
    ProjectorLantop:{
        Commands:[
            {Name: Command.Projector_Lantop, Delay: 1},
            {Name: Command.Extender_Lantop, Delay: 1},
        ]
    },
    ProjectorWireless:{
        Commands:[
            {Name: Command.Projector_Wireless, Delay: 1},
            {Name: Command.Extender_Wireless, Delay: 1},
        ]
    }
}
const Haishi = {
    Logo:{Url:"pic/haishi.png"},
    WhiteBoard:{
        Confirm:true,
        Commands:[
            {Name: Command.Lock_Off, Delay: 1},
            {Name: Command.Extension_On, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Mubu_Up, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 25},
            {Name: Command.Projector_Off, Delay: 1},
            {Name: Command.Monitor_PC, Delay: 1},
            {Name: Command.Amp_On, Delay: 1},
        ]
    },
    SystemOn:{
        Confirm:true,
        Commands:[
            {Name: Command.Lock_On, Delay: 1},
            {Name: Command.Extension_On, Delay: 1},
            {Name: Command.Projector_On, Delay: 1},
            {Name: Command.Mubu_Down, Delay: 10},
            {Name: Command.Uart_1_Projector_On, Delay: 1},
            {Name: Command.Uart_1_Projector_On, Delay: 25},
            {Name: Command.Monitor_PC, Delay: 1},
            {Name: Command.Projector_PC, Delay: 1},
            {Name: Command.Amp_On, Delay: 1},
        ]
    },
    SystemOff:{
        Confirm:true,
        Commands:[
            {Name: Command.Amp_Off, Delay: 1},
            {Name: Command.Lock_Off, Delay: 1},
            {Name: Command.Extension_Off, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Mubu_Up, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 25},
            {Name: Command.Projector_Off, Delay: 1},
        ]
    },
    ProjectorOn:{
        Confirm:true,
        Commands:[
            {Name: Command.Projector_On, Delay: 1},
            {Name: Command.Mubu_Down, Delay: 10},
            {Name: Command.Uart_1_Projector_On, Delay: 1},
            {Name: Command.Uart_1_Projector_On, Delay: 1},
        ]
    },
    ProjectorOff:{
        Confirm:true,
        Commands:[
            {Name: Command.Uart_1_Projector_Off, Delay: 1},
            {Name: Command.Mubu_Up, Delay: 1},
            {Name: Command.Uart_1_Projector_Off, Delay: 25},
            {Name: Command.Projector_Off, Delay: 1},
        ]
    },
    ProjectorPC:{
        Commands:[
            {Name: Command.Projector_PC, Delay: 1},
        ]
    },
    ProjectorLantop:{
        Commands:[
            {Name: Command.Projector_Lantop, Delay: 1},
        ]
    },
    ProjectorWireless:{
        Commands:[
            {Name: Command.Projector_Wireless, Delay: 1},
        ]
    }
}

var Commands_List = Haishi

function startCmds(cmd){
    if(Commands_List[cmd]["Confirm"]){
        confirmDialog.operation = cmd
        confirmDialog.open()
    }else{
        if(Commands_List[cmd]["Commands"].length > 1){
            processDialog.operation = cmd
            processDialog.open()
        }else if(Commands_List[cmd]["Commands"].length === 1){
            runCmd(Commands_List[cmd]["Commands"][0].Name)
        }
    }
}

function getCmdsDuring(cmds){
    var during = 0
    for (var i = 0; i < Commands_List[cmds]["Commands"].length-1; i++){
        during += Commands_List[cmds]["Commands"][i].Delay
    }
    return during
}

function runCmd(cmd){
    switch(cmd){
    case Command.Projector_On:
        socket.sendBinaryMessage(setProjectorPower(val_On))
        break
    case Command.Projector_Off:
        socket.sendBinaryMessage(setProjectorPower(val_Off))
        break
    case Command.Extension_On:
        socket.sendBinaryMessage(setExtensionPower(val_On))
        break
    case Command.Extension_Off:
        socket.sendBinaryMessage(setExtensionPower(val_Off))
        break
    case Command.Lock_On:
        socket.sendBinaryMessage(setLockPower(val_On))
        break
    case Command.Lock_Off:
        socket.sendBinaryMessage(setLockPower(val_Off))
        break
    case Command.Amp_On:
        socket.sendBinaryMessage(setAmpPower(val_On))
        break
    case Command.Amp_Off:
        socket.sendBinaryMessage(setAmpPower(val_Off))
        break
    case Command.Mubu_Up:
        socket.sendBinaryMessage(setMubuPower(val_Up))
        break
    case Command.Mubu_Stop:
        socket.sendBinaryMessage(setMubuPower(val_Stop))
        break
    case Command.Mubu_Down:
        socket.sendBinaryMessage(setMubuPower(val_Down))
        break
    case Command.Uart_1_Projector_On:
        socket.sendBinaryMessage(uart_1_Send(Projectors_Code[Projectors[settings.projector]][val_On].Code))
        break
    case Command.Uart_1_Projector_Off:
        socket.sendBinaryMessage(uart_1_Send(Projectors_Code[Projectors[settings.projector]][val_Off].Code))
        break
    case Command.Uart_2_Projector_On:
        socket.sendBinaryMessage(uart_2_Send(Projectors_Code[Projectors[settings.projector]][val_On].Code))
        break
    case Command.Uart_2_Projector_Off:
        socket.sendBinaryMessage(uart_2_Send(Projectors_Code[Projectors[settings.projector]][val_Off].Code))
        break
    case Command.Projector_PC:
        socket.sendBinaryMessage(setProjectorSignal(val_PC))
        break
    case Command.Projector_Lantop:
        socket.sendBinaryMessage(setProjectorSignal(val_Laptop))
        break
    case Command.Projector_Wireless:
        socket.sendBinaryMessage(setProjectorSignal(val_Wireless))
        break
    case Command.Projector_Camera:
        socket.sendBinaryMessage(setProjectorSignal(val_Camera))
        break
    case Command.Extender_PC:
        socket.sendBinaryMessage(setExtendSignal(val_PC))
        break
    case Command.Extender_Lantop:
        socket.sendBinaryMessage(setExtendSignal(val_Laptop))
        break
    case Command.Extender_Wireless:
        socket.sendBinaryMessage(setExtendSignal(val_Wireless))
        break
    case Command.Extender_Camera:
        socket.sendBinaryMessage(setExtendSignal(val_Camera))
        break
    case Command.Monitor_PC:
        socket.sendBinaryMessage(setMonitorSignal(val_PC))
        break
    case Command.Monitor_Lantop:
        socket.sendBinaryMessage(setMonitorSignal(val_Laptop))
        break
    case Command.Monitor_Wireless:
        socket.sendBinaryMessage(setMonitorSignal(val_Wireless))
        break
    case Command.Monitor_Camera:
        socket.sendBinaryMessage(setMonitorSignal(val_Camera))
        break
    case Command.subHDMIProjector:
        socket.sendBinaryMessage(subscribeHDMIProjector(true))
        break
    case Command.subHDMIExtend:
        socket.sendBinaryMessage(subscribeHDMIExtend(true))
        break
    case Command.subPowerParm:
        socket.sendBinaryMessage(subscribePowerParm(true))
        break
    case Command.subMachineName:
        socket.sendBinaryMessage(subscribeMachineName(true))
        break
    case Command.reboot:
        socket.sendBinaryMessage(reboot(true))
        break
    default:
        console.info("unkonwn cmd:" , cmd)
    }
}

function customSubParm(uuid, id, subscribe) {
    var cmdArray = new ArrayBuffer(8)
    var cmd = new Uint8Array(cmdArray)

    if (subscribe) {
        cmd[0] =  (op_code_SUBSCRIBE & 0xFF);
        cmd[1] =  ((op_code_SUBSCRIBE >> 8) & 0xFF);
    } else {
        cmd[0] =  (op_code_UNSUBSCRIBE & 0xFF);
        cmd[1] =  ((op_code_UNSUBSCRIBE >> 8) & 0xFF);
    }
    cmd[2] =  (1);
    cmd[3] =  (0);
    cmd[4] =  (uuid & 0xFF);
    cmd[5] =  ((uuid >> 8) & 0xFF);
    cmd[6] =  (id & 0xFF);
    cmd[7] =  ((id >> 8) & 0xFF);

    return cmd.buffer
}


function customSetParm(uuid, id, val) {
    var cmdArray = new ArrayBuffer(8+val.length)

    var cmd = new Uint8Array(cmdArray)

    cmd[0] = (op_code_SETTING & 0xFF);
    cmd[1] = ((op_code_SETTING >> 8) & 0xFF);
    cmd[2] = (uuid & 0xFF);
    cmd[3] = ((uuid >> 8) & 0xFF);
    cmd[4] = (id & 0xFF);
    cmd[5] = ((id >> 8) & 0xFF);
    cmd[6] = (val.length & 0xFF);
    cmd[7] = ((val.length >> 8) & 0xFF);

    cmd.set(val,8)

    return cmd.buffer;
}

//subscribe
function subscribePowerParm(subscribe) {
    return customSubParm(uuid_POWER_PARAMS, id_Power_Sub, subscribe); //开关控制状态订阅，1 - 幕布；2 - 投影机；3 - 电源；4 - 电锁
}

function subscribeUartSet(subscribe) {
    return customSubParm(uuid_POWER_PARAMS, id_Uart_Set, subscribe); //串口数据订阅，6 - 串口1；7 - 串口2；8 - 串口3
}

function subscribeUartData(subscribe) {
    return customSubParm(uuid_POWER_PARAMS, id_Uart, subscribe); //串口数据订阅，6 - 串口1；7 - 串口2；8 - 串口3
}

function subscribeHDMIProjector(subscribe) {
    return customSubParm(uuid_HDMI_PARAMS, id_Projector, subscribe); //订阅投影机的输入信号
}

function subscribeHDMIExtend(subscribe) {
    return customSubParm(uuid_HDMI_PARAMS, id_Extend, subscribe); //订阅投影机的输入信号
}

function subscribeMachineName(subscribe) {
    return customSubParm(uuid_HOST_PARAMS, id_Machine_Name, subscribe); //订阅投影机的输入信号
}

//set
//Power
function setProjectorPower(val){
    return customSetParm(uuid_POWER_PARAMS, id_Power, new Uint8Array([val_Power_Projector, val]));
}
function setExtensionPower(val){
    return customSetParm(uuid_POWER_PARAMS, id_Power, new Uint8Array([val_Power_Extension, val]));
}
function setLockPower(val){
    return customSetParm(uuid_POWER_PARAMS, id_Power, new Uint8Array([val_Power_Lock, val]));
}
function setMubuPower(val){
    return customSetParm(uuid_POWER_PARAMS, id_Power, new Uint8Array([val_Power_Mubu, val]));
}

//HDMI
function setProjectorSignal(val){
    return customSetParm(uuid_HDMI_PARAMS, id_Projector, new Uint8Array([val]));
}
function setMonitorSignal(val){
    return customSetParm(uuid_HDMI_PARAMS, id_Monitor, new Uint8Array([val]));
}
function setExtendSignal(val){
    return customSetParm(uuid_HDMI_PARAMS, id_Extend, new Uint8Array([val]));
}

//Amp
function setAmpPower(val){
    return customSetParm(uuid_T8040_PARAMS, id_Key, new Uint8Array([val, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
}

//Uart
function uart_1_Send(val){
    var cmdArray = new ArrayBuffer(1+val.length)

    var cmd = new Uint8Array(cmdArray)

    cmd[0] = val_Uart1

    cmd.set(val,1)

    return customSetParm(uuid_POWER_PARAMS, id_Uart, cmd);
}

function uart_2_Send(val){
    var cmdArray = new ArrayBuffer(1+val.length)

    var cmd = new Uint8Array(cmdArray)

    cmd[0] = val_Uart2

    cmd.set(val,1)

    return customSetParm(uuid_POWER_PARAMS, id_Uart, cmd);
}

//reboot
function reboot(){
    return customSetParm(uuid_HOST_PARAMS,id_Reboot,new Uint8Array(0))
}

//globalVolume
function globalVolumeSet(volume){
    if(volume < 15) {
        volume = 15
    }else if(volume > 45) {
        volume = 45
    }
    socket.sendBinaryMessage(customSetParm(uuid_AUDIO_PARAM, id_Audio_GlobalVol,new Uint8Array([volume])))
}


function messageCheck(message) {
    //var msg = new Uint8Array(message)
    if (codeCompare(message, op_code_REPORT, 0)) {  //确定起始字符0x8004,
        if (codeCompare(message, uuid_HDMI_PARAMS, 2)) {   //HDMI信号 0x1400
            if (codeCompare(message, id_Projector, 4)) {   //投影机 0x0003
                root.projectorHDMI =new Uint8Array(message.slice(8,9))[0]
                //console.info("投影机信号",root.projectorHDMI)
            } else if (codeCompare(message, id_Extend, 4)) {   //外接 0x0001
                root.extendHDMI = new Uint8Array(message.slice(8,9))[0]
                //console.info("扩展信号",root.extendHDMI)
            } else if (codeCompare(message, id_Monitor, 4)) {   //显示器 0x0002
                root.monitorHDMI =  new Uint8Array(message.slice(8,9))[0]
                //console.info("显示器信号",root.monitorHDMI)
            }
        } else if ((codeCompare(message, uuid_POWER_PARAMS, 2) & //电源 0x1500
                    (codeCompare(message, id_Power_Sub, 4)))) {  // 0x0000
            const index = 11;
            root.mubuPower = new Uint8Array(message.slice(index,index+1))[0]
            //console.info("幕布状态",root.mubuPower)
            root.projectorPower = new Uint8Array(message.slice(index+71,index+1+71))[0]
            //console.info("投影机状态",root.projectorPower)
            root.extensionPower = new Uint8Array(message.slice(index+71*2,index+1+71*2))[0]
            //console.info("外接状态",root.extensionPower)
            root.lockPower = new Uint8Array(message.slice(index+71*3,index+1+71*3))[0]
            //console.info("电锁状态",root.lockPower)
        } else if ((codeCompare(message, uuid_HOST_PARAMS, 2) & //主机 0x1100
                    (codeCompare(message, id_Machine_Name, 4)))) {  // 0x0000
            var messageArray = new Uint8Array(message.slice(8,48))
            var dataString = "";
            for (var i = 0; i < messageArray.length; i++) {
                dataString += String.fromCharCode(messageArray[i]);
            }
            if(settingDialog.settings.autoRoomNumber){ //自动
                settingDialog.settings.roomNumber = dataString
                settingDialog.roomNumber.text = settingDialog.settings.roomNumber
                settingDialog.settings.sync()
            }
        }
    }
}

function codeCompare(message, code, position) {
    var mes = new Uint16Array(message.slice(position,position+2))
    return mes[0] === code
}
