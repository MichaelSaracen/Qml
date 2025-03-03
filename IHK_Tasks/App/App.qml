import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance

import "Components"
import QtQuick.Controls 2.15

Item {
    id: app
    width: Properties.width
    height: Properties.height

    property ListModel lmSubjects: ListModel {
        Component.onCompleted: { loadSubjects( lmSubjects ); }
    }

    property ListModel lmSubjectChoise: ListModel { }

    property ListModel listModelQuestions: ListModel { }

    function openCloseDialog() {
        const component = Qt.createComponent( "Dialogs/YesNoDialog.qml" );
        if ( component.status === Component.Ready ) {
            const obj = component.createObject( app, { });
        }
    }

    function unselectModel ( model, callBack = null ) {
        for ( let i = 0; i < model.count; i++ ) {
            const other = model.get( i );
            other.selected = false;
        }

        callBack();
    }

    function setModelSelection ( model, index ) {
        const current = model.get( index );
        current.selected = true;

        for ( let i = 0; i < model.count; i++ ) {
            const other = model.get( i );

            if( i !== index )
                other.selected = false;
        }
    }

    function loadSubjects( model ) {
        model.clear();
        const data = database.subjects();
        for ( const { subjectID, name } of data ) {
            model.append({ subjectID, name, selected: false });
        }
    }

    function loadQuestions( subjectID ) {
        listModelQuestions.clear();
        const data = database.querstions( subjectID );
        for ( const { taskID, question, answer} of data ) {
            listModelQuestions.append({ taskID, question, answer, selected: false });
        }
        qAndAs.index = 0;
    }

    Database { id: database }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 1
        interactive: false

        SettingsScreen {
            id: settingsScreen
        }

        StartScreen { id: startScreen }

        SubjectChoise { id: subjectChoise }

        QAndAs { id: qAndAs }

        onCurrentIndexChanged: {
            switch ( currentIndex ) {
            case 0:
                //loadSubjects(  )
                break;
            case 1:
                unselectModel( lmSubjectChoise, () => { subjectChoise.subjectIndex = -1; })
                break;
            case 2:
                loadSubjects( lmSubjectChoise );
                break;
            case 3:
                qAndAs.setQAndA( 0 );
                break;
            }
        }
    }
}


















