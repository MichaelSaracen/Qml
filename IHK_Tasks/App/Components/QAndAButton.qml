import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance

import QtQuick.Controls 2.15

AbstractButton {
    id: control
    hoverEnabled: enabled
    width: 400
    height: 400

    checkable: true
    checked: false

    property string question: "FRAGE: gna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
    property string answer: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."


    function rotateBack() {

        if ( cardRotation.angle >= 180 ) {
            control.checked = false;
        }
    }

    background: Rectangle{
        id: rectA
        radius: 12
        property real shadowBlur: control.hovered ? 1.5 : control.enabled ? 0.2 : 0.0

        color: control.down ? "#272b33" : "#1e2227"
        layer.enabled: true;


        Behavior on shadowBlur { NumberAnimation { duration: 300 } }
        Behavior on color { ColorAnimation { duration: 300 } }


        // Vorderseite (Frage)
        Label {
            id: questionLabel
            anchors.fill: parent
            anchors.margins: 16
            color: Properties.light
            text: control.question
            wrapMode: Text.WordWrap
            clip: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: control.font.pointSize
            visible: cardRotation.angle < 90 // Nur sichtbar, wenn die Karte auf der Vorderseite ist
        }

        // Rückseite (Antwort)
        Label {
            id: answerLabel
            anchors.fill: parent
            anchors.margins: 16
            color: Properties.light
            text: control.answer
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: control.font.pointSize
            visible: cardRotation.angle > 90 // Nur sichtbar, wenn die Karte auf der Rückseite ist
            transform: Rotation {
                id: labelRotation
                axis { x: 0; y: 1; z: 0 }
                origin.x: answerLabel.width / 2
                origin.y: answerLabel.height / 2
                angle:  180
            }
        }


        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowBlur: rectA.shadowBlur
        }
        transform: Rotation {
            id: cardRotation
            axis { x: 0; y: 1; z: 0 }
            origin.x: control.width / 2
            origin.y: control.height / 2
            angle: control.checked ? 180 : 0
            Behavior on angle {
                NumberAnimation {
                    duration: 500
                }
            }
        }
    }
}
















