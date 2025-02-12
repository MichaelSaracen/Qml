import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material

import QtCore

import "../js/index.js" as MS
import QtQuick.Controls 2.15
import Generated.Effects.DropShadow 1.0

Item {
    id: app
    width: 1400
    height: 1080


<<<<<<< HEAD
    Settings {
        id: settings
        property alias timer: spinBoxTimer.value
        property alias rowCount: rowCountSpinBox.value
        property alias columnCount: columnCountSpinBox.value
    }

    RowLayout {
        id: rowLayout
        visible: minesweeper.started
        //opacity: minesweeper.started? 1 : 0
        width: minesweeper.width
        height: 71
        anchors.bottom: minesweeper.top
        anchors.bottomMargin: 16
        anchors.horizontalCenter: minesweeper.horizontalCenter

        //Behavior on opacity { NumberAnimation { duration: 300 } }

        CounterLabel {
            id: pointCounter
            name: "Score"
            count: minesweeper.score
            Layout.preferredWidth: 80
        }

        Item { Layout.fillWidth: true }

        Label {
            id: elapsedLabel

            font.pointSize: 26
        }

        Item { Layout.fillWidth: true }
        CounterLabel {
            id: mineCounter
            name: "Mines"
            Layout.preferredWidth: 80
            count: minesweeper.bombCount
        }

    }


    Minesweeper {
        id: minesweeper
        property alias rowCountSpinBox: rowCountSpinBox
        property alias columnCountSpinBox: columnCountSpinBox
        property alias spinBoxTimer: spinBoxTimer
        property alias startButton: controlPanel.startButton
=======
    Label {
        id: label
        x: 379
        y: 417
        color: "#d0d0d0"
        text: qsTr("Minesweeper")
        anchors.right: minesweeper.left
        anchors.bottom: minesweeper.top
        anchors.rightMargin: -72
        anchors.bottomMargin: -111
        font.bold: true
        rotation: -90
        font.pointSize: 22
    }

    Minesweeper {
        id: minesweeper
        property alias rowCountSpinBox: rowCountSpinBox
        property alias columnCountSpinBox: columnCountSpinBox
        property alias spinBoxTimer: spinBoxTimer

        DropShadow {
            id: dropShadow
        }
    }



    Rectangle {
        id: settingsPannel
        width: settingsBtn.checked && !minesweeper.started ? 300: 0
        anchors.right: parent.right
        anchors.rightMargin: -1
        anchors.top: parent.top
        anchors.bottomMargin: -1
        anchors.bottom: controlPanel.top
        anchors.topMargin: -1
        clip: true
        color: '#242329'
        border.width: 1
        border.color: '#7644ff'


        Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }

        GridLayout {
            id: gridLayoutSettings
            anchors.fill: parent
            anchors.margins: 16
            columnSpacing: 16
            columns: 2

            Label {
                text: "Minesweeper - Einstellungen"
                Layout.columnSpan: 2
                Layout.fillWidth: true
                font.bold: true
                font.pointSize: 14
            }

            Label {
                text: "Timer"
                Layout.fillWidth: true
                Layout.topMargin: 16
                font.bold: true
                font.pointSize: 12
                Layout.rowSpan: 1
                Layout.columnSpan: 2
            }


            Label { text: "Minen - Timeout" ; Layout.fillWidth: true;font.pointSize: 9 }



            SpinBox {
                id: spinBoxTimer
                stepSize: 1000
                to: 5000
                editable: true
                from: 1000
                font.pointSize: 9
            }

            Label {
                text: "Werte zwischen 1000 und 5000"
                horizontalAlignment: Text.AlignRight
                Layout.fillWidth: true
                Layout.columnSpan: 2
                Layout.rowSpan: 1
                font.pointSize: 8
            }

            Label {
                text: "Spieldfeld"
                Layout.bottomMargin: 8
                Layout.fillWidth: true
                Layout.topMargin: 16
                font.pointSize: 12
                font.bold: true
                Layout.rowSpan: 1
                Layout.columnSpan: 2
            }

            Label {
                text: "Anzahl der Reihen"
                font.pointSize: 9
                Layout.fillWidth: true
            }

            SpinBox {
                id: rowCountSpinBox
                enabled: !minesweeper.started
                from: 5
                to: 20
                editable: true
                value: 10
                font.pointSize: 9
                onValueChanged: focus = false
                //onValueChanged: MS.sizeChanged()
            }

            Label {
                text: "Anzahl der Spalten"
                font.pointSize: 9
                Layout.fillWidth: true
            }

            SpinBox {
                id: columnCountSpinBox
                enabled: !minesweeper.started
                from: 5
                to: 20
                editable: true
                font.pointSize: 9
                value: 10
                //onValueChanged: MS.sizeChanged()
            }

            Item {
                id: _item
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }


    Rectangle {
        id: controlPanel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: -1
        anchors.rightMargin: -1
        anchors.bottomMargin: -1
        height: 60
        color: "#242329"
        border.width: 1
        border.color: '#7644ff'

>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28

        DropShadow { }
    }

    StartGameLabel {
        id: startGameLabel
        anchors.horizontalCenter: minesweeper.horizontalCenter
        anchors.verticalCenter: minesweeper.verticalCenter
        visible: opacity > 0
        opacity: !minesweeper.started? 1 : 0

        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    Rectangle {
        id: settingsPannel
        width: controlPanel.settingsBtn.checked && !minesweeper.started ? 300: 0
        anchors.right: parent.right
        anchors.rightMargin: -1
        anchors.top: parent.top
        anchors.bottomMargin: -1
        anchors.bottom: controlPanel.top
        anchors.topMargin: -1
        clip: true
        color: '#242329'
        border.width: 1
        border.color: '#7644ff'


        Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }

        GridLayout {
            id: gridLayoutSettings
            anchors.fill: parent
<<<<<<< HEAD
            anchors.margins: 16
            columnSpacing: 16
            columns: 2

            Label {
                text: "Minesweeper - Einstellungen"
                Layout.columnSpan: 2
                Layout.fillWidth: true
                font.bold: true
                font.pointSize: 14
            }

            Label {
                text: "Timer"
                Layout.fillWidth: true
                Layout.topMargin: 16
                font.bold: true
                font.pointSize: 12
                Layout.rowSpan: 1
                Layout.columnSpan: 2
            }


            Label { text: "Minen - Timeout" ; Layout.fillWidth: true;font.pointSize: 9 }

            SpinBox {
                id: spinBoxTimer
                stepSize: 1000
                to: 5000
                editable: true
                from: 1000
                font.pointSize: 9
            }

            Label {
                text: "Werte zwischen 1000 und 5000"
                horizontalAlignment: Text.AlignRight
                Layout.fillWidth: true
                Layout.columnSpan: 2
                Layout.rowSpan: 1
                font.pointSize: 8
            }

            Label {
                text: "Spieldfeld"
                Layout.bottomMargin: 8
                Layout.fillWidth: true
                Layout.topMargin: 16
                font.pointSize: 12
                font.bold: true
                Layout.rowSpan: 1
                Layout.columnSpan: 2
            }

            Label {
                text: "Anzahl der Reihen"
                font.pointSize: 9
                Layout.fillWidth: true
            }

            SpinBox {
                id: rowCountSpinBox
                enabled: !minesweeper.started
                from: 5
                to: 20
                editable: true
                value: 10
                font.pointSize: 9
                onValueChanged: focus = false
            }

            Label {
                text: "Anzahl der Spalten"
                font.pointSize: 9
                Layout.fillWidth: true
            }

            SpinBox {
                id: columnCountSpinBox
                enabled: !minesweeper.started
                from: 5
                to: 20
                editable: true
                font.pointSize: 9
                value: 10
            }

            Item {
                id: _item
                Layout.columnSpan: 2
                Layout.fillWidth: true
                Layout.fillHeight: true
=======
            Item { Layout.leftMargin: 8; Layout.preferredWidth: settingsBtn.implicitWidth }
            Item { Layout.fillWidth: true }

            RoundButton {
                id: clearButton
                enabled: minesweeper.started
                icon.source: "qrc:/assets/stop.png"
                onClicked: {
                    MS.resetGame();
                }
            }
            RoundButton {
                id: startButton
                icon.source: checked ?  "qrc:/assets/pause.png" :  "qrc:/assets/play.png"
                checkable: true
                onClicked: {
                    MS.startGame();
                }
            }
            Item { Layout.fillWidth: true }

            RoundButton {
                id: settingsBtn
                enabled:  !minesweeper.started
                icon.source: "qrc:/assets/settings.png"
                checkable: true
                Layout.rightMargin: 8
>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28
            }
        }
    }


<<<<<<< HEAD



    ControlPanel {
        id: controlPanel
        anchors.bottom: parent.bottom
        property alias elapsedLabel: elapsedLabel
        anchors.bottomMargin: -1
        anchors.left: parent.left
        anchors.leftMargin: -1
        anchors.right: parent.right
        anchors.rightMargin: -1
    }



    // GameDialog {
    //     id: gameDialog
    // }



=======
>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28
}
