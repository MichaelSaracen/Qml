import QtQuick 2.15
import QtQuick.Layouts
import App.Appearance

import QtQuick.Controls 2.15

ColumnLayout {
    id: addQAndA
    width: 375
    height: 33

    property alias lblSubject: lblSubject
    Label {
        text: qsTr("Frage und Antwort hinzufügen")
    }
    
    RowLayout {
        Layout.bottomMargin: 8
        Layout.topMargin: 8
        Label {
            text: qsTr("Fach:")
        }
        
        Label {
            id: lblSubject
            Layout.fillWidth: true
        }
        
        Button {
            icon.source: Icons.tasks
            enabled: lblSubject.text.length > 0 && taQuestion.text.length > 0 && taAnswer.text.length > 0 && subjectID !== -1
            flat: true
            bottomInset: 0
            topInset: 0
            leftPadding: 0
            rightPadding: 0
            bottomPadding: 0
            topPadding: 0
            Layout.preferredHeight: 30
            Layout.preferredWidth: 30
            Material.roundedScale: Material.NotRounded

            ToolTip.visible: hovered
            ToolTip.text: "Speichern der Frage und Antwort"
            ToolTip.delay: 1000
            onClicked: {
                const taskID = database.addQuestionAndAnswer( taQuestion.text, taAnswer.text, subjectID );
                listModelQuestions.append( { taskID, question: taQuestion.text, answer: taAnswer.text, selected: false } )
                taQuestion.clear();
                taAnswer.clear();
            }
        }
    }
    
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
    }
    
    TextArea {
        id: taAnswer
        width: 375
        height: 80
        wrapMode: Text.WordWrap
        Layout.maximumHeight: 150
        Layout.minimumHeight: 150
        Layout.preferredHeight: 150
        Layout.fillWidth: true
        topPadding: 8
        rightPadding: 8
        placeholderText: qsTr("Antwort")
        leftPadding: 8
    }
}
