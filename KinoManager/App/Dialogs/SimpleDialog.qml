import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 6.8

import App

Frame {
    id: simpleDialog
    anchors.fill: parent
    padding: 0
    topPadding: 0
    bottomPadding: 0
    
    
    property string title: "Title"
    property string text: "Text - Content description. Lorem Diom Wonderfull Text. Testing wraps!"
    
    signal ok()
    
    PropertyAnimation {
        target: simpleDialog
        property: "opacity"
        from: 0
        to: 1
        duration: 500
        running: true
        
    }
    
    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: Theme.dark
        opacity: 0.9
    }
    
    Rectangle {
        id: content
        anchors.centerIn: parent
        width: columnLayout.implicitWidth
        height: columnLayout.implicitHeight
        radius: 4
        border.color: Theme.dark
        border.width: 1
        ColumnLayout {
            id: columnLayout
            spacing: 12
            Label {
                text: simpleDialog.title
                Layout.leftMargin: 12
                Layout.topMargin: 12
                font.pointSize: 18
            }
            
            Label {
                text: simpleDialog.text
                wrapMode: Text.WordWrap
                Layout.topMargin: 12
                Layout.maximumWidth: 300
                Layout.rightMargin: 12
                Layout.leftMargin: 12
                font.pointSize: 12
            }
            RowLayout {
                spacing: 12
                Layout.rightMargin: 12
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.topMargin: 18
                Layout.bottomMargin: 12
                RoundButton {
                    id: btnCancel
                    radius: 4
                    text: "Abbrechen"
                    flat: true
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.preferredWidth: 85
                    rightPadding: 12
                    leftPadding: 12
                    padding: 0
                    topInset: 0
                    leftInset: 0
                    rightInset: 0
                    bottomInset: 0
                    onClicked: simpleDialog.destroy();
                }
                
                RoundButton {
                    id: btnOk
                    radius: 4
                    text: "Ok"
                    flat: true
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.preferredWidth: 85
                    rightPadding: 12
                    leftPadding: 12
                    leftInset: 0
                    rightInset: 0
                    bottomInset: 0
                    topInset: 0
                    padding: 0
                    
                    onClicked: {
                        simpleDialog.ok();
                        simpleDialog.destroy();
                    }
                }
                
            }
        }
    }
}
