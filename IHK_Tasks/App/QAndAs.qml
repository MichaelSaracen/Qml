import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance

import "Components"
import QtQuick.Controls 2.15

Item {
    id: qAndAs
    visible: swipeView.currentIndex === 3
    clip: true
    
    property int index: 0
    
    function setQAndA ( index ) {
        const current = listModelQuestions.get( index );
        qAndAButton.question = current.question;
        qAndAButton.answer = current.answer;
        setModelSelection( listModelQuestions, index )
        qAndAButton.rotateBack();
    }
    
    function first ( ) {
        if ( index > 0 ) {
            prevAnimation.duration = 500 / (index + 1);
            prevAnimation.loops = index + 1
            prevAnimation.start()
            index = 0;
            setQAndA( index );
        }
    }
    
    function previous ( ) {
        if ( index <= 0 ) return
        prevAnimation.duration = 300;
        prevAnimation.loops = 1
        prevAnimation.start()
        
        index --;
        setQAndA( index );
    }
    
    function next ( ) {
        if ( index >= listModelQuestions.count - 1 ) return
        nextAnimation.duration = 300;
        nextAnimation.loops = 1;
        nextAnimation.start()
        
        index++;
        setQAndA( index );
    }

    function jumpForwardTo ( newIndex ) {
        nextAnimation.duration = 300 / Math.abs( (index + 1) - newIndex );
        nextAnimation.loops = Math.abs( index  - newIndex );
        nextAnimation.start()
    }


    
    function last ( ) {
        if ( index < listModelQuestions.count - 1 ){
            
            index = listModelQuestions.count - 1;
            setQAndA( index );
            nextAnimation.duration = 500 / (index + 1);
            nextAnimation.loops = (index + 1);
            nextAnimation.start()
        }
    }

    function openEditQandADialog() {
        const current = listModelQuestions.get(index);

        const component = Qt.createComponent( "Dialogs/EditQAndADialog.qml" );
        if ( component.status === Component.Ready ) {
            const obj = component.createObject( app, { question: current.question, answer: current.answer });
            obj.onSubmit.connect( (q, a) => {
                                     database.updateQuestion( q, current.taskID );
                                     database.updateAnswer( a, current.taskID );
                                     listModelQuestions.setProperty( index, "question", q );
                                     listModelQuestions.setProperty( index, "answer", a );
                                     qAndAButton.answer = a;
                                     qAndAButton.question = q;
                                 });
        }
    }


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
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            spacing: 0

            RoundButton {
                id: btnList
                icon.source: Icons.question
                checkable: true
                checked: setting.showList
                bottomInset: 0
                topInset: 0
                flat: true

                Layout.preferredWidth: 70
                Layout.preferredHeight: 70
                font.pointSize: 7
                height: 40
                radius: 0
                display: AbstractButton.IconOnly
                leftInset: 0
                rightInset: 0
                width: 40
                ToolTip.visible: hovered
                ToolTip.text: checked ? "Liste aus" : "Liste an"
                ToolTip.delay: 1000
            }

            RoundButton {
                checkable: true
                checked: setting.showList
                bottomInset: 0
                topInset: 0
                flat: true

                Layout.preferredWidth: 70
                Layout.preferredHeight: 70
                font.pointSize: 7
                height: 40
                radius: 0
                display: AbstractButton.IconOnly
                leftInset: 0
                rightInset: 0
                width: 40
                icon.source: Icons.edit

                ToolTip.visible: hovered
                ToolTip.text: "Die aktuelle Frage und Antwort bearbeiten"
                ToolTip.delay: 1000

                onClicked: { openEditQandADialog() }

            }

            Label {
                text: qsTr("Fragen und Antworten")
                Layout.rightMargin: 16
                Layout.leftMargin: 16
                font.pointSize: 16
            }

            Item { Layout.fillWidth: true }

            RoundButton {
                bottomInset: 0
                topInset: 0
                flat: true
                Layout.preferredWidth: 70
                Layout.preferredHeight: 70
                font.pointSize: 7
                height: 40
                radius: 0
                icon.source: "../assets/setings.png"
                leftInset: 0
                rightInset: 0
                width: 40
                ToolTip.visible: hovered
                ToolTip.text: "Zu den Einstellungen"
                ToolTip.delay: 1000
                onClicked: {
                    swipeView.setCurrentIndex(0)
                    subjectChoise.subjectIndex = -1;
                }
            }

            RoundButton {
                bottomInset: 0
                topInset: 0
                flat: true
                icon.source: Icons.card
                Layout.preferredWidth: 70
                Layout.preferredHeight: 70
                font.pointSize: 7
                height: 40
                radius: 0
                leftInset: 0
                rightInset: 0
                width: 40
                ToolTip.visible: hovered
                ToolTip.text: "Fach Auswahl"
                ToolTip.delay: 1000
                onClicked: {
                    swipeView.setCurrentIndex(2)
                    subjectChoise.subjectIndex = -1;
                }
            }

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
                    subjectChoise.subjectIndex = -1;
                }
            }
        }
    }

    Item {
        id: centerItem
        z: 1
        height: qAndAs.height * 0.4
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: clQuestions.right
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        
        QAndAButton {
            id: qAndAButton
            width: parent.width * 0.4
            height: parent.height
            font.pointSize: height * 0.04 || 12
            z: 0
            x: (parent.width / 2) - (width / 2)
        }
        
        SequentialAnimation {
            id: nextAnimation
            property int duration: 500
            
            NumberAnimation {
                target: qAndAButton
                property: "x"
                from: (centerItem.width / 2) - (qAndAButton.width / 2)
                to: 0 - qAndAButton.width
                duration: nextAnimation.duration
                easing.type: Easing.InOutQuad
            }
            
            NumberAnimation {
                target: qAndAButton
                property: "x"
                from: qAndAs.width
                to: (centerItem.width / 2) - (qAndAButton.width / 2)
                duration: nextAnimation.duration
                easing.type: Easing.InOutQuad
            }
        }
        
        SequentialAnimation {
            id: prevAnimation
            property int duration: 500
            
            NumberAnimation {
                target: qAndAButton
                property: "x"
                from: (centerItem.width / 2) - (qAndAButton.width / 2)
                to: qAndAs.width
                duration: prevAnimation.duration
                easing.type: Easing.InOutQuad
            }
            
            NumberAnimation {
                target: qAndAButton
                property: "x"
                from: 0 - qAndAButton.width
                to: (centerItem.width / 2) - (qAndAButton.width / 2)
                duration: prevAnimation.duration
                easing.type: Easing.InOutQuad
            }
        }
    }
    
    ColumnLayout {
        anchors.top: centerItem.bottom
        anchors.topMargin: 32
        anchors.horizontalCenter: centerItem.horizontalCenter
        RowLayout {
            spacing: 16

            NavButton {
                text: "erste"
                source: Icons.first
                enabled: qAndAs.index > 1
                font.pointSize: 7
                Layout.preferredHeight: 75
                Layout.preferredWidth: 75
                onClicked: {
                    qAndAs.first(  );
                }
            }

            NavButton {
                text: "vorherige"
                source: Icons.back
                font.pointSize: 7
                enabled: qAndAs.index > 0
                Layout.preferredHeight: 75
                Layout.preferredWidth: 75
                onClicked: {
                    qAndAs.previous();
                }
            }


            NavButton {
                text: "vorherige"
                source: Icons.forward
                enabled: qAndAs.index < listModelQuestions.count - 1
                font.pointSize: 7
                Layout.preferredHeight: 75
                Layout.preferredWidth: 75
                onClicked: {
                    qAndAs.next();
                }
            }


            NavButton {
                text: "letze"
                source: Icons.last
                enabled: qAndAs.index  < listModelQuestions.count - 2
                font.pointSize: 7
                Layout.preferredHeight: 75
                Layout.preferredWidth: 75
                onClicked: {
                    qAndAs.last(  );
                }

            }
        }

        TextField {
            id: tfAnswer
            opacity: !qAndAButton.checked ? 1 : 0
            visible: opacity > 0
            Layout.topMargin: 16
            Layout.preferredHeight: 40
            Layout.fillWidth: true
            placeholderText: qsTr("Deine Antwort")
            Behavior on opacity { NumberAnimation { duration: 300; } }

            onEditingFinished: {
                if ( text.length > 0 ) {
                    console.log( "---------------------------" )
                    console.log("Richtige Antwort:", qAndAButton.answer )
                    console.log("Deine Antwort:", text )
                    console.log( "---------------------------" )
                    clear();
                    next();

                }
            }
        }
    }


    ColumnLayout {
        id: clQuestions
        anchors.left: parent.left
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        width: btnList.checked ? 300 : 0
        Behavior on width { NumberAnimation { duration: 300 ; easing.type: Easing.InOutQuad }
        }

        ListView {
            id: listView
            clip: true
            model: listModelQuestions
            spacing: 2
            z: 10

            Layout.fillHeight: true
            Layout.fillWidth: true

            delegate: Rectangle {
                width: listView.width
                height: 45
                color: selected ?  Properties.dark300: Properties.dark200

                Behavior on color { ColorAnimation { duration: 300 } }

                Label {
                    text: question
                    anchors.margins: 4
                    elide: Text.ElideRight
                    anchors.fill: parent
                    //horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 8
                }
                MouseArea {
                    id: area
                    anchors.fill: parent
                    hoverEnabled: true

                    property int lastIndex: -1
                    onClicked: {
                        setModelSelection( listModelQuestions, index )
                        qAndAs.jumpForwardTo( index )
                        qAndAs.index = index;
                        qAndAs.setQAndA( index )
                    }
                }
            }
        }
    }



    Component.onDestruction: {
        setting.showList = btnList.checked;
    }
}






































