pragma Singleton
import QtQuick

QtObject {
    property bool darkmode: true
    property color background: darkmode ? '#1e2227' : 'white'
    property color secondaryBackground: darkmode ? '#21252b' : '#d0d0d0'
    property color foreground: darkmode ? '#d0d0d0' : '#1e2227'
    property color highlight: darkmode ? '#ff6160' : '#90caf9'

    Behavior on background {
        ColorAnimation {
            duration: 300
        }
    }

    Behavior on secondaryBackground {
        ColorAnimation {
            duration: 300
        }
    }
}
