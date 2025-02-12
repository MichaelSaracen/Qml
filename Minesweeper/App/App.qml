import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Basic

import "../js/index.js" as MS

Rectangle {
    id: app
    color: "#859ba2"
    width: 1400
    height: 1080


    Minesweeper {
        id: minesweeper
    }


    Rectangle {
        id: controlPanel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 80
        property alias rowCountSpinBox: rowCountSpinBox
        property alias columnCountSpinBox: columnCountSpinBox

        RowLayout {
            anchors.fill: parent


            Item { Layout.preferredWidth: rowCountSpinBox.implicitWidth }
            Item { Layout.preferredWidth: rowCountSpinBox.implicitWidth }
            Item { Layout.fillWidth: true }

            Button {
                id: clearButton
                text: "Reset"
                onClicked: {
                    MS.resetGame();
                }
            }
            Button {
                id: startButton
                text: "Start"
                onClicked: {
                    MS.startGame();
                }
            }
            Item { Layout.fillWidth: true }
            SpinBox {
                id: rowCountSpinBox
                enabled: !minesweeper.started
                from: 3
                to: 20
                editable: true
                value: 7
                onValueChanged: focus = false
                //onValueChanged: MS.sizeChanged()
            }

            SpinBox {
                id: columnCountSpinBox
                enabled: !minesweeper.started
                from: 3
                to: 20
                editable: true
                value: 7
                //onValueChanged: MS.sizeChanged()
            }
        }
    }

}
