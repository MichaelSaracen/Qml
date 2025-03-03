import QtQuick
import QtQuick.Controls.Material
import App
import QtCore

Window {
    id: window
    width: Properties.width
    height: Properties.height
    visible: true
    title: Properties.appTitle
    color: Qt.darker( Material.background, 1.2 )

    Settings {
        id: setting
        property bool showList: true
    }

    App { id: app; anchors.fill: parent }
}
