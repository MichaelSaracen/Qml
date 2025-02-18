import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import App
import "../../js/Dialogs.js" as Dialogs
import "../../js/Query.js" as Query
import "../../js/Logic.js" as Logic

Rectangle {
    id: navigationBar
    clip: true
    //width: 70
    height: 700
    //Material.foreground:   "white"
    width: headerItem.btnShowNavbar.checked ? 70 : -1
    color: "#ffffff"
    border.color: "#37000000"
    border.width: 1
    anchors.left: parent.left
    anchors.top: headerItem.bottom
    anchors.bottom: parent.bottom
    anchors.leftMargin: -1
    anchors.topMargin: -1
    anchors.bottomMargin: -1
    Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        RoundButton {
            id: btnAddMovie
            radius: 0

            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            bottomInset: 0
            rightInset: 0
            leftInset: 0
            topInset: 0
            padding: 0
            bottomPadding: 0
            topPadding: 0
            flat: true

            icon.source:  Icons.add

            ToolTip.text: "Öffnet einen Dialog, zum hinzufügen eines Films."
            ToolTip.timeout: 5000
            ToolTip.delay: 1000
            ToolTip.visible: hovered

            onClicked: {
                Dialogs.addMovieDialog((title, genre, fsk, duration, description, picture) => {
                                        Query.addMovie(title, genre, fsk, duration, description, picture);
                                           Logic.filterSelectedDelegate( listViewMovies.listModelMovies.count - 1 );
                                       })
            }

        }
        RoundButton {
            id: btnDeleteMovies
            enabled: listViewMovies.listModelMovies.count > 0
            radius: 0

            Layout.preferredHeight: 70
            Layout.preferredWidth: 70
            bottomInset: 0
            rightInset: 0
            leftInset: 0
            topInset: 0
            padding: 0
            bottomPadding: 0
            topPadding: 0
            flat: true

            icon.source:  Icons.del

            ToolTip.text: "Es werden alle Filme aus der Datenbank entfernt."
            ToolTip.timeout: 5000
            ToolTip.delay: 1000
            ToolTip.visible: hovered

            onClicked: {
                Dialogs.simpleDialog( "Movies entfernen",
                                     "Sollen wirklich alle Filme aus der <b>Movie - Tabelle</b> entfern werden?",
                                     () => { Query.removeMovies(); })
            }

        }


        Item {  Layout.fillHeight: true }
    }
    
}
