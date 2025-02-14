import QtQuick
import QtQuick.Controls

import "../js/Index.js" as Index

Rectangle {
    id: app
    width: Properties.width
    height: Properties.height
    color: '#d0d0d0'

    Item {
        id: memoryField
        anchors.centerIn: parent
        width: cardWidth * columns
        height: cardHeight * rows

        property int rows: 4
        property int columns: 6
        property int cardWidth: 114
        property int cardHeight: 148
        property var cards: []
        property bool isPlayerTurn: true
        property var lastSelected: null


        property alias canvas: canvas
        property alias fieldArea: fieldArea


        Canvas {
            id: canvas
            anchors.fill: parent
            signal cardSelected ( card: var )
            signal twoCardsSelected ( card1: var, card2: var )

            onPaint: {
                const ctx = canvas.getContext('2d');
                ctx.fillStyle = '#b0b0b0';
                ctx.fillRect(0, 0, width, height)
                Index.redraw( ctx );
            }

            MouseArea {
                id: fieldArea
                anchors.fill: parent
                enabled: memoryField.isPlayerTurn
                onClicked: ( ev )  => { Index.findCard( ev ) }
            }

            Timer {
                id: hidingTimer
                running: false
                interval: 1000
                onTriggered:  {
                    console.log("running")
                    Index.hideSlectedCards( )

                }

            }


            onImageLoaded: {Index.showAllCards(1000);  canvas.requestPaint(); }
            Component.onCompleted: { Index.initCards(); }

            onCardSelected: ( card ) => { Index.onCardSelect( card ) }
            onTwoCardsSelected: ( card1, card2 ) => {
                                    console.log(card1.x, card2.x)
                                    if ( Index.hasMatch( card1, card2 ) ) {
                                        card1.hasMatch = true;
                                        card2.hasMatch = true;
                                        console.log("Match")
                                    } else {
                                        console.log("No Match")
                                        hidingTimer.running = true;

                                    }
                                }
        }

    }

    Button {
        onClicked: {
            memoryField.canvas.requestPaint()
        }
    }

}
