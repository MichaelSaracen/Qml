import QtQuick 2.15

import "../js/index.js" as MS


Rectangle {
    id: minesweeper
    color: '#d0d0d0'
    width: cellSize * rows
    height: cellSize * colums
    anchors.centerIn: parent

    property alias canvas: canvas
    property alias mineTimer: mineTimer
    property int cellSize : 50
    property int rows: rowCountSpinBox.value
    property int colums: columnCountSpinBox.value
    property var fields: []
    property bool started: false
    property bool firstClickFree: true
    property var selectedField: null
<<<<<<< HEAD
    property int bombCount: 0
    property int maxPoints: (rows * colums) - bombCount
    property int score: 0
    property int bombsHitted: 0

    Component.onCompleted: { console.log(maxPoints) }
    signal fieldSelected( field: var )
    signal allSelected( )
    signal gameOver( );

    function openGameDialog( windowTitle, text, callBack ) {
        const cmp = Qt.createComponent("../App/GameDialog.qml");
        if ( cmp.status ===  Component.Ready ) {
            const obj = cmp.createObject( app, { windowTitle: windowTitle, text: text } );
            obj.onSubmit.connect( () => { callBack() });
        }
    }

=======
    property int bombCount: parseInt((rows * colums) * 0.2)
    property int points: (rows * colums) - bombCount

    Component.onCompleted: { console.log(points) }
    signal fieldSelected( field: var )
    signal allSelected( )
>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            getContext('2d');
            MS.redraw();
        }
    }

    MouseArea {
        anchors.fill: parent
<<<<<<< HEAD
        enabled: minesweeper.started && !mineTimer.running && startButton.checked
=======
        enabled: minesweeper.started
>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28

        onClicked: { MS.findField(mouseX, mouseY) }
    }

<<<<<<< HEAD
    onFieldSelected: (field) => { MS.onFieldSelected(field);}
    onAllSelected: {
        controlPanel.timer.stop();
        controlPanel.elapsedTimer.stop();
        if ( minesweeper.score === minesweeper.maxPoints ) {
            openGameDialog("Maximum Score!", `Congratukation! You've reached the maximum Score of ${minesweeper.maxPoints} !`, () => MS.resetGame() );
        } else if ( minesweeper.score < minesweeper.maxPoints ) {
            openGameDialog("Finished!", `You've reached ${minesweeper.score} points of maximum score ${minesweeper.maxPoints} !`, () =>  MS.resetGame() );
        }
    }

    onGameOver: {
        openGameDialog("GameOver!", `Game is over. Out of time !`, () =>  MS.resetGame() );
=======
    onFieldSelected: (field) => { MS.onFieldSelected(field); }
    onAllSelected: {
        console.log("finished");
>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28
    }

    Timer {
        id: mineTimer
        interval: spinBoxTimer.value
        running: false
        repeat: false
        onTriggered: {
            if ( minesweeper.selectedField ) {
                minesweeper.selectedField = null;
                MS.showMines(false);
                minesweeper.canvas.requestPaint();
                console.log("dd")
                //minesweeper.mineSelected = false;
            }

        }
    }

}




















