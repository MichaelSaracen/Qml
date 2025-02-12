import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../js/index.js" as MS
import Generated.Effects.DropShadow 1.0

import App

Rectangle {
    id: controlPanel
    height: 60
    width: 1000
    color: "#242329"
    border.width: 1
    border.color: '#7644ff'

    property alias settingsBtn: settingsBtn
    property alias startButton: startButton
    property alias elapsedTimer: elapsedTimer
    property alias timer: timer
    
    RowLayout {
        anchors.fill: parent

        Label {
            id: titleLabel
            color: "#d0d0d0"
            text: qsTr("Minesweeper")
            font.capitalization: Font.AllUppercase
            Layout.leftMargin: 8;
            font.bold: true
            font.pointSize: 22
        }

        Item { Layout.fillWidth: true }
        
        RoundButton {
            id: clearButton
            flat: true
            enabled: minesweeper.started
            icon.source: Icons.stop
            onClicked: {
                MS.resetGame();
                elapsedTimer.stop();
                startButton.checked = false;
            }
        }
        RoundButton {
            id: startButton
            flat: true
            icon.source: checked ?  Icons.pause :  Icons.play
            checkable: true
            onClicked: {
                MS.startGame();
                if ( checked ) {
                    elapsedTimer.start();
                } else {
                    elapsedTimer.pause();
                }
            }
        }
        Item { Layout.fillWidth: true }
        Item {
            id: _item
            Layout.rightMargin: 8
            width: titleLabel.implicitWidth

            RoundButton {
                id: settingsBtn
                flat: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 0
                enabled:  !minesweeper.started
                icon.source: Icons.settings
                checkable: true
            }
        }
    }

    ElapsedTimer {
        id: elapsedTimer
    }

    Timer {
        id: timer
        running: startButton.checked
        repeat: true
        interval: 1
        onTriggered: {
            const ms = elapsedTimer.milliSeconds;
            const seconds = elapsedTimer.seconds;
            const minutes = elapsedTimer.minutes;
            elapsedLabel.text = Qt.formatTime(new Date(0, 0, 0, 0, minutes, seconds, ms), "mm:ss:zzz")
            if ( minutes >= 1 && seconds >= 30 ) {
                elapsedTimer.stop();
                timer.stop();
                minesweeper.gameOver();
            }
        }
    }
}
