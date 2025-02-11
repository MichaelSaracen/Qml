import QtQuick
import QtQuick.Controls

import App

Window {
    title: Properties.title
    width: Properties.width
    height: Properties.height
    color: Theme.background
    visibility: breakout.btnExpandWindow.checked ?  Window.FullScreen : Window.Windowed
    visible: true

    Action {
        shortcut: "F2"
        onTriggered: {
            breakout.btnExpandWindow.checked = !breakout.btnExpandWindow.checked;
        }
    }

    Action { shortcut: "F1" ; onTriggered: { Theme.darkmode = !Theme.darkmode; } }

    // Breakout
    Breakout {
        id: breakout
        anchors.fill: parent
    }

}
