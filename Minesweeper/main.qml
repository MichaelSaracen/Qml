import QtQuick
import "App"

Window {
    width: 1400
    height: 1080
    visible: true
    title: qsTr("Hello World")

    App {
        id: app
        anchors.fill: parent
    }
}
