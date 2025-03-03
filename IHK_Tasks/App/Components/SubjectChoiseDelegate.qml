import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls 2.15
import App.Appearance

Item {
    id: subjectChoiseDelegate
    width: listView.width
    height: 60
    
    Rectangle {
        anchors.fill: parent        
        color: selected ?  Properties.dark400 : area.containsMouse ? Properties.dark300 : Properties.dark200
        
        Behavior on color { ColorAnimation { duration: 300 } }
        
        Label {
            text: name
            anchors.margins: 8
            elide: Text.ElideRight
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
        }
        
        MouseArea {
            id: area
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                setModelSelection( lmSubjectChoise, index )
                subjectChoise.subjectIndex = index;
                subjectChoise.subjectID = subjectID;
            }
        }
        
    }
}
