.import "card.js" as Card
.import QtQuicks as Q

var selectionCount = 0

const sources = [
                  "../assets/cards/tile000.png",
                  "../assets/cards/tile001.png",
                  "../assets/cards/tile002.png",
                  "../assets/cards/tile003.png",
                  "../assets/cards/tile004.png",
                  "../assets/cards/tile005.png",
                  "../assets/cards/tile006.png",
                  "../assets/cards/tile007.png",
                  "../assets/cards/tile008.png",
                  "../assets/cards/tile010.png",
                  "../assets/cards/tile011.png",
                  "../assets/cards/tile012.png",
                  "../assets/cards/tile013.png",
                  "../assets/cards/tile014.png",
                  "../assets/cards/tile015.png",
                  "../assets/cards/tile016.png",
                  "../assets/cards/tile017.png",
                  "../assets/cards/tile018.png",
                  "../assets/cards/tile020.png",
                  "../assets/cards/tile021.png",
                  "../assets/cards/tile022.png",
                  "../assets/cards/tile023.png",
                  "../assets/cards/tile024.png",
                  "../assets/cards/tile025.png",
                  "../assets/cards/tile026.png",
                  "../assets/cards/tile027.png",
                  "../assets/cards/tile028.png",
              ]

function initCards ( ) {
    const rows = memoryField.rows;
    const cols = memoryField.columns;
    const cardWidth = memoryField.cardWidth;
    const cardHeight = memoryField.cardHeight;
    let count = 0;
    for ( let y = 0; y < rows; y++ ) {
        for ( let x = 0; x < cols; x++ ) {
            const idx = Math.floor(count / 2);
            memoryField.cards.push(new Card.Card(x * cardWidth, y * cardHeight, cardWidth, cardHeight, sources[idx], idx));

            count ++;
        }
    }
    shuffleCards( )
    //setSources();

}

function setSources() {
    let count = 0;
    for ( const card of memoryField.cards ) {
        let cardIndex = Math.floor(count % memoryField.cards.length / 2);
        count++;
        card.source = sources[cardIndex]
    }
}


function shuffleCards (  ) {
    for (let i = memoryField.cards.length - 1; i > 0; i--) {
        let j = Math.floor(Math.random() * (i + 1));
        memoryField.cards[j].swap(memoryField.cards[i])
    }

}

function redraw ( ctx ) {
    for (const card of memoryField.cards ) {
        card.draw( ctx );
    }
}


function findCard( ev ) {
    const item = memoryField.cards.find ( card => ev.x > card.left && ev.x < card.right && ev.y > card.top && ev.y < card.bottom )
    if ( item ) {
        if ( !item.visible ) {
            item.visible = true;
        }
        memoryField.canvas.cardSelected( item )
    }
}


function onCardSelect ( card ) {
    if ( memoryField.lastSelected && memoryField.lastSelected !== card ) {
        memoryField.canvas.twoCardsSelected( memoryField.lastSelected, card );
        memoryField.lastSelected = null
    } else {

        memoryField.lastSelected = card
    }
    memoryField.canvas.requestPaint();
}

function hasMatch ( card1, card2 ) {
    return card1.pairID === card2.pairID;
}

function hideSlectedCards (  ) {
    memoryField.cards.forEach( (card) => {
                                if ( card.visible && !card.hasMatch ) {
                                      card.visible = false;
                                  }
                              } );
    memoryField.canvas.requestPaint();
}


function showAllCards ( interval ) {
    memoryField.cards.forEach( (card) => card.visible = true );

    const cmp = Qt.createComponent("Timer");
    if ( cmp.status === Q.Component.Ready ) {
        var obj = cmp.createObject(app, { interval: interval, running: true })
        obj.onTriggered.connect ( () => {
                                    memoryField.cards.forEach( (card) => card.visible = false );
                                    canvas.requestPaint();
                                 })
    }
}















