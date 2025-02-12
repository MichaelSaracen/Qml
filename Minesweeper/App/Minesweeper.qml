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
    property int rows: controlPanel.rowCountSpinBox.value
    property int colums: controlPanel.columnCountSpinBox.value
    property var fields: []
    property bool started: false
    property bool firstClickFree: true
    property var selectedField: null

    signal fieldSelected( field: var )

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
        enabled: started

        onClicked: { MS.findField(mouseX, mouseY) }
    }

    onFieldSelected: (field) => { MS.onFieldSelected(field); }

    Timer {
        id: mineTimer
        interval: 1000
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




















