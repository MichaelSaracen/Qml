import QtQuick 2.15
import QtQuick.Layouts
import App.Appearance
import QtQuick.Controls 2.15

Rectangle {
    id: editQAndADelegate
    width: listEditQandA.width
    height: btnEdit.checked ? columnLayout1.implicitHeight : 50
    color: selected ?  Properties.dark400: area.containsMouse ? Properties.dark300: Properties.dark200
    
    Behavior on color { ColorAnimation { duration: 300 } }
    Behavior on height { NumberAnimation { duration: 300 } }
    
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        
        
        onClicked: {
            setModelSelection( listModelQuestions, index );
        }
    }
    
    ColumnLayout {
        id: columnLayout1
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        clip: true
        
        Item {
            Layout.preferredHeight: 50
            Layout.fillWidth: true
            
            RowLayout {
                anchors.fill: parent
                Label {
                    text: question
                    Layout.rightMargin: 8
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                }
                
                RoundButton {
                    radius: 0
                    topInset: 0
                    rightInset: 0
                    visible: btnEdit.checked
                    padding: 0
                    leftInset: 0
                    icon.source: Icons.tasks
                    flat: true

                    ToolTip.visible: hovered
                    ToolTip.text: "Speichern der Frage und Antwort"
                    ToolTip.delay: 1000
                    
                    bottomInset: 0
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30
                    onClicked: {
                        if ( taQuestion.text !== question && taAnswer.text && answer ) {
                            database.updateQuestion( taQuestion.text, taskID );
                            database.updateAnswer( taAnswer.text, taskID );
                            listModelQuestions.setProperty( index, "question", taQuestion.text);
                            listModelQuestions.setProperty( index, "answer", taAnswer.text);
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
                    ToolTip.text: "Die aktuelle Frage und Antwort bearbeiten"
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
                    ToolTip.text: "Frage entfernen"
                    ToolTip.delay: 1000
                    onClicked: {
                        database.removeQuestion( taskID );
                        listModelQuestions.remove( index, 1 );
                    }
                }
            }
        }
        
        Item {
            Layout.fillWidth: true
            height: textAreaLayout.implicitHeight
            
            ColumnLayout {
                id: textAreaLayout
                anchors.fill: parent
                
                TextArea {
                    id: taQuestion
                    width: 375
                    height: 80
                    wrapMode: Text.WordWrap
                    Layout.preferredHeight: 150
                    Layout.maximumHeight: 150
                    Layout.minimumHeight: 150
                    Layout.fillHeight: false
                    Layout.bottomMargin: 8
                    Layout.fillWidth: true
                    leftPadding: 8
                    rightPadding: 8
                    topPadding: 8
                    placeholderText: qsTr("Frage")
                    text: question
                }
                
                TextArea {
                    id: taAnswer
                    width: 375
                    height: 80
                    wrapMode: Text.WordWrap
                    Layout.bottomMargin: 12
                    Layout.maximumHeight: 150
                    Layout.minimumHeight: 150
                    Layout.preferredHeight: 150
                    Layout.fillWidth: true
                    topPadding: 8
                    rightPadding: 8
                    placeholderText: qsTr("Antwort")
                    leftPadding: 8
                    text: answer
                }
            }
        }
    }
}
