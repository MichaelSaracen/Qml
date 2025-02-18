function filterSelectedDelegate( index ) {
    const model = listViewMovies.listModelMovies;
    for ( let i = 0; i < model.count; i++ ) {
        model.setProperty(i, "selected", false);
    }
    model.setProperty(index, "selected", true);

}
