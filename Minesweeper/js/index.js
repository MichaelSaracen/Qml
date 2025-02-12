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



function allSelected ( ) {
    let noMines = minesweeper.fields.filter( ( field ) => field.type !== 'Mine' );

    for ( const field of noMines ) {
        if (!field.selected ) return false
    }
    return true;
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
        minesweeper.canvas.context.strokeStyle = '#7644ff';
        minesweeper.canvas.context.fillStyle = '#242329';
        minesweeper.canvas.context.fillRect( field.x, field.y , field.width, field.height );
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


<<<<<<< HEAD
=======

function showMines( visible = true ) {
    for ( const field of minesweeper.fields ) {
        if ( field.type === 'Mine' ) {
            field.visible = visible;
        }
    }
    minesweeper.mineTimer.running = visible;
}

function allSelected ( ) {
    let noMines = minesweeper.fields.filter( ( field ) => field.type !== 'Mine' );
    let selected = false;

    for ( const field of noMines ) {
        if (!field.selected ) return false
    }
    return true;
}

function onFieldSelected( field ) {
    if ( !field.selected  ) field.selected = true;


    minesweeper.selectedField = field;
    setMines( field );

    // [!] --- Field Typen Prüfung und Aufdeckungen
    if ( field.type === 'Mine' ) {
        showMines();
    } else if ( field.type === 'Field' ) {
        field.visible = true;
    } else if ( field.type === 'None'){
        floodFill(field)
    }

    if ( allSelected( ) ) {
        // [!] --- Signal triggern wenn alle Felder ausgewählt wurden
        minesweeper.allSelected( );
    }

    minesweeper.canvas.requestPaint();
}

/**
 * Zeichnet alles neu. Löscht zuvor das Canvas
 */
function redraw() {
    minesweeper.canvas.context.clearRect( 0, 0, minesweeper.canvas.width, minesweeper.canvas.height );
    minesweeper.canvas.context.fillStyle = '#242329';
    minesweeper.canvas.context.fillRect( 0, 0, minesweeper.canvas.width, minesweeper.canvas.height );

    drawFields()

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

>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28
function floodFill(field) {
    let queue = [field];
    let visited = new Set();

    while (queue.length > 0) {
        let current = queue.shift();

        if (current.visible || visited.has(current)) continue;

        current.visible = true;
        current.selected = true;
        visited.add(current);

        if (current.mineCount > 0) continue;

        let neighbors = getNeightbors(current);
        for (const neighbor of neighbors) {
            if ( neighbor.type === "Field" ) continue;
            if (!visited.has(neighbor) && !neighbor.visible) {
                queue.push(neighbor);
            }
        }
    }
}


function getNeightbors ( field ) {
    let neighbors = [];
    for (const otherField of minesweeper.fields) {
        let dx = Math.abs(otherField.x - field.x);
        let dy = Math.abs(otherField.y - field.y);

        if (dx <= minesweeper.cellSize && dy <= minesweeper.cellSize && otherField !== field) {
            neighbors.push(otherField);
        }
    }

    return neighbors;
}

function initFieldTypes() {
    for ( const field of minesweeper.fields ) {
        if( field.type === 'Mine') continue;
        if ( field.mineCount > 0 ) {
            field.type = 'Field';
        }
    }
}



function showMines( visible = true ) {
    for ( const field of minesweeper.fields ) {
        if ( field.type === 'Mine' ) {
            field.visible = visible;
        }
    }
    minesweeper.mineTimer.running = visible;
}



function onFieldSelected( field ) {
    if ( !field.selected  ) field.selected = true;

    if ( !field.visible ) {
        minesweeper.selectedField = field;
        setMines( field );

        // [!] --- Field Typen Prüfung und Aufdeckungen
        if ( field.type === 'Mine' ) {
            showMines();
            minesweeper.bombsHitted++;
        } else if ( field.type === 'Field' ) {
            field.visible = true;

        } else if ( field.type === 'None'){
            floodFill(field)
        }

        minesweeper.score = scoreCount() - minesweeper.bombsHitted;
        minesweeper.score = minesweeper.score < 0 ? 0 : minesweeper.score;

        if ( allSelected( ) ) {
            // [!] --- Signal triggern wenn alle Felder ausgewählt wurden
            minesweeper.allSelected( );
        }
        console.log(minesweeper.maxPoints, minesweeper.score, allSelected())
        minesweeper.canvas.requestPaint();
    }

}





/**
 * Zeichnet alles neu. Löscht zuvor das Canvas
 */
function redraw() {
    minesweeper.canvas.context.clearRect( 0, 0, minesweeper.canvas.width, minesweeper.canvas.height );
    minesweeper.canvas.context.fillStyle = '#242329';
    minesweeper.canvas.context.fillRect( 0, 0, minesweeper.canvas.width, minesweeper.canvas.height );

    drawFields()

}

/**
 * Setzt die Einstellungen des Minesweepers zurück
 */
function resetGame() {
    minesweeper.score = 0;
    minesweeper.bombsHitted = 0;
    minesweeper.selectedField = null;
    minesweeper.firstClickFree = true;
    minesweeper.started = false;
    minesweeper.bombCount = Math.floor(Math.random() *
                                       (parseInt((minesweeper.rows * minesweeper.colums) * 0.25) -
                                        parseInt((minesweeper.rows * minesweeper.colums) * 0.15) + 1 ) ) +
                                        parseInt((minesweeper.rows * minesweeper.colums) * 0.15)
    clearFields();
    minesweeper.canvas.requestPaint();
    minesweeper.startButton.checked = false;

}


function scoreCount ( ) {
    let countArray = minesweeper.fields.filter( ( field ) => field.type !== 'Mine' && field.selected );
    return countArray.length;
}

function setMines ( firstClickedField ) {
    if ( !minesweeper.firstClickFree ) return;

    minesweeper.firstClickFree = false;

    let mineCount = minesweeper.bombCount;
    let availableFields = minesweeper.fields.filter( (field) => field !== firstClickedField );

    while ( mineCount > 0 ) {
        let rndIdx = Math.floor(Math.random() * availableFields.length);
        let field = availableFields[rndIdx];
        field.type = "Mine";
        availableFields.splice(rndIdx, 1);

        mineCount --;

        let neightbors = getNeightbors( field );
        for ( const neightbor of neightbors )
            neightbor.mineCount ++;
    }
    initFieldTypes();
}

/**
 * Startet das Spiel.
 */
function startGame () {
    if ( !minesweeper.started ) {

        minesweeper.bombCount = Math.floor(Math.random() *
                                           (parseInt((minesweeper.rows * minesweeper.colums) * 0.25) -
                                            parseInt((minesweeper.rows * minesweeper.colums) * 0.15) + 1 ) ) +
                                            parseInt((minesweeper.rows * minesweeper.colums) * 0.15)
        minesweeper.started = true;
        addFields();
        drawFields();
        minesweeper.canvas.requestPaint();
    }

}






































