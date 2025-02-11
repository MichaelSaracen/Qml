import QtQuick
import QtQuick.Controls.Material

import App
import App.Appearance
import QtQuick.Layouts 2.15
import Generated.Effects.DropShadow 1.0
import QtQuick.Controls 2.15

import QtQuick.Dialogs

Item {
    id: breakout

    width: Properties.width
    height: Properties.height
    Material.theme: Theme.darkmode ? Material.Dark : Material.Light
    property alias btnExpandWindow: gamePanel.btnExpandWindow

    focus: true

    Item {
        id: headerItem
        height: 70
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
    }



    Item {
        id: _item5
        width: 809
        height: 810
        anchors.verticalCenterOffset: -373
        anchors.horizontalCenterOffset: -588
        anchors.centerIn: parent

        Image {
            id: circle_big3
            source: "../assets/arc/circle_big3.png"
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
        }




        Image {
            id: circle_mid7
            source: "../assets/arc/circle_mid7.png"
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: circle_small1_0
            width: 150
            height: 150
            source: "../assets/arc/circle_small1_0.png"
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectFit
        }


        Image {
            id: circle_mid8
            x: 175
            y: 166
            source: "../assets/arc/circle_mid8.png"
            fillMode: Image.PreserveAspectFit
        }

        RotationAnimation {
            target: circle_big3
            duration: 45000
            easing.type: Easing.InOutQuad
            from: 0
            to: 360
            running: true
            loops: Animation.Infinite
        }


        RotationAnimation {
            target: circle_small1_0
            duration: 25000
            easing.type: Easing.InOutQuad
            from: 0
            to: 360
            running: true
            loops: Animation.Infinite
        }


        RotationAnimation {
            target: circle_mid7
            duration: 35000
            easing.type: Easing.InOutQuad
            from: 360
            to: 0
            running: true
            loops: Animation.Infinite
        }

        RotationAnimation {
            target: circle_mid8
            duration: 25000
            easing.type: Easing.InOutQuad
            from: 0
            to: 360
            running: true
            loops: Animation.Infinite
        }
    }

    Image {
        id: line8
        x: 79
        y: 159
        width: 601
        height: 76
        source: "../assets/arc/line8.png"
        anchors.horizontalCenterOffset: -335
        anchors.verticalCenterOffset: -375
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: line7
        width: 60
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 12
        anchors.topMargin: 0
        anchors.bottomMargin: 70
        source: "../assets/arc/line7.png"
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: _item1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: headerItem.bottom
        anchors.bottom: gamePanel.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent

            Item {
                id: _item3
                width: 200
                height: 200
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            Label {
                id: label1
                text: qsTr("Breakout")
                Layout.bottomMargin: 24
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.styleName: "Medium"
                font.pointSize: 34
                font.family: "Inter"

            }


            RowLayout {

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Item {
                    id: _item
                    width: 200
                    height: 200
                    Layout.fillWidth: true
                }

                Rectangle {
                    width: 100
                    height: gameField.height
                    color: Qt.darker(Theme.secondaryBackground, 1.05)

                    ColumnLayout {
                        spacing: 40
                        anchors.centerIn: parent
                        Repeater {
                            model: gameField.medals
                            Image {
                                source: "../assets/icons/medal.png"
                                sourceSize.height: 64
                                sourceSize.width: 64
                            }
                        }
                    }
                }


                GameField {
                    id: gameField
                    x: 220
                    y: 180
                    width: 1000
                    height: 800
                    color: Theme.secondaryBackground
                    clip: true
                    // Component.onCompleted: {
                    //     gameField.createField();
                    // }

                    onGameFinished: {
                        //dialog.visible = true;

                        dialog.open();

                    }

                    Dialog {
                        id: dialog
                        visible: false
                        modal: false
                        title: "Spiel Ende"
                        anchors.centerIn:  Overlay.overlay

                        implicitWidth:  400
                        implicitHeight: 200
                        Label {
                            width: parent.width
                            wrapMode: Text.WrapAnywhere
                            text: gameField.maxScore === gameField.totalScore
                                  ? "Glückwunsch du hast die maximal Punktzahl erreicht! Du bist der Beste!!" :
                                    `Du hast ${gameField.totalScore} von möglichen ${gameField.maxScore} Punkten erzielt!`
                        }

                        standardButtons: Dialog.Ok

                        onAccepted: {
                            //gamePanel.btnRestart.checked = false
                            //gameField.restartGame();
                            //gameField.createField();
                            //gameField.startGame();
                        }

                    }
                }

                Rectangle {
                    width: 100
                    height: gameField.height
                    color: Qt.darker(Theme.secondaryBackground, 1.05)
                    Layout.fillHeight: false
                    ColumnLayout {
                        spacing: 40
                        anchors.centerIn: parent
                        Repeater {
                            model: gameField.lifes
                            Image {
                                source: "../assets/icons/fav.png"
                                sourceSize.height: 64
                                sourceSize.width: 64
                            }
                        }
                    }
                }


                Item {
                    id: _item2
                    width: 200
                    height: 200
                    Layout.fillWidth: true
                }
            }
            RowLayout {
                Layout.topMargin: 8
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Label {
                    id: label
                    text: qsTr("Score")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.pointSize: 19
                }

                Label {
                    id: labelScore
                    text: parseInt(gameField.totalScore)
                    Layout.leftMargin: 6
                    font.pointSize: 20
                }

            }

            Item {
                id: _item4
                width: 200
                height: 200
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

        }

    }


    GamePanel {
        id: gamePanel
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 70
    }

    ProgressBar {
        id: progressBar
        from: 0
        value: parseFloat(gameField.totalScore)
        to: parseFloat(gameField.maxScore)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Behavior on value {
            NumberAnimation {
                duration: 300; easing.type: Easing.InOutQuad
            }
        }
        Material.accent: Theme.highlight
    }







    Keys.onPressed: ( ev ) => {
                        if ( ev.key === Qt.Key_A ) {
                            gameField.movePaddel( -gameField.width*0.05 );
                        }

                        if ( ev.key === Qt.Key_D ) {
                            gameField.movePaddel( gameField.width*0.05 );
                        }


                    }

}


















