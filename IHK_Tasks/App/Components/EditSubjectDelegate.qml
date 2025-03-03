import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance
import QtQuick.Controls 2.15

Rectangle {
    id: editSubjectDelegate
    width: listAddQandA.width
    height: 50
    color: selected ?  Properties.dark400: area.containsMouse ? Properties.dark300: Properties.dark200

    Behavior on color { ColorAnimation { duration: 300 } }
    //color:  Properties.dark300
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        
        property int lastIndex: -1
        onClicked: {
            settingsScreen.subjectID = subjectID;
            lblSubject.text = name;
            setModelSelection( lmSubjects, index );
            app.loadQuestions( subjectID )
        }
    }
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        
        
        Label {
            id: lbl
            text: name
            visible: !btnEdit.checked
            anchors.margins: 4
            Layout.rightMargin: 8
            Layout.fillWidth: true
            elide: Text.ElideRight
            font.pointSize: 8
        }
        
        TextField {
            text: lbl.text
            Layout.fillWidth: true
            visible: btnEdit.checked
            Layout.rightMargin: 8
            Layout.preferredHeight: 40
            focus: btnEdit.checked
            
            onEditingFinished: {
                if ( text.trim().length > 2 && text.trim() !== lbl.text) {
                    database.updateSubject( text, subjectID )
                    lmSubjects.setProperty(index, "name", text );
                    btnEdit.checked = false;
                }
            }
        }
        
        RoundButton {
            id: btnEdit
            checkable: true
            checked: false
            radius: 0
            icon.color: checked ? "#50f5f1" : Properties.light
            flat: true
            Layout.preferredHeight: 30
            Layout.preferredWidth: 30
            icon.source: Icons.edit
            leftInset: 0
            rightInset: 0
            bottomInset: 0
            topInset: 0
            padding: 0
            ToolTip.visible: hovered
            ToolTip.text: "Umbenennen des Faches"
            ToolTip.delay: 1000

        }
        
        RoundButton {
            radius: 0
            icon.color: "#ff6160"
            icon.source: Icons.close
            flat: true
            Layout.preferredHeight: 30
            Layout.preferredWidth: 30
            leftInset: 0
            rightInset: 0
            bottomInset: 0
            topInset: 0
            padding: 0

            ToolTip.visible: hovered
            ToolTip.text: "Entfernen des Faches"
            ToolTip.delay: 1000
            
            onClicked: {
                database.removeSubject( subjectID );
                lmSubjects.remove( index , 1 );
                lblSubject.text = "";
            }
            
        }
    }
}
