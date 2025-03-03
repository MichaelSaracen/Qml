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
    
    property string question: ""
    property string answer: ""
    
    signal submit( question: string, answer: string )
    
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
        width: 500

        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
        }
        
        ColumnLayout {
            id: cl
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0
            
            Label {
                text: "Fragen und Antworten bearbeiten"
                Layout.leftMargin: 16
                Layout.topMargin: 16
                font.pointSize: 14
            }
            
            TextArea {
                id: taQuestion
                text: editQAndADialog.question
                Layout.minimumHeight: 150
                Layout.fillWidth: true
                placeholderText: qsTr("Frage")
                Layout.margins: 16
            }
            
            TextArea {
                id: taAnswer
                text: editQAndADialog.answer
                Layout.topMargin: 0
                Layout.preferredHeight: 150
                Layout.fillWidth: true
                placeholderText: qsTr("Antwort")
                Layout.margins: 16
            }
            
            RowLayout {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                spacing: 0
                Button {
                    text: "schließen"
                    flat: true
                    font.pointSize: 8
                    Layout.preferredWidth: 120
                    Material.roundedScale: Material.NotRounded
                    bottomInset: 0
                    topInset: 0
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    
                    onClicked: {
                        closeAnimation.running = true;
                        closeAnimation.onFinished.connect( () => {editQAndADialog.destroy();} );
                    }
                }
                Button {
                    text: "bestätigen"
                    enabled: taQuestion.text.length > 0 && taAnswer.text.length > 0
                    flat: true
                    font.pointSize: 8
                    Layout.preferredWidth: 120
                    bottomInset: 0
                    topInset: 0
                    leftPadding: 0
                    rightPadding: 0
                    bottomPadding: 0
                    topPadding: 0
                    Material.roundedScale: Material.NotRounded
                    
                    onClicked: {
                        editQAndADialog.submit( taQuestion.text, taAnswer.text )
                        closeAnimation.running = true;
                        closeAnimation.onFinished.connect( () => {editQAndADialog.destroy();} );
                    }
                }
            }
        }
    }
}
