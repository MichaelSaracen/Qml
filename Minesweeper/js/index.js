.import "field.js" as Field

/**
 * Fügt der Liste fields ein neues Feld hinzu.
 * @param x
 * @param y
 * @param width
 * @param height
 */
function addField ( x, y, width, height ) {
    minesweeper.fields.push ( new Field.Field( x, y, width, height ) );
}

/**
 * Fügt dem Minesweeper alle Felder hinzu
 */
function addFields ( ) {
    if ( minesweeper.fields.length > 0 ) return;

    let rows        = minesweeper.rows;
    let colums      = minesweeper.colums;
    let cellSize    = minesweeper.cellSize;
    for ( let y = 0; y < rows; y++ ) {
        for ( let x = 0; x < colums; x++ ) {
            addField( y * cellSize, x * cellSize, cellSize, cellSize );
        }
    }
}

/**
 * Leert die fields aus dem Minesweeper
 */
function clearFields ( ) {
    // [!] --- Verhindern von mehreren Signalen senden
    if ( minesweeper.fields.length === 0 ) return;
    minesweeper.fields.length = 0;
}

/**
 *
 */
function drawFields (  ) {
    for ( const field of minesweeper.fields ) {
         minesweeper.canvas.context.strokeRect( field.x, field.y , field.width, field.height );
         field.draw();
    }
}

function findField( mouseX, mouseY ) {
    const field = minesweeper.fields.find( (item) => mouseX > item.left && mouseX < item.right && mouseY > item.top && mouseY < item.bottom );
    if ( field ) {
        field.selected = true;
        minesweeper.fieldSelected( field );
    }
}



function onFieldSelected( field ) {
    minesweeper.pauseBySelected = true; // Startet den Timer sodass nicht gewählt werden kann.
    minesweeper.selectedField = field;
    setMines( field );
    minesweeper.canvas.requestPaint();
}

/**
 * Zeichnet alles neu. Löscht zuvor das Canvas
 */
function redraw() {
    minesweeper.canvas.context.clearRect( 0, 0, minesweeper.canvas.width, minesweeper.canvas.height );

    if ( minesweeper.fields.length > 0) {
        drawFields()
    }
}

/**
 * Setzt die Einstellungen des Minesweepers zurück
 */
function resetGame() {
    minesweeper.firstClickFree = true;
    minesweeper.started = false;
    clearFields();
    minesweeper.canvas.requestPaint();
}


function getNeightbors ( field ) {
    let neighbors = [];
    for (const otherField of minesweeper.fields) {
        let dx = Math.abs(otherField.x - field.x);
        let dy = Math.abs(otherField.y - field.y);

        // Überprüfe, ob das Feld in einem 3x3-Quadrat um die Mine liegt (aber nicht die Mine selbst)
        if (dx <= minesweeper.cellSize && dy <= minesweeper.cellSize && otherField !== field) {
            neighbors.push(otherField);
        }
    }
    return neighbors;

}

function setMines ( firstClickedField ) {
    if ( !minesweeper.firstClickFree ) return;
    minesweeper.firstClickFree = false;

    let mineCount = 10;
    let availableFields = minesweeper.fields.filter( (field) => field !== firstClickedField );

    while ( mineCount > 0 ) {
        let rndIdx = Math.floor(Math.random() * availableFields.length);
        let field = availableFields[rndIdx];
        field.type = "Mine";
        availableFields.splice(rndIdx, 1);

        mineCount --;

        let neightbors = getNeightbors( field );
        for ( const neightbor of neightbors ) {
            neightbor.mineCount ++;
        }
    }
}

/**
 * Startet das Spiel.
 */
function startGame () {
    minesweeper.started = true;
    addFields();
    drawFields();
    minesweeper.canvas.requestPaint();
}






































