pragma Singleton
import QtQuick 2.15

QtObject {
    property int width: 1500
    property int height: 1000
    property string appTitle: "IHK - Tasks"

    property color dark: "#1e2227"
    property color dark400: Qt.darker(dark, 0.8)
    property color dark300: Qt.darker(dark, 0.9)
    property color dark200: Qt.darker(dark, 1.0)
    property color dark100: Qt.darker(dark, 1.1)

    property color light: "#d0d0d0"
    property color light400: Qt.lighter(light, 0.8)
    property color light300: Qt.lighter(light, 0.9)
    property color light200: Qt.lighter(light, 1.0)
    property color light100: Qt.lighter(light, 1.1)
}
