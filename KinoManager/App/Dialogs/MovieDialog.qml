import QtQuick
import QtQuick.Controls 6.8
import QtQuick.Layouts
import QtQuick.Dialogs

import App.Appearance

Rectangle {
    id: movieDialog
    width: 593
    height: 382
    border.color: Theme.dark
    radius: 4

    property string title
    property string genre
    property string fsk
    property string duration: "00:01"
    property string description
    property string picture
    
    signal abort()
    signal submit(title: string, genre: string, fsk: string, duration: string, description: string, picture: string)

    function resetEntries() {
        titleField.clear();
        textEdit.clear();
        movieImage.source = "";
        durationHoursField.text = "00"
        durationMinutesField.text = "01"
    }
    
    GridLayout {
        id: gridLayout
        width: 345
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 12
        anchors.topMargin: 12
        anchors.bottomMargin: 12
        columnSpacing: 12
        rowSpacing: 12
        columns: 2
        
        Label {
            text: qsTr("Titel")
            horizontalAlignment: Text.AlignRight
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            font.bold: true
        }
        
        TextField {
            id: titleField
            Layout.fillWidth: true
            Layout.preferredHeight: 35
            placeholderText: qsTr("")
            text: movieDialog.title
            
        }
        
        Label {
            text: qsTr("Genre")
            horizontalAlignment: Text.AlignRight
            font.bold: true
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }
        
        RowLayout {
            ComboBox {
                id: genreField
                Layout.rightMargin: 7
                model: Properties.genres
                Layout.preferredHeight: 35
                Layout.fillWidth: true
            }
            Label {
                text: qsTr("Fsk")
                horizontalAlignment: Text.AlignRight
                Layout.leftMargin: 0
                font.bold: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }
            ComboBox {
                id: fskField
                Layout.preferredWidth: 113
                model: Properties.fsks
                Layout.preferredHeight: 35
                Layout.fillWidth: false
            }
            
        }
        
        
        Label {
            text: qsTr("Dauer")
            horizontalAlignment: Text.AlignRight
            Layout.bottomMargin: 13
            font.bold: true
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }
        
        RowLayout {
            spacing: 12
            Layout.fillWidth: true
            ColumnLayout {
                spacing: 0
                TextField {
                    id: durationHoursField
                    Layout.fillWidth: true
                    placeholderText: qsTr("")
                    Layout.preferredHeight: 35
                    text: movieDialog.duration.slice(0, 2)
                    maximumLength: 2
                    validator: RegularExpressionValidator { regularExpression: /^[0-9]+$/ }
                    onEditingFinished: {
                        if ( text.length < 2 ) {
                            text = text.padStart(2, "0");
                        }
                    }
                    Keys.onUpPressed: {
                        if ( parseInt(text) < 23 ) {
                            let num = parseInt(text)
                            num ++
                            text = num
                            text = text.padStart(2, "0");
                        }
                    }

                    Keys.onDownPressed:  {
                        if ( parseInt(text) > 0 ) {
                            let num = parseInt(text)
                            num --
                            text = num
                            text = text.padStart(2, "0");
                        }
                    }
                }
                Label {
                    text: "Stunden"
                    font.pointSize: 8
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }
            }
            
            ColumnLayout {
                spacing: 0
                TextField {
                    id: durationMinutesField
                    Layout.fillWidth: true
                    placeholderText: qsTr("")
                    Layout.preferredHeight: 35
                    maximumLength: 2
                    text: movieDialog.duration.slice(3)
                    validator: RegularExpressionValidator { regularExpression: /^[0-9]+$/ }
                    onEditingFinished:  {
                        if ( text.length < 2 ) {
                            text = text.padStart(2, "0");
                        }
                    }

                    Keys.onUpPressed: {
                        if ( parseInt(text) < 59 ) {
                            let num = parseInt(text)
                            num ++
                            text = num
                            text = text.padStart(2, "0");
                        }
                    }
                    Keys.onDownPressed:  {
                        if ( parseInt(text) > 0 ) {
                            let num = parseInt(text)
                            num --
                            text = num
                            text = text.padStart(2, "0");
                        }
                    }
                }
                Label {
                    text: "Minuten"
                    font.pointSize: 8
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                }
            }
        }
        
        Label {
            text: qsTr("Beschreibung")
            horizontalAlignment: Text.AlignRight
            Layout.columnSpan: 2
            font.bold: true
        }
        
        TextArea {
            id: textEdit
            width: 80
            height: 20
            text: movieDialog.description
            font.pixelSize: 12
            wrapMode: Text.WrapAnywhere
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        
    }
    
    Rectangle {
        id: rectangle
        width: 213
        height: 221
        color: "#ffffff"
        border.width: 2
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 12
        anchors.topMargin: 12
        clip: true

        Label {
            anchors.centerIn: parent
            text: "Bild ..."
        }

        Image {
            id: movieImage
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }

        FileDialog {
            id: fileDialog
            nameFilters: ["*.png", "*.jpg", "*.jpeg"]

            onAccepted: movieImage.source = selectedFile
        }
    }
    
    RoundButton {
        id: btnLoadImage
        width: 213
        height: 52
        radius: 4
        text: "Bild hochladen"
        anchors.right: parent.right
        anchors.top: rectangle.bottom
        anchors.rightMargin: 12
        anchors.topMargin: 12
        rightInset: 0
        bottomInset: 0
        leftInset: 0
        topInset: 0
        onClicked: fileDialog.open()
    }
    
    RoundButton {
        id: btnSave
        enabled: titleField.text.length > 0 &&  Qt.resolvedUrl(movieImage.source) !== Qt.resolvedUrl("")
        x: 477
        y: 318
        width: 100
        height: 52
        radius: 4
        text: "übernehmen"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 12
        anchors.bottomMargin: 12
        topInset: 0
        rightInset: 0
        leftInset: 0
        bottomInset: 0

        onClicked:  {
            movieDialog.submit(titleField.text, genreField.currentText, fskField.currentText,
                               durationHoursField.text + ":" + durationMinutesField.text,
                               textEdit.text, movieImage.source)
            resetEntries();
            //movieDialog.destroy()
        }
    }
    
    RoundButton {
        id: btnClose
        x: 368
        y: 318
        width: 101
        height: 52
        radius: 4
        text: "schließen"
        anchors.right: btnSave.left
        anchors.bottom: parent.bottom
        anchors.rightMargin: 12
        anchors.bottomMargin: 12
        topInset: 0
        rightInset: 0
        leftInset: 0
        bottomInset: 0
        onClicked: {
            movieDialog.abort();
            resetEntries();
            //movieDialog.destroy()
        }
    }
}
