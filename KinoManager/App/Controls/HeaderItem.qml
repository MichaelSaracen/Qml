import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 6.8

import App

Rectangle {
    id: headerItem
    height: 70
    color: "#ffffff"
    border.color: "#37000000"
    border.width: 1
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.leftMargin: -1
    anchors.rightMargin: -1
    anchors.topMargin: -1
    
    property alias btnShowNavbar: btnShowNavbar
    
    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: 12
        
        RoundButton {
            id: btnShowNavbar
            radius: 0
             icon.source:  Icons.list
            checked: true
            checkable: true
            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            bottomInset: 0
            rightInset: 0
            leftInset: 0
            topInset: 0
            padding: 0
            bottomPadding: 0
            topPadding: 0
            flat: true
        }
        
        Label {
            id: label
            text: qsTr("KinoManager")
            Layout.fillWidth: true
            
            font.pointSize: 26
        }
        
        RoundButton {
            id: btnOpenServer
            radius: 0
            icon.source:  Icons.server
            topPadding: 0
            topInset: 0
            rightInset: 0
            padding: 0
            leftInset: 0
            flat: true
            
            bottomPadding: 0
            bottomInset: 0
            Layout.preferredWidth: 70
            Layout.preferredHeight: 70
            onClicked: {
                server.open();
            }
        }
    }
}
