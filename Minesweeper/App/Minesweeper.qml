import QtQuick 2.15

import "../js/index.js" as MS

Rectangle {
    id: minesweeper
    color: '#d0d0d0'
    width: cellSize * rows
    height: cellSize * colums
    anchors.centerIn: parent

    property alias canvas: canvas
    property int cellSize : 50
    property int rows: controlPanel.rowCountSpinBox.value
    property int colums: controlPanel.columnCountSpinBox.value
    property var fields: []
    property bool started: false
    property bool pauseBySelected: false
    property var selectedField: null
    property bool firstClickFree: true

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
        enabled: started && !pauseBySelected

        onClicked: { MS.findField(mouseX, mouseY) }
    }

    onFieldSelected: (field) => { MS.onFieldSelected(field); }

    Timer {
        id: selectionTimer
        interval: 200
        running: pauseBySelected
        repeat: false
        onTriggered: {
            if ( minesweeper.selectedField ) {
                minesweeper.selectedField.selected = false;
                minesweeper.selectedField = null;
                minesweeper.pauseBySelected = false;
                minesweeper.canvas.requestPaint();
            }
            console.log("Running")

        }
    }
}




















