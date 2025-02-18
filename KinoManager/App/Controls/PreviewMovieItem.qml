import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Effects

import App


Item {
    id: previewMovieItem
    width: 1380
    height: 935

    Material.theme: Material.Dark
    Material.foreground: "#d0d0d0"
    property string title: "-"
    property string genre: "-"
    property string fsk: "-"
    property string duration: "00:00"
    property string description: "-"
    property url picture: ""
    property alias image: image
    property alias smallImage: smallImage

    Image {
        id: image
        anchors.fill: parent
        source: "../../assets/1600.jpg"

        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        id: bgRect
        color: Theme.dark
        anchors.fill: parent
        opacity: 0.699
    }

    Item {
        width: previewMovieItem.width * 0.75
        height: 550
        anchors.centerIn: parent

        RowLayout {
            id: rowLayout
            anchors.fill: parent
            spacing: 16
            Image {
                id: smallImage
                source: "../../assets/1600.jpg"
                Layout.minimumHeight: 400
                Layout.minimumWidth: 275
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.maximumHeight: 400
                Layout.maximumWidth: 275
                fillMode: Image.PreserveAspectCrop
                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true

                }
            }

            GridLayout {
                width: 100
                height: 100
                Layout.topMargin: 12
                Layout.bottomMargin: 12
                Layout.rightMargin: 12
                Layout.leftMargin: 12
                columnSpacing: 16
                columns: 3

                Label {
                    text: qsTr("Titel")
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: true
                    font.bold: true
                }
                RowLayout {
                    spacing: 16
                    Label {
                        id: titleLabel
                        text: previewMovieItem.title
                        font.pointSize: 18
                        font.bold: true
                        Layout.fillWidth: true
                        visible: !btnEditTitle.checked
                    }
                    TextField {
                        Layout.fillWidth: true
                        text: previewMovieItem.title
                        Layout.preferredHeight: 40
                        visible: btnEditTitle.checked
                        onEditingFinished: {
                            previewMovieItem.title = text;
                            btnEditTitle.checked = false;
                        }
                    }
                }
                RoundButton {
                    id: btnEditTitle
                    radius: 4
                    icon.color: "#ffffff"
                    icon.source: Icons.edit
                    rightInset: 0
                    checkable: true
                    leftInset: 0
                    bottomInset: 0
                    topInset: 0
                    padding: 0
                    flat: true
                }

                Label { text: qsTr("Genre") ;font.bold: true }

                RowLayout {
                    spacing: 16
                    Label {
                        id: genreLabel
                        text: previewMovieItem.genre
                        font.pointSize: 16
                        Layout.fillWidth: true
                        visible: !btnEditGenre.checked

                    }
                    ComboBox {
                        id: genreField
                        Layout.rightMargin: 7
                        model: Properties.genres
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        visible: btnEditGenre.checked
                        displayText: previewMovieItem.genre
                        onCurrentTextChanged: {
                            previewMovieItem.genre  = currentText;
                            btnEditGenre.checked    = false
                        }
                    }
                }
                RoundButton {
                    id: btnEditGenre
                    radius: 4
                    icon.color: "#ffffff"
                    icon.source: Icons.edit
                    rightInset: 0
                    checkable: true
                    leftInset: 0
                    bottomInset: 0
                    topInset: 0
                    padding: 0
                    flat: true
                }

                Label { text: qsTr("Fsk") ; font.bold: true}

                RowLayout {
                    spacing: 16
                    Label {
                        id: fskLabel
                        text: previewMovieItem.fsk
                        font.pointSize: 16
                        Layout.fillWidth: true
                        visible: !btnEditFSK.checked
                    }

                    ComboBox {
                        id: fskField
                        Layout.rightMargin: 7
                        model: Properties.fsks
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        visible: btnEditFSK.checked
                        displayText: previewMovieItem.fsk
                        onCurrentTextChanged: {
                            previewMovieItem.fsk = currentText;

                            btnEditFSK.checked = false
                        }
                    }
                }
                RoundButton {
                    id: btnEditFSK
                    radius: 4
                    icon.color: "#ffffff"
                    icon.source: Icons.edit
                    rightInset: 0
                    checkable: true
                    leftInset: 0
                    bottomInset: 0
                    topInset: 0
                    padding: 0
                    flat: true
                }

                Label { text: qsTr("Dauer") ; font.bold: true }
                RowLayout {
                    spacing: 16
                    Label {
                        id: durationLabel
                        text: previewMovieItem.duration
                        font.pointSize: 16
                        Layout.fillWidth: true
                        visible: !btnEditDuration.checked
                    }

                    ComboBox {
                        id: durationHoursField
                        Layout.rightMargin: 7
                        model: Array.from( {length : 24}, (_,i) => String(i).padStart(2, "0") )
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        visible: btnEditDuration.checked
                        displayText: previewMovieItem.duration.slice(0, 2)
                        popup.height: Math.min(10 * 40, model.length * 40)
                        onCurrentTextChanged: {
                            previewMovieItem.duration = currentText + ":" + durationMinutesField.displayText
                        }
                    }

                    ComboBox {
                        id: durationMinutesField
                        Layout.rightMargin: 7
                        model: Array.from( {length : 60}, (_,i) => String(i).padStart(2, "0") )
                        Layout.preferredHeight: 40
                        Layout.fillWidth: true
                        visible: btnEditDuration.checked
                        displayText: previewMovieItem.duration.slice(3)
                        popup.height: Math.min(10 * 40, model.length * 40)
                        onCurrentTextChanged: {
                            previewMovieItem.duration = durationHoursField.displayText + ":" + currentText
                        }
                    }
                }
                RoundButton {
                    id: btnEditDuration
                    radius: 4
                    icon.color: "#ffffff"
                    icon.source: Icons.edit
                    rightInset: 0
                    checkable: true
                    leftInset: 0
                    bottomInset: 0
                    topInset: 0
                    padding: 0
                    flat: true
                    onCheckedChanged: {
                        previewMovieItem.duration = durationHoursField.displayText + ":" + durationMinutesField.displayText;
                    }
                }
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 0
                    Layout.columnSpan: 3
                    Label { text: qsTr("Beschreibung") ; font.bold: true; Layout.fillWidth: true }

                    RoundButton {
                        id: btnEditDescription
                        radius: 4
                        icon.color: "#ffffff"
                        icon.source: Icons.edit
                        rightInset: 0
                        checkable: true
                        leftInset: 0
                        bottomInset: 0
                        topInset: 0
                        padding: 0
                        flat: true
                        onCheckedChanged: {
                            previewMovieItem.description = textEdit.text;
                        }
                    }
                }

                TextArea {
                    id: textEdit
                    width: 80
                    height: 20
                    text: previewMovieItem.description
                    font.pixelSize: 12
                    wrapMode: Text.WrapAnywhere
                    Layout.columnSpan: 3
                    Layout.maximumHeight: 200
                    Layout.fillWidth: true
                    visible: btnEditDescription.checked
                }

                Label {
                    id: labelDescription
                    text: previewMovieItem.description
                    wrapMode: Text.WrapAnywhere
                    font.pointSize: 16
                    Layout.maximumHeight: 200
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    Layout.columnSpan: 3
                    visible: !btnEditDescription.checked
                }
                Label {
                    color: Theme.highlight
                    text: qsTr("Saal Infos")
                    Layout.topMargin: 24
                    Layout.columnSpan: 3
                    Layout.fillWidth: true
                    font.bold: true
                    font.pointSize: 18
                }

                Label { text: qsTr("Name") ;font.bold: true }

                Label {
                    text: qsTr("Saal - 001")
                    font.bold: true
                    Layout.fillWidth: true
                }

                RoundButton {
                    //id: btnEditDuration
                    radius: 4
                    icon.color: "#ffffff"
                    icon.source: Icons.edit
                    rightInset: 0
                    checkable: true
                    leftInset: 0
                    bottomInset: 0
                    topInset: 0
                    padding: 0
                    flat: true
                    onCheckedChanged: {
                        //previewMovieItem.duration = durationHoursField.displayText + ":" + durationMinutesField.displayText;
                    }
                }


                Label { text: qsTr("Status") ;font.bold: true }

                Label {
                    text: qsTr("spielt in keinem Saal")
                    Layout.fillWidth: true
                }

                RoundButton {
                    //id: btnEditDuration
                    radius: 4
                    icon.color: "#ffffff"
                    icon.source: Icons.edit
                    rightInset: 0
                    checkable: true
                    leftInset: 0
                    bottomInset: 0
                    topInset: 0
                    padding: 0
                    flat: true
                    onCheckedChanged: {
                        //previewMovieItem.duration = durationHoursField.displayText + ":" + durationMinutesField.displayText;
                    }
                }


            }
        }
    }
}
