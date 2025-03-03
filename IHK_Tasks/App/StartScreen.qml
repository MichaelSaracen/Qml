import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance

import "Components"
import QtQuick.Controls 2.15

Item {
    id: startScreen
    width: Properties.width
    height: Properties.height
    visible: swipeView.currentIndex === 1

    clip: true
    Rectangle {
        height: 70
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        z: 1
        color: Properties.dark100

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16

            Label {
                text: qsTr("IHK - Tasks")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pointSize: 16
            }
        }
    }



    ColumnLayout {
        id: columnLayout
        anchors.centerIn: parent
        spacing: 32
        Label {
            text: qsTr("Feld auswählen")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 14
        }
        Label {
            text: qsTr("In den <b><font color='#ff6160'>Einstellungen</font></b>, kannst du neue Fächer <b><font color='#ff6160'>hinzufügen</font></b>, <b>bearbeiten</b> und <b>entfernen</b>.<br>Bei <b>Fragen & Antworten</b> kannst du ein Fach <b><font color='#ff6160'>auswählen</font></b> und dir die Fragen und Antworten anzeigen lassen.<br>Mit <b><font color='#ff6160'>Beenden</font></b> schließt du diese Anwendung.")
            horizontalAlignment: Text.AlignHCenter
            Layout.topMargin: -18
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pointSize: 11
        }


        RowLayout {
            id: rowLayout
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 32
            NavButton {
                id: btnSettings
                text: "Einstellungen"
                ToolTip.visible: hovered
                ToolTip.text: "Hinzufügen, umbenennen und löschen von Fächern, Fragen und Antworten."
                ToolTip.delay: 1000
                onClicked: swipeView.setCurrentIndex(0);
            }

            NavButton {
                id: btnSelection
                text: "Fragen & Antworten"
                source: Icons.card
                ToolTip.visible: hovered
                ToolTip.text: "Auswahl zwischen Fächern, inklusive Fragen und Antworten."
                ToolTip.delay: 1000
                onClicked: swipeView.setCurrentIndex(2);
            }

            NavButton {
                id: btnSelection1
                text: "Beenden"
                source: Icons.close
                ToolTip.visible: hovered
                ToolTip.text: "Schließt die Anwendung."
                ToolTip.delay: 1000

                onClicked: {
                    openCloseDialog();
                }
            }
        }

    }
    
}
