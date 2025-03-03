import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance

import QtQuick.Controls 2.15

AbstractButton {
    id: control
    hoverEnabled: enabled
    width: 200
    height: 200
    text: "Hello World"
    property url source: "../../assets/setings.png"
    
    property bool textEnabled: true
    
    background: Rectangle{
        id: rectA
        radius: 12
        property real shadowBlur: control.hovered ? 1.5 : control.enabled ? 0.2 : 0.0
        
        color: control.down ? "#272b33" : "#1e2227"
        layer.enabled: true;
        
        
        Behavior on shadowBlur { NumberAnimation { duration: 300 } }
        Behavior on color { ColorAnimation { duration: 300 } }
        
        ColumnLayout {
            anchors.fill: parent
            anchors.margins: control.textEnabled ? 16 : 8
            Image {
                source: control.source
                fillMode: Image.PreserveAspectFit
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Label {
                visible: control.textEnabled
                color: control.enabled ? Properties.light :  Properties.light400
                text: control.text
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: control.font.pointSize
                Layout.fillWidth: true
                Behavior on color { ColorAnimation { duration: 300 } }
            }
        }
        
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowBlur: rectA.shadowBlur
        }
    }
}
