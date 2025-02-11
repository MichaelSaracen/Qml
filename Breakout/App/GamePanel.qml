import QtQuick
import QtQuick.Controls.Material

import App
import App.Appearance
import QtQuick.Layouts 2.15
import Generated.Effects.DropShadow 1.0
import QtQuick.Controls 2.15

Rectangle {
    id: gamePanel
    property string property: "This is a string"
    height: 60
    color: Theme.secondaryBackground

    property alias btnExpandWindow: btnExpandWindow
    property alias btnRestart: btnRestart
    width: 600

    // DropShadow {
    //     dropShadowBlurAmount: 0.30131
    //     extraMargin: 49
    // }
    
    
    RowLayout {
        id: rowLayout
        anchors.fill: parent
        
        
        Item {
            visible: true
            Layout.rightMargin: 8
            Layout.preferredWidth: 44
            Layout.preferredHeight: 44
        }


        Item {
            visible: true
            Layout.rightMargin: 8
            Layout.preferredWidth: 44
            Layout.preferredHeight: 44
        }

        Item {
            id: _item
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        
        



        RoundButton {
            id: btnRestart
            radius: 4
            rightInset: 0
            bottomInset: 0
            leftInset: 0
            topInset: 0
            icon.height: 32
            icon.width: 32
            padding: 0
            icon.source: checked ? Icons.stop : Icons.play
            flat: true
            checkable: true
            Layout.rightMargin: 8
            Layout.preferredWidth: 56
            Layout.preferredHeight: 56

            ToolTip.text: checked ? "Spiel Beenden" : "Spiel Starten"
            ToolTip.delay: 1000
            ToolTip.visible: hovered

            onClicked:  {
                if ( !checked ) {
                    console.log ( "Restart Game!" );
                    gameField.restartGame();
                } else {
                    //gameField.restartGame();
                    gameField.createField();
                    gameField.startGame();
                }
            }
        }


        Item {
            id: _item1
            width: 200
            height: 200
            Layout.fillWidth: true
            Layout.fillHeight: true
        }


        RoundButton {
            id: btnDarMode
            radius: 4
            padding: 0
            icon.source: Icons.colorMode
            flat: true
            checkable: true
            Layout.rightMargin: 8
            Layout.preferredWidth: 44
            Layout.preferredHeight: 44
            onClicked: {
                Theme.darkmode = !Theme.darkmode;
            }

            ToolTip.text: checked ? "Dark - Mode (F1)" : "Light - Mode (F1)"
            ToolTip.delay: 1000
            ToolTip.visible: hovered
        }
        
        





        RoundButton {
            id: btnExpandWindow
            radius: 4
            flat: true
            Layout.rightMargin: 8
            checkable: true
            icon.source: checked ? Icons.collapseContent : Icons.expandContent
            Layout.preferredHeight: 44
            Layout.preferredWidth: 44
            padding: 0
            ToolTip.text: checked ? "Vollbild - Modus (F2)" : "Fenster - Modus (F2)"
            ToolTip.delay: 1000
            ToolTip.visible: hovered
        }






        
        
        
    }
}
