import QtQuick
import QtMultimedia
import "App"

Window {
    width: 1400
    height: 800
    visible: true
    title: qsTr("Minesweeper")

    Image {
        anchors.fill: parent
        source: Icons.bg
    }

    Image {
        anchors.fill: parent
        source: "qrc:/assets/bg.jpg"
    }

    App {
        id: app
        anchors.fill: parent
    }

}
