import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance

import "Components"
import QtQuick.Controls 2.15

Item {
    id: settingsScreen
    width: Properties.width
    height: Properties.height

    visible: swipeView.currentIndex === 0

    property alias lblSubject: addQAndA.lblSubject


    property int subjectID: -1

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
                text: qsTr("Einstellugen")
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
                }
            }
        }
    }


    ColumnLayout {
        id: columnLayout

        width: (parent.width / 2) - 16
        anchors.left: parent.left
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 16
        anchors.topMargin: 16
        anchors.bottomMargin: 16
        Label {
            text: qsTr("Fach hinzufügen")
            Layout.bottomMargin: 8
        }

        TextField {
            id: textField
            height: 40
            Layout.fillWidth: true
            Layout.preferredHeight: 40
            placeholderText: qsTr("Text Field")
            onEditingFinished: {
                if ( text.length > 2 ) {
                    const subjectID = database.addSubject( text );
                    lmSubjects.append( { subjectID, name: text, selected: false })
                    clear();
                    focus = false;
                    errorAnimation.complete();
                } else {
                    errorAnimation.start()
                }
            }
        }
        Label {
            id: lblError
            opacity: 0
            text: qsTr("Mindestens drei Zeichen eingeben!")
            font.pointSize: 7
            color: "#ff6160"
        }

        SequentialAnimation {
            id: errorAnimation

            NumberAnimation { target: lblError; property: "opacity"; duration: 300; from: 0; to: 1; }

            PauseAnimation { duration: 5000 }

            NumberAnimation { target: lblError; property: "opacity"; from: 1; to: 0; duration: 300 }
        }
        ListAddQandA {
            id: listAddQandA
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        AddQAndA {
            id: addQAndA
        }
    }



    ListView {
        id: listEditQandA
        anchors.left: columnLayout.right
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.topMargin: 52
        anchors.bottomMargin: 16
        clip: true
        spacing: 2

        model: listModelQuestions
        delegate: EditQAndADelegate {
            id: editQAndADelegate
        }
    }
}













