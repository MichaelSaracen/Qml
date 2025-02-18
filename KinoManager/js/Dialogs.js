function simpleDialog( title, text, callback ) {
    const component = Qt.createComponent("../App/Dialogs/SimpleDialog.qml");
    if ( component.status === Component.Ready ) {
        const obj = component.createObject( app, { title, text } );
        obj.onOk.connect( () => { callback(); } );
    }
}

function addMovieDialog(callback) {
    const component = Qt.createComponent("../App/Dialogs/AddMovieDialog.qml");
    if ( component.status === Component.Ready ) {
        console.log("OPEN")
        const obj = component.createObject( app );
        obj.movieDialog.onSubmit.connect( (title, genre, fsk, duration, description, picture) =>
                                         { callback(title, genre, fsk, duration, description, picture) } );
    }
}
