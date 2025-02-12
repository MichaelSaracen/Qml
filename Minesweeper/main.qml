import QtQuick
import "App"

Window {
    width: 1400
    height: 800
    visible: true
    title: qsTr("Hello World")

    Image {
        anchors.fill: parent
        source: "qrc:/assets/bg.jpg"
    }

    App {
        id: app
        anchors.fill: parent
    }
}
