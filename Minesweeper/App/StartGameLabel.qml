import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material

import "../js/index.js" as MS
import QtQuick.Controls 2.15
import Generated.Effects.DropShadow 1.0

ColumnLayout {
    id: startGameLabel
    Label {
        id: label
        text: `Press the <b>Play</b> Button`
        font.pointSize: 18
    }
    
    Label {
        id: label1
        text: `to <b>START</b> the Game`
        Layout.topMargin: -2
        font.pointSize: 14
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    }
    
    Image {
        id: image
        width: 100
        height: 100
        source: Icons.play
        Layout.topMargin: 16
        sourceSize.height: 100
        sourceSize.width: 100
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        fillMode: Image.PreserveAspectFit
    }
}
