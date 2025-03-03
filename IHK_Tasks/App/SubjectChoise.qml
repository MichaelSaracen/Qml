import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance

import "Components"
import QtQuick.Controls 2.15
import Generated.Effects.ColorOverlay 1.0

Item {
    id: subjectChoise
    visible: swipeView.currentIndex === 2
    
    property int subjectIndex: -1
    property int subjectID: 1
    clip: true

    Rectangle {
        id: header
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
            anchors.rightMargin: 0
            Label {
                text: qsTr("Auswahl")
                font.pointSize: 16
            }

            Item { Layout.fillWidth: true }

            RoundButton {

                bottomInset: 0
                topInset: 0
                flat: true
                icon.source: Icons.home

                Layout.preferredWidth: 70
                Layout.preferredHeight: 70

                font.pointSize: 7
                height: 40
                radius: 0
                leftInset: 0
                rightInset: 0
                width: 40

                ToolTip.visible: hovered
                ToolTip.text: "Zur Startseite navigieren"
                ToolTip.delay: 1000
                onClicked: {
                    swipeView.setCurrentIndex(1)
                    subjectChoise.subjectIndex = -1;
                }
            }
        }
    }

    Item {
        width: subjectChoise.width / 2
        height: subjectChoise.height * 0.4
        anchors.centerIn: parent

        ColumnLayout {
            id: columnLayout
            anchors.fill: parent

            ListView {
                id: listView
                clip: true
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 2
                model: lmSubjectChoise

                delegate: SubjectChoiseDelegate { id: subjectChoiseDelegate }
            }

            Button {
                text: "Fach auswählen"
                bottomInset: 0
                topInset: 0
                flat: true
                enabled: subjectChoise.subjectIndex >= 0
                Layout.topMargin: 16
                Layout.preferredHeight: 60
                Layout.fillWidth: true
                Material.roundedScale: Material.NotRounded

                onClicked: {
                    subjectChoise.subjectIndex = -1;
                    loadQuestions( subjectChoise.subjectID );
                    swipeView.setCurrentIndex(3)
                }

                ColorOverlay {
                    id: colorOverlay
                }
            }
        }
    }
}
