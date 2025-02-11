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

    RowLayout {
        id: controlPanel
        anchors.horizontalCenter:  minesweeper.horizontalCenter
        anchors.top: minesweeper.bottom
        anchors.topMargin: 16

        property alias rowCountSpinBox: rowCountSpinBox
        property alias columnCountSpinBox: columnCountSpinBox

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
        SpinBox {
            id: rowCountSpinBox
            enabled: !minesweeper.started
            from: 3
            to: 20
            value: 7
            //onValueChanged: MS.sizeChanged()
        }

        SpinBox {
            id: columnCountSpinBox
            enabled: !minesweeper.started
            from: 3
            to: 20
            value: 7
            //onValueChanged: MS.sizeChanged()
        }
    }

}
