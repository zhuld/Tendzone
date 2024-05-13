const op_code_UNSUBSCRIBE = 0x8005;
const op_code_SUBSCRIBE = 0x8002;
const op_code_SETTING = 0x8003;
const op_code_REPORT = 0x8004;

const uuid_HOST_PARAMS = 0x1100;
const uuid_NET_PARAMS = 0x1101;
const uuid_BLE_PARAMS = 0x1200;
const uuid_IR_MIC_CONFIG = 0x1302;
const uuid_AUDIO_PARAM = 0x1303;

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

//Audio_Input
const Audio_Line = {
    LINEIN: 0,
    MICIN: 1,
    IRMIC:2,
    LINEOUT: 3,
    APOUT: 4,
    HDMI: 5
}
const Audio_Type = {
    VOLUME: 0,
    MUTE: 1,
    PEQ:2,
    MIXER:3,
    DRC:4,
    LOWCUT:5,
    SRC:6, //not used
    DELAY:7,
    PPOWER:8,
    LEVEL:9,
    OUT_AIMING:10,
    AFC:11
}

const val_Mute = 1
const val_Unmute = 0

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
    Projector: Symbol("Projector"),
    Extension: Symbol("Extension"),
    Lock: Symbol("Lock"),
    Amp: Symbol("Amp"),
    Mubu: Symbol("Mubu"),
    Uart_1_Projector: Symbol("Uart_1_Projector"),
    Uart_2_Projector: Symbol("Uart_2_Projector"),
    Projector_HDMI: Symbol("Projector_HDMI"),
    Extender_HDMI: Symbol("Extender_HDMI"),
    Monitor_HDMI: Symbol("Monitor_HDMI"),
    subHDMIProjector: Symbol("subHDMIProjector"),
    subHDMIExtend: Symbol("subHDMIExtend"),
    subPowerParm: Symbol("subPowerParm"),
    subMachineName: Symbol("subMachineName"),
    reboot: Symbol("reboot"),
    globalVolume: Symbol("globalVolume"),
    lineVolume: Symbol("lineVolume"),
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
            {Name: Command.Lock, Value: val_Off, Delay: 1},
            {Name: Command.Extension, Value: val_On, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Mubu, Value: val_Up, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_Off, Delay: 25},
            {Name: Command.Projector, Value: val_Off, Delay: 1},
            {Name: Command.Monitor_HDMI, Value: val_PC, Delay: 1},
            {Name: Command.Amp, Value: val_Off, Delay: 1},
        ]
    },
    SystemOn:{
        Confirm:true,
        Commands:[
            {Name: Command.Lock, Value: val_On, Delay: 1},
            {Name: Command.Extension, Value: val_On, Delay: 1},
            {Name: Command.Projector, Value: val_On, Delay: 1},
            {Name: Command.Mubu, Value: val_Down, Delay: 10},
            {Name: Command.Uart_1_Projector, Value: val_On, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_On, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_On, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_On, Delay: 25},
            {Name: Command.Monitor_HDMI, Value: val_PC, Delay: 1},
            {Name: Command.Projector_HDMI, Value: val_PC, Delay: 1},
            {Name: Command.Extender_HDMI, Value: val_PC, Delay: 1},
            {Name: Command.Amp, Value: val_On, Delay: 1},
        ]
    },
    SystemOff:{
        Confirm:true,
        Commands:[
            {Name: Command.Amp, Value: val_Off, Delay: 1},
            {Name: Command.Lock, Value: val_Off, Delay: 1},
            {Name: Command.Extension, Value: val_Off, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Mubu, Value: val_Up, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_Off, Delay: 25},
            {Name: Command.Projector, Value: val_Off, Delay: 1},
        ]
    },
    ProjectorOn:{
        Confirm:true,
        Commands:[
            {Name: Command.Projector, Value: val_On, Delay: 1},
            {Name: Command.Mubu, Value: val_Down, Delay: 10},
            {Name: Command.Uart_1_Projector, Value: val_On, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_On, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_On, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_On, Delay: 1},
        ]
    },
    ProjectorOff:{
        Confirm:true,
        Commands:[
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Mubu, Value: val_Up, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Uart_2_Projector, Value: val_Off, Delay: 25},
            {Name: Command.Projector, Value: val_Off, Delay: 1},
        ]
    },
    ProjectorPC:{
        Commands:[
            {Name: Command.Projector_HDMI, Value: val_PC, Delay: 1},
            {Name: Command.Extender_HDMI, Value: val_PC, Delay: 1},
        ]
    },
    ProjectorLaptop:{
        Commands:[
            {Name: Command.Projector_HDMI, Value: val_Laptop, Delay: 1},
            {Name: Command.Extender_HDMI, Value: val_Laptop, Delay: 1},
        ]
    },
    ProjectorWireless:{
        Commands:[
            {Name: Command.Projector_HDMI, Value: val_Wireless, Delay: 1},
            {Name: Command.Extende_HDMI, Value: val_Wireless, Delay: 1},
        ]
    }
}
const Haishi = {
    Logo:{Url:"pic/haishi.png"},
    WhiteBoard:{
        Confirm:true,
        Commands:[
            {Name: Command.Lock, Value: val_Off, Delay: 1},
            {Name: Command.Extension, Value: val_On, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Mubu, Value: val_Up, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 25},
            {Name: Command.Projector, Value: val_Off, Delay: 1},
            {Name: Command.Monitor_HDMI, Value: val_PC, Delay: 1},
            {Name: Command.Amp, Value: val_On, Delay: 1},
        ]
    },
    SystemOn:{
        Confirm:true,
        Commands:[
            {Name: Command.Lock, Value: val_On, Delay: 1},
            {Name: Command.Extension, Value: val_On, Delay: 1},
            {Name: Command.Projector, Value: val_On, Delay: 1},
            {Name: Command.Mubu, Value: val_Down, Delay: 10},
            {Name: Command.Uart_1_Projector, Value: val_On, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_On, Delay: 25},
            {Name: Command.Monitor_HDMI, Value: val_PC, Delay: 1},
            {Name: Command.Projector_HDMI, Value: val_PC, Delay: 1},
            {Name: Command.Amp, Value: val_On, Delay: 1},
        ]
    },
    SystemOff:{
        Confirm:true,
        Commands:[
            {Name: Command.Amp, Value: val_Off, Delay: 1},
            {Name: Command.Lock, Value: val_Off, Delay: 1},
            {Name: Command.Extension, Value: val_Off, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Mubu, Value: val_Up, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 25},
            {Name: Command.Projector, Value: val_Off, Delay: 1},
        ]
    },
    ProjectorOn:{
        Confirm:true,
        Commands:[
            {Name: Command.Projector, Value: val_On, Delay: 1},
            {Name: Command.Mubu, Value: val_Down, Delay: 10},
            {Name: Command.Uart_1_Projector, Value: val_On, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_On, Delay: 1},
        ]
    },
    ProjectorOff:{
        Confirm:true,
        Commands:[
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 1},
            {Name: Command.Mubu, Value: val_Up, Delay: 1},
            {Name: Command.Uart_1_Projector, Value: val_Off, Delay: 25},
            {Name: Command.Projector, Value: val_Off, Delay: 1},
        ]
    },
    ProjectorPC:{
        Commands:[
            {Name: Command.Projector_HDMI, Value: val_PC, Delay: 1},
        ]
    },
    ProjectorLaptop:{
        Commands:[
            {Name: Command.Projector_HDMI, Value: val_Laptop, Delay: 1},
        ]
    },
    ProjectorWireless:{
        Commands:[
            {Name: Command.Projector_HDMI, Value: val_Wireless, Delay: 1},
        ]
    }
}

var Commands_List = Haishi

function startCmds(cmds){
    if(Commands_List[cmds]["Confirm"]){
        confirmDialog.operation = cmds
        confirmDialog.open()
    }else{
        if(Commands_List[cmds]["Commands"].length > 1){
            processDialog.operation = cmds
            processDialog.open()
        }else if(Commands_List[cmds]["Commands"].length === 1){
            runCmd(Commands_List[cmds]["Commands"][0].Name,Commands_List[cmds]["Commands"][0].Value)
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

function runCmd(cmd , val){
    //console.info(cmd,val)
    var message
    switch(cmd){
    case Command.Projector:
        message = (setProjectorPower(val))
        break
    case Command.Extension:
        message = (setExtensionPower(val))
        break
    case Command.Lock:
        message = (setLockPower(val))
        break
    case Command.Amp:
        message = (setAmpPower(val))
        break
    case Command.Mubu:
        message = (setMubuPower(val))
        break
    case Command.Uart_1_Projector:
        message = (uart_1_Send(Projectors_Code[Projectors[settings.projector]][val].Code))
        break
    case Command.Uart_2_Projector:
        message = (uart_2_Send(Projectors_Code[Projectors[settings.projector]][val].Code))
        break
    case Command.Projector_HDMI:
        message = (setProjectorSignal(val))
        break
    case Command.Extender_HDMI:
        message = (setExtendSignal(val))
        break
    case Command.Monitor_HDMI:
        message = (setMonitorSignal(val_PC))
        break
    case Command.subHDMIProjector:
        message = (subscribeHDMIProjector(val))
        break
    case Command.subHDMIExtend:
        message = (subscribeHDMIExtend(val))
        break
    case Command.subPowerParm:
        message = (subscribePowerParm(val))
        break
    case Command.subMachineName:
        message = (subscribeMachineName(val))
        break
    case Command.reboot:
        message = (reboot())
        break
    case Command.globalVolume:
        message = (globalVolumeSet(val))
        break
    case Command.lineVolume:
        message = (lineVolumeSet(val))
        break
    default:
        console.warn("unkonw cmd",cmd,val)
    }
    console.info("run:", cmd,val," cmd:",new Uint8Array(message))
    wsClient.sendBinaryMessage(message)
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
    settingDialog.settings.volumeMute = (val !== val_On)
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
    return customSetParm(uuid_AUDIO_PARAM, id_Audio_GlobalVol,new Uint8Array([volume]))
}

//line volume set
function lineVolumeSet(data){
    return customSetParm(uuid_AUDIO_PARAM,id_Audio_SetParam , data)
}


function messageCheck(message) {
    //var msg = new Uint8Array(message)
    if (codeCompare(message, op_code_REPORT, 0)) {  //确定起始字符0x8004,
        if (codeCompare(message, uuid_HDMI_PARAMS, 2)) {   //HDMI信号 0x1400
            if (codeCompare(message, id_Projector, 4)) {   //投影机 0x0003
                root.projectorHDMI =new Uint8Array(message.slice(8,9))[0]
            } else if (codeCompare(message, id_Extend, 4)) {   //外接 0x0001
                root.extendHDMI = new Uint8Array(message.slice(8,9))[0]
            } else if (codeCompare(message, id_Monitor, 4)) {   //显示器 0x0002
                root.monitorHDMI =  new Uint8Array(message.slice(8,9))[0]
            }
        } else if ((codeCompare(message, uuid_POWER_PARAMS, 2) & //电源 0x1500
                    (codeCompare(message, id_Power_Sub, 4)))) {  // 0x0000
            const index = 11;
            root.mubuPower = new Uint8Array(message.slice(index,index+1))[0]
            root.projectorPower = new Uint8Array(message.slice(index+71,index+1+71))[0]
            root.extensionPower = new Uint8Array(message.slice(index+71*2,index+1+71*2))[0]
            root.lockPower = new Uint8Array(message.slice(index+71*3,index+1+71*3))[0]

        } else if ((codeCompare(message, uuid_HOST_PARAMS, 2) & //主机 0x1100
                    (codeCompare(message, id_Machine_Name, 4)))) {  // 0x0000
            var messageArray = new Uint8Array(message.slice(8,48))
            var dataString = "";
            for (var i = 0; i < messageArray.length; i++) {
                if(messageArray[i]!==0){
                dataString += String.fromCharCode(messageArray[i]);
                }
            }
            //if(settingDialog.settings.autoRoomNumber){ //自动
                root.roomName = dataString
                //settingDialog.settings.roomNumber = dataString
                //settingDialog.roomNumber.text = dataString//settingDialog.settings.roomNumber
                //settingDialog.settings.sync()
            //}
        }
    }
}

function codeCompare(message, code, position) {
    var mes = new Uint16Array(message.slice(position,position+2))
    return mes[0] === code
}
