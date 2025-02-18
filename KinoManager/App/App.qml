import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 6.8

import App
import App.Database
import "Dialogs"
import "Controls"

import "../js/Query.js" as Query

Rectangle {
    id: app

    width: Properties.width
    height: Properties.height

    Server { id: server }
    Database { id: database }

    // AddMovieDialog {
    //     id: addMovieDialog
    // }

    ListViewMovies {
        id: listViewMovies
        width: 392
        anchors.left: navigationBar.right
        anchors.top: headerItem.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
    }

    PreviewMovieItem {
        id: previewMovieItem
        anchors.left: listViewMovies.right
        anchors.top: headerItem.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
    }

    HeaderItem {
        id: headerItem
    }

    NavigationBar {
        id: navigationBar

    }

    // SimpleDialog {
    //     id: simpleDialog
    // }

    // Connections {
    //     target: movieDialog
    //     function onSubmit(title: string, genre: string, fsk: string, duration: string, description: string, picture: string) {
    //         Query.addMovie(title, genre, fsk, duration, description, picture)
    //     }
    // }


}
