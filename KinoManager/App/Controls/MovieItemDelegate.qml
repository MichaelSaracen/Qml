import QtQuick
import QtQuick.Layouts
import QtQuick.Controls 6.8

import App

import "../../js/Query.js" as Query
import "../../js/Dialogs.js" as Dialogs
import "../../js/Logic.js" as Logic

Rectangle {
    id: movieItemDelegate
    color: selected ? "#d0d0d0" : "transparent"
    width: listViewMovies.width
    height: 70

    Behavior on color { ColorAnimation { duration: 300 } }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log(selected)
            Query.selectFromModel( index, previewMovieItem );
            Logic.filterSelectedDelegate( index );

        }
    }
    RowLayout {
        anchors.fill: parent
        
        Label {
            text: title
            Layout.leftMargin: 16
            Layout.fillWidth: true
            elide: Text.ElideRight
        }

        RoundButton {
            id: btnRemove
            radius: 4
            icon.source: Icons.remove
            Layout.rightMargin: 16
            rightInset: 0
            leftInset: 0
            bottomInset: 0
            topInset: 0
            padding: 0
            flat: true

            onClicked: {
                //console.log(id, index)
                Dialogs.simpleDialog(title + " entfernen",
                                     `Soll der Film <b> ${title} </b> , wirklich aus der Liste gelöscht werden? `,
                                     () =>  Query.removeEntry( id, index )
                                     )

            }
        }
    }
}
