import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 6.8

import App


Frame {
    id: addMovieDialog
    property alias movieDialog: movieDialog
    anchors.fill: parent
    padding: 0
    topPadding: 0
    bottomPadding: 0
    
    
    PropertyAnimation {
        target: addMovieDialog
        property: "opacity"
        from: 0
        to: 1
        duration: 500
        running: true
        
    }
    
    Rectangle {
        id: bgRect
        anchors.fill: parent
        color: Theme.dark
        opacity: 0.9
    }
    
    
    MovieDialog {
        id: movieDialog
        anchors.centerIn: parent
    }

    Connections {
        target: movieDialog

        function onSubmit() {
            addMovieDialog.destroy();
        }

        function onAbort() {
            addMovieDialog.destroy();
        }
    }
}
