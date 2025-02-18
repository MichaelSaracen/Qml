import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 6.8

import App

import "../../js/Query.js" as Query
import "../../js/Logic.js" as Logic


ListView {
    id: listViewMovies
    width: 392
    height: 80

    property alias listModelMovies: listModelMovies

    model: ListModel {
        id: listModelMovies;
        Component.onCompleted: {
            Query.selectAllMovies();
            Query.selectFromModel( listModelMovies.count - 1, previewMovieItem );
            Logic.filterSelectedDelegate( listModelMovies.count - 1 );
        }
    }
    delegate: MovieItemDelegate {
        id: movieItemDelegate
        //required property int index
    }
}
