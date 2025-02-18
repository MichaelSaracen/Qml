/**
 * Fügt unter Angabe der Parameter einen neuen Film hinzu. Dieser wird auch direkt dem ListModel hinzugefügt!
 * @param title
 * @param genre
 * @param fsk
 * @param duration
 * @param description
 * @param picture
 */
function addMovie( title, genre, fsk, duration, description, picture ) {
    //listModelMovies.append()
    if ( database.addMovie( title, genre, fsk, duration, description, picture ) ) {
        const id = database.lastInsertedID();
        console.log("Last inserted ID:", id );
        listViewMovies.listModelMovies.append({ id, title, genre, fsk, duration, description, picture, selected: false });
        selectFromModel( listViewMovies.listModelMovies.count -1 , previewMovieItem );
    }
}

/**
 * Entfern einen Eintrag aus der Datenbank
 * @param id - Die id in der Datenbank
 * @param index - Der Index für das ListModel
 */
function removeEntry ( id, index ) {
    database.removeEntry( id );
    selectFromModel( index - 1, previewMovieItem );
    listViewMovies.listModelMovies.remove( index );
}

/**
 * Entfernt alle Filme aus der Movie Tabelle und leert das ListModel
 */
function removeMovies () {
    database.removeMovies();
    listViewMovies.listModelMovies.clear();
}

/**
 * Wählt unter dem index einen Film aus dem Model.
 * @param index
 * @param target
 */
function selectFromModel ( index, target ) {
    if ( index >= 0) {
        const data              = listViewMovies.listModelMovies.get(index);
        target.title            = data.title;
        target.genre            = data.genre;
        target.fsk              = data.fsk;
        target.duration         = data.duration;
        target.description      = data.description;
        if ( target.image )
            target.image.source = data.picture;
        if ( target.smallImage )
            target.smallImage.source = data.picture
    }
}

/**
 * Beschafft alle Filme und deren Informationen und lädt diese in das ListModel.
 */
function selectAllMovies() {
    listModelMovies.clear();
    const movies = database.movies();
    for ( const { id, title, genre, fsk, duration, description, picture } of movies ) {
        listModelMovies.append({ id, title, genre, fsk, duration, description, picture, selected: false });
    }
}



