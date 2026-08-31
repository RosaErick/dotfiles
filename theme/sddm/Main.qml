// GERADO por `theme` — edite theme/templates/sddm-main.qml.tmpl
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// Nao importar SddmComponents: ele traz um ComboBox proprio que sobrescreve
// o do QtQuick.Controls e nao tem "textRole" — o tema falha ao carregar.

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

    // ── fundo: wallpaper escurecido, ou cor chapada se nao houver ────────
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
        color: "#161616"
        opacity: wallpaper.visible ? 0.72 : 1.0
    }

    // ── relogio ──────────────────────────────────────────────────────────
    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.16
        spacing: 2

        Text {
            Layout.alignment: Qt.AlignHCenter
            color: cFg
            font.family: "JetBrainsMono Nerd Font"
            font.pointSize: 64
            font.weight: Font.Light
            text: Qt.formatTime(new Date(), "HH:mm")
            Timer {
                interval: 1000; running: true; repeat: true
                onTriggered: parent.text = Qt.formatTime(new Date(), "HH:mm")
            }
        }
        Text {
            Layout.alignment: Qt.AlignHCenter
            color: cFgMute
            font.family: "JetBrainsMono Nerd Font"
            font.pointSize: 13
            // toLocaleDateString com Qt.locale() respeita o idioma do sistema;
            // Qt.formatDate usa nomes em ingles e o resultado sai misturado.
            text: new Date().toLocaleDateString(Qt.locale(), "dddd, d 'de' MMMM")
        }
    }

    // ── cartao de login ──────────────────────────────────────────────────
    Rectangle {
        id: card
        width: 380
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height * 0.10
        height: form.implicitHeight + 44
        radius: 14
        color: Qt.rgba(root.cSurface.r, root.cSurface.g, root.cSurface.b, 0.82)
        border.width: 1
        border.color: cLine

        ColumnLayout {
            id: form
            anchors.centerIn: parent
            width: parent.width - 44
            spacing: 14

            Text {
                Layout.alignment: Qt.AlignHCenter
                color: cFg
                font.family: "JetBrainsMono Nerd Font"
                font.pointSize: 14
                font.bold: true
                text: userModel.count > 0
                      ? userModel.data(userModel.index(userList.currentIndex, 0), Qt.UserRole + 1)
                      : "usuario"
            }

            ComboBox {
                id: userList
                Layout.fillWidth: true
                visible: userModel.count > 1
                model: userModel
                currentIndex: userModel.lastIndex
                textRole: "name"
            }

            TextField {
                id: password
                Layout.fillWidth: true
                echoMode: TextInput.Password
                placeholderText: "senha"
                font.family: "JetBrainsMono Nerd Font"
                font.pointSize: 11
                color: cFg
                placeholderTextColor: cFgMute
                padding: 12
                focus: true
                background: Rectangle {
                    radius: 8
                    color: "#161616"
                    border.width: 2
                    border.color: password.activeFocus ? cAccent : cLine
                    Behavior on border.color { ColorAnimation { duration: 140 } }
                }
                onAccepted: entrar()
            }

            Text {
                id: aviso
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                color: cErr
                font.family: "JetBrainsMono Nerd Font"
                font.pointSize: 10
                text: ""
                visible: text !== ""
            }

            Button {
                Layout.fillWidth: true
                text: "entrar"
                font.family: "JetBrainsMono Nerd Font"
                font.pointSize: 11
                onClicked: entrar()
                contentItem: Text {
                    text: parent.text
                    color: "#161616"
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    radius: 8
                    implicitHeight: 40
                    color: parent.down ? Qt.darker(cAccent, 1.2)
                         : parent.hovered ? Qt.lighter(cAccent, 1.1) : cAccent
                    Behavior on color { ColorAnimation { duration: 140 } }
                }
            }

            ComboBox {
                id: sessionList
                Layout.fillWidth: true
                model: sessionModel
                currentIndex: sessionModel.lastIndex
                textRole: "name"
                font.family: "JetBrainsMono Nerd Font"
                font.pointSize: 10
            }
        }
    }

    // ── energia ──────────────────────────────────────────────────────────
    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 28
        spacing: 6

        Repeater {
            model: [
                { glifo: "5", acao: "suspend", ok: sddm.canSuspend },
                { glifo: "9", acao: "reboot",  ok: sddm.canReboot  },
                { glifo: "5", acao: "poweroff", ok: sddm.canPowerOff }
            ]
            delegate: Rectangle {
                visible: modelData.ok
                width: 44; height: 44; radius: 10
                color: mouse.containsMouse
                       ? Qt.rgba(root.cErr.r, root.cErr.g, root.cErr.b, 0.18)
                       : "transparent"
                Behavior on color { ColorAnimation { duration: 160 } }
                Text {
                    anchors.centerIn: parent
                    text: modelData.glifo
                    color: mouse.containsMouse ? root.cErr : root.cFgDim
                    font.family: "JetBrainsMono Nerd Font"
                    font.pointSize: 15
                    Behavior on color { ColorAnimation { duration: 160 } }
                }
                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if (modelData.acao === "suspend") sddm.suspend()
                        else if (modelData.acao === "reboot") sddm.reboot()
                        else sddm.powerOff()
                    }
                }
            }
        }
    }

    function entrar() {
        aviso.text = ""
        sddm.login(userList.visible
                   ? userList.currentText
                   : userModel.data(userModel.index(userModel.lastIndex, 0), Qt.UserRole + 1),
                   password.text, sessionList.currentIndex)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            aviso.text = "senha incorreta"
            password.text = ""
            password.focus = true
        }
    }
}
