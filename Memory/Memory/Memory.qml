import QtQuick
import QtQuick.Controls
import Generated.Effects.DropShadow 1.0
import QtQuick.Layouts
import "../js/CardSources.js" as Cards

Item {
    id: memory
    width: 1000
    height: 700
    property int rows: 4
    property int columns: 6
    property int cardAmount: rows * columns
    property int cardWidth: Math.floor(114 * 0.85)
    property int cardHeight: Math.floor(146 * 0.85)
    property url backSide: "../assets/cards/back.png"
    property var firstSelected: null
    property var secondSelected: null
    property bool started: false
    property bool firstShow: false
    property bool isPlayerTurn: true
    property var reminderStack: []
    property string mode: comboBoxMode.currentText

    function showCards( visible ) {
        for ( let i = 0; i < cardModel.count; i++) {
            cardModel.setProperty(i, "selected", visible )
            cardModel.setProperty(i, "angle", visible ? 180 : 0 )
        }
    }

    function initCards() {
        let cardData = Cards.cardSources(memory.cardAmount)
        cardModel.clear();
        for (let i = 0; i < cardData.length; i++) {
            cardModel.append({
                                 "source": cardData[i].source,
                                 "pairId": cardData[i].pairId,
                                 "selected": false,
                                 "angle" : 0
                             })
        }
    }
    function addToReminderStack ( card ) {
        if (!reminderStack.some(c => c.pairId === card.pairId)) {
                reminderStack.push(card);
            }
    }

    function isOtherThen ( card ) {
        for ( let i = 0; i < cardModel.count; i++ ) {
            const current = cardModel.get(i)
            if (card !== current && card.pairId === current.pairId && memory.reminderStack.some(c => c.pairId === current.pairId)) {
                return current;
            }
        }
        return null;
    }

    function allSelected() {
        let selected = true;
        for ( let i = 0; i < cardModel.count ; i++ ) {
            const current = cardModel.get(i);
            if ( !current.selected ) {
                selected = false;
                break;
            }

        }
        return selected;
    }

    function getCardForComputer() {
        if (memory.firstSelected) {
                // Prüfe, ob er die zweite Karte irgendwann mal gesehen hat (aber nicht erraten hat)
                let rememberedCard = memory.reminderStack.find(c =>
                    c.pairId === memory.firstSelected.pairId && c !== memory.firstSelected && !c.selected
                );

                if (rememberedCard) {
                    return rememberedCard; // Falls er sich erinnert, kann er das Paar aufdecken
                }
            }

        // Falls kein bekanntes Paar existiert, wähle zufällig eine Karte
        if(!allSelected()) {

            while (true) {
                const rnd = Math.floor(Math.random() * cardModel.count);
                let card = cardModel.get(rnd);
                if (!card.selected) {
                    return card;
                }
            }
        }

        return null;
    }


    Component.onCompleted: {
        initCards()
    }

    Timer {
        id: displayCardsTimer
        running: memory.started
        repeat: false
        interval: 5000
        onTriggered: {
            showCards(false);
        }
    }

    Timer {
        id: computerTimer
        running: memory.started && !memory.isPlayerTurn
        repeat: !memory.isPlayerTurn
        interval: 1000
        onTriggered: {
            if (!memory.firstSelected) {
                memory.firstSelected = memory.getCardForComputer();
                memory.addToReminderStack(memory.firstSelected);
                memory.firstSelected.selected = true;
                memory.firstSelected.angle = 180;
            } else if (!memory.secondSelected) {

                if (memory.mode === "Hard-Mode") {
                    memory.secondSelected = memory.isOtherThen(memory.firstSelected);
                } else {
                    memory.secondSelected = memory.getCardForComputer();
                }

                memory.addToReminderStack(memory.secondSelected);
                memory.secondSelected.selected = true;
                memory.secondSelected.angle = 180;
            } else {
                if (memory.firstSelected.pairId === memory.secondSelected.pairId) {
                    console.log("Match!");
                } else {
                    console.log("No match!");
                    memory.firstSelected.angle = 0;
                    memory.secondSelected.angle = 0;
                    memory.firstSelected.selected = false;
                    memory.secondSelected.selected = false;
                }
                memory.firstSelected = null;
                memory.secondSelected = null;
                memory.isPlayerTurn = true;
            }
        }
    }

    Timer {
        id: checkPlayerSelectTimer
        running: memory.firstSelected && memory.secondSelected
        interval: 1000
        onTriggered: {
            if ( memory.firstSelected.pairId === memory.secondSelected.pairId) {
                console.log("match")
            } else {
                console.log("no match")
                memory.firstSelected.angle = 0;
                memory.secondSelected.angle = 0;
                memory.firstSelected.selected = false;
                memory.secondSelected.selected = false;
            }
            memory.firstSelected = null;
            memory.secondSelected = null;
            memory.isPlayerTurn = false;
        }
    }


    Rectangle {
        id: controlPanel
        height: 80
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        z: 1
        DropShadow { dropShadowBlurAmount: 0.6; extraMargin: 122 }

        RowLayout {
            id: rowLayout
            anchors.fill: parent
            anchors.leftMargin: 16
            spacing: 19
            ComboBox {
                id: comboBoxMode
                width: 132
                Layout.preferredWidth: 161
                model: ["Light-Mode", "Hard-Mode"]
            }

            Item {
                id: _item1
                width: 200
                height: 200
                Layout.fillHeight: true
                Layout.fillWidth: true
            }


            Button {
                id: resetButton
                text: "Reset"
                Layout.preferredWidth: 100
                Layout.fillHeight: true
                flat: true
                onClicked: {
                    initCards();
                    memory.started = false;
                    memory.firstShow = false;
                    showCards(false)

                }
                enabled: memory.started
            }



            Button {
                id: startButton
                text: "Start"
                Layout.preferredWidth: 100
                Layout.fillHeight: true
                flat: true
                onClicked: {

                    memory.started = true;
                    memory.firstShow = true;
                    showCards(true)
                }
                enabled: !memory.started
            }


            Item {
                id: _item
                width: 200
                height: 200
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Item {
                id: _item2
                Layout.rightMargin: 16
                Layout.preferredWidth: comboBoxMode.width
                Layout.fillHeight: true
            }


        }
    }

    Item {
        id: memoryField
        enabled: memory.started && !displayCardsTimer.running
        anchors.centerIn: parent
        width: memory.columns * memory.cardWidth
        height: memory.rows * memory.cardHeight

        DropShadow { }

        GridView {
            id: gridLayout
            anchors.fill: parent
            cellHeight: memory.cardHeight
            cellWidth: memory.cardWidth


            model: ListModel {
                id: cardModel
                Component.onCompleted: initCards()
            }

            delegate: Image {
                id: cardImage
                width: memory.cardWidth
                height: memory.cardHeight
                source:  selected ? (selected && cardRotation.angle > 90 ? model.source
                                                                         : memory.backSide)
                                  : (!selected && cardRotation.angle < 90 ? memory.backSide
                                                                          : model.source  )

                fillMode: Image.Stretch
                sourceSize.height: memory.cardHeight
                sourceSize.width: memory.cardWidth

                transform: Rotation {
                    id: cardRotation
                    axis { x: 0; y: 1; z: 0 }
                    origin.x: cardImage.width / 2
                    origin.y: cardImage.height / 2
                    angle:  model.angle
                    Behavior on angle {
                        NumberAnimation {
                            duration: 500
                        }
                    }
                }


                MouseArea {
                    anchors.fill: parent
                    enabled: !checkPlayerSelectTimer.running && memory.isPlayerTurn
                    onClicked: {
                        let current = cardModel.get(index)
                        if (!current.selected) {
                            current.selected = true;
                            current.angle = 180;
                            if (!memory.firstSelected) {
                                memory.firstSelected = current
                            } else if (!memory.secondSelected) {
                                memory.secondSelected = current
                            }
                        }
                    }
                }
            }
        }
    }







    RowLayout {
        id: rowLayout1
        y: 82
        height: 50
        anchors.left: memoryField.left
        anchors.right: memoryField.right
        anchors.bottom: memoryField.top
        spacing: 16


        Label {
            id: label
            text: qsTr("Am Zug:")
            font.pointSize: 22
        }

        Label {
            id: label1
            text: memory.isPlayerTurn ? "Memory Master" : "Computer"
            Layout.fillWidth: true
            font.pointSize: 22
        }
    }
}
