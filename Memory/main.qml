import QtQuick

import "Memory"

Window {
    id: window
    width: 1700
    height: 1200

    visible: true
    title: "Memory"

    Image {
        anchors.fill: parent
        source: "assets/vecteezy_abstract-simple-shape-fluid-shapes-memphis-style-background_7167445.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Memory {
        id: memory
        anchors.fill: parent
    }
}

