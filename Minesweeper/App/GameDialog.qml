import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../js/index.js" as MS
import QtQuick.Controls 2.15
import Generated.Effects.DropShadow 1.0

Frame {
    id: gameDialog
    anchors.fill: parent
    bottomPadding: 0
    topPadding: 0
    padding: 0
    
    PropertyAnimation {
        target: gameDialog
        property: "opacity"
        duration: 500
        from: 0
        to: 1
        running: true
    }
    
    property string windowTitle: "Title"
    property string text: "Sehr langer Text der gewrapped werden kann, um einen Zeilenumbruch anzuzeigen oder anderen Stuff!"
    
    signal submit()
    
    Rectangle {
        opacity: 0.797
        anchors.fill: parent
        color: '#242329'
    }
    
    Rectangle {
        width: 400
        height: dialogLayout.implicitHeight
        anchors.centerIn: parent
        color: '#242329'
        border.width: 1
        border.color: '#7644ff'
        radius: 4
        DropShadow { }
        
        ColumnLayout {
            id: dialogLayout
            anchors.fill: parent
            Label {
                text: gameDialog.windowTitle
                Layout.bottomMargin: 16
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.topMargin: 16
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                font.pointSize: 18
            }
            
            Label {
                text: gameDialog.text
                wrapMode: Text.WordWrap
                Layout.bottomMargin: 16
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                Layout.topMargin: 16
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                font.pointSize: 12
                Layout.fillWidth: true
            }
            
            Button {
                text: "close Dialog."
                Layout.rightMargin: 16
                Layout.bottomMargin: 16
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                Material.roundedScale: Material.SmallScale
                flat: true
                onClicked: {
                    gameDialog.submit();
                    gameDialog.destroy();
                }
            }
            
        }
    }
}
