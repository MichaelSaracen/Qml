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
    property int bombCount: parseInt((rows * colums) * 0.2)
    property int points: (rows * colums) - bombCount

    Component.onCompleted: { console.log(points) }
    signal fieldSelected( field: var )
    signal allSelected( )

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
        enabled: minesweeper.started

        onClicked: { MS.findField(mouseX, mouseY) }
    }

    onFieldSelected: (field) => { MS.onFieldSelected(field); }
    onAllSelected: {
        console.log("finished");
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




















