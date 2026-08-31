// GERADO por `theme` — edite theme/templates/sddm-main.qml.tmpl
//
// IMPORTS COM VERSAO, DE PROPOSITO: no login real o SDDM lanca o greeter
// Qt5 (/usr/bin/sddm-greeter), que rejeita import sem versao com
// "Library import requires a version" e cai no tema embutido.
//
// SO PRIMITIVAS DO QtQuick: o Qt5 desta maquina nao tem QtQuick.Controls
// (qt5-quickcontrols2 nao instalado). Nada de TextField/Button/ComboBox.
import QtQuick 2.15

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: "#161616"

    property color cAccent:  "#fa4d56"
    property color cFg:      "#f2f4f8"
    property color cFgDim:   "#b5b7ba"
    property color cFgMute:  "#6f6f6f"
    property color cSurface: "#282828"
    property color cLine:    "#484848"
    property color cErr:     "#ee5396"
    property string fonte:   "JetBrainsMono Nerd Font"

    property int sessaoIdx: sessionModel.lastIndex

    Image {
        id: wallpaper
        anchors.fill: parent
        source: config.background || ""
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        visible: status === Image.Ready
    }
    Rectangle {
        anchors.fill: parent
        color: root.color
        opacity: wallpaper.visible ? 0.72 : 1.0
    }

    // ── relogio ─────────────────────────────────────────────────────────
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.16
        spacing: 4

        Text {
            id: hora
            anchors.horizontalCenter: parent.horizontalCenter
            color: root.cFg
            font.family: root.fonte
            font.pointSize: 62
            font.weight: Font.Light
            text: Qt.formatTime(new Date(), "HH:mm")
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: root.cFgMute
            font.family: root.fonte
            font.pointSize: 12
            text: new Date().toLocaleDateString(Qt.locale(), "dddd, d 'de' MMMM")
        }
        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: hora.text = Qt.formatTime(new Date(), "HH:mm")
        }
    }

    // ── cartao ──────────────────────────────────────────────────────────
    Rectangle {
        id: card
        width: 360
        height: coluna.height + 44
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height * 0.10
        radius: 14
        color: Qt.rgba(root.cSurface.r, root.cSurface.g, root.cSurface.b, 0.85)
        border.width: 1
        border.color: root.cLine

        Column {
            id: coluna
            anchors.centerIn: parent
            width: parent.width - 44
            spacing: 14

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                color: root.cFg
                font.family: root.fonte
                font.pointSize: 13
                font.bold: true
                // lastUser vem vazio em --test-mode; o fallback le o modelo
                text: userModel.lastUser !== "" ? userModel.lastUser
                      : (userModel.count > 0
                         ? userModel.data(userModel.index(0, 0), Qt.UserRole + 1)
                         : "")
            }

            // campo de senha
            Rectangle {
                width: parent.width
                height: 42
                radius: 8
                color: root.color
                border.width: 2
                border.color: senha.activeFocus ? root.cAccent : root.cLine
                Behavior on border.color { ColorAnimation { duration: 140 } }

                TextInput {
                    id: senha
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    passwordCharacter: "•"
                    color: root.cFg
                    font.family: root.fonte
                    font.pointSize: 11
                    focus: true
                    selectByMouse: true
                    onAccepted: root.entrar()
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    text: "senha"
                    color: root.cFgMute
                    font.family: root.fonte
                    font.pointSize: 11
                    visible: senha.text.length === 0
                }
            }

            Text {
                id: aviso
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                color: root.cErr
                font.family: root.fonte
                font.pointSize: 10
                text: ""
                visible: text !== ""
            }

            // botao entrar
            Rectangle {
                width: parent.width
                height: 40
                radius: 8
                color: areaEntrar.pressed ? Qt.darker(root.cAccent, 1.2)
                     : areaEntrar.containsMouse ? Qt.lighter(root.cAccent, 1.1)
                     : root.cAccent
                Behavior on color { ColorAnimation { duration: 140 } }
                Text {
                    anchors.centerIn: parent
                    text: "entrar"
                    color: root.color
                    font.family: root.fonte
                    font.pointSize: 11
                    font.bold: true
                }
                MouseArea {
                    id: areaEntrar
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.entrar()
                }
            }

            // seletor de sessao: clicar alterna entre as disponiveis
            Text {
                id: sessaoTxt
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                color: areaSessao.containsMouse ? root.cFg : root.cFgMute
                font.family: root.fonte
                font.pointSize: 10
                text: sessionModel.data(sessionModel.index(root.sessaoIdx, 0), Qt.UserRole + 4)
                      + (sessionModel.rowCount() > 1 ? "  ⇄" : "")
                Behavior on color { ColorAnimation { duration: 140 } }
                MouseArea {
                    id: areaSessao
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: root.sessaoIdx = (root.sessaoIdx + 1) % sessionModel.rowCount()
                }
            }
        }
    }

    // ── energia ─────────────────────────────────────────────────────────
    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 28
        spacing: 6

        Repeater {
            model: [
                { glifo: "", acao: "reboot",   ok: sddm.canReboot   },
                { glifo: "", acao: "poweroff", ok: sddm.canPowerOff }
            ]
            delegate: Rectangle {
                visible: modelData.ok
                width: 44; height: 44; radius: 10
                color: areaEnergia.containsMouse
                       ? Qt.rgba(root.cErr.r, root.cErr.g, root.cErr.b, 0.18)
                       : "transparent"
                Behavior on color { ColorAnimation { duration: 160 } }
                Text {
                    anchors.centerIn: parent
                    text: modelData.glifo
                    color: areaEnergia.containsMouse ? root.cErr : root.cFgDim
                    font.family: root.fonte
                    font.pointSize: 14
                    Behavior on color { ColorAnimation { duration: 160 } }
                }
                MouseArea {
                    id: areaEnergia
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: modelData.acao === "reboot" ? sddm.reboot() : sddm.powerOff()
                }
            }
        }
    }

    function entrar() {
        aviso.text = ""
        sddm.login(userModel.lastUser, senha.text, root.sessaoIdx)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            aviso.text = "senha incorreta"
            senha.text = ""
            senha.forceActiveFocus()
        }
    }
}
