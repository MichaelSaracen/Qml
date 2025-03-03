import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Effects
import App.Appearance
import QtQuick.Controls 2.15

Frame {
    id: editQAndADialog

    anchors.fill: parent
    bottomPadding: 0
    topPadding: 0
    padding: 0
    z: 100


    PropertyAnimation { id: closeAnimation; target: editQAndADialog; property: "opacity"; from: 1; to: 0; duration: 400; }
    PropertyAnimation { id: openAnimation; target: editQAndADialog; property: "opacity"; from: 0; to: 1; duration: 400; running: true; }

    Rectangle {
        opacity: 0.75
        anchors.fill: parent
        color: Properties.dark100
    }

    Rectangle {
        anchors.centerIn: parent
        height: cl.implicitHeight
        color: Properties.dark100
        width: 300

        layer.enabled: true
        layer.effect: MultiEffect { shadowEnabled: true }

        ColumnLayout {
            id: cl
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0

            Label {
                text: "Beenden"
                Layout.leftMargin: 16
                Layout.topMargin: 16
                font.pointSize: 14
            }

            Label {
                Layout.fillWidth: true
                Layout.margins: 16
                text: "Möchtest du das Programm wirklich <b>beenden</b>?"

            }

            RowLayout {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                spacing: 0
                Button {
                    text: "Nein"
                    flat: true
                    font.pointSize: 8
                    Layout.preferredWidth: 80
                    Material.roundedScale: Material.NotRounded
                    bottomInset: 0
                    topInset: 0
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0

                    onClicked: {
                        closeAnimation.running = true;
                        closeAnimation.onFinished.connect( () => {editQAndADialog.destroy(); } );
                    }
                }
                Button {
                    text: "Ja"
                    flat: true
                    font.pointSize: 8
                    Layout.preferredWidth: 80
                    bottomInset: 0
                    topInset: 0
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    Material.roundedScale: Material.NotRounded

                    onClicked: {
                        close()
                    }
                }
            }
        }
    }
}
