import QtQuick
import QtQuick3D
import Generated.QtQuick3D.Cuberoom
import QtQuick.Controls.Material
import QtQuick.Layouts
import "Camera.js" as Cam
import Generated.QtQuick3D.Mountain
import QtQuick3D.Helpers
import QtQuick.Controls 6.8
import Generated.Effects.ColorOverlay 1.0

Window {
    id: window
    width: 1200
    height: 1000

    visible: true
    title: "Canvas_3D_Point"
    color: "#1e2227"
    visibility: Window.FullScreen

    property alias pausePlayButton: pausePlayButton
    property alias wasd: wasd

    View3D {
        id: view3D
        anchors.fill: parent

        environment: SceneEnvironment {
            aoEnabled: true
            temporalAAStrength: 2
            temporalAAEnabled: true
            specularAAEnabled: true
            antialiasingQuality: SceneEnvironment.VeryHigh
            antialiasingMode: SceneEnvironment.MSAA
            backgroundMode: SceneEnvironment.Transparent

        }

        Cuberoom {
            id: cuberoom
            x: 0
            z: 0

        }
        WasdController {
            id: wasd
            keysEnabled: true
            xInvert: true
            yInvert: false
            ySpeed: 2
            xSpeed: 2
            downSpeed: 1.9
            mouseEnabled: true
            controlledObject: cuberoom.camera
        }

    }

    Button {
        id: pausePlayButton
        checkable: true
        checked: false
        width: 100
        height: 100
        text: qsTr("Button")
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 16
        anchors.bottomMargin: 16
        flat: true

        icon.color: "#d0d0d0"

        icon.height: 48
        icon.width: 48
        icon.source: !checked ? "assets/pause.png" :  "assets/play.png"
        display: AbstractButton.IconOnly
        Material.roundedScale: Material.SmallScale

        ColorOverlay { }

        onClicked: wasd.focus = true;

    }

    Button {
        id: cameraAutoButton
        checkable: true
        checked: false
        width: 100
        height: 100
        text: qsTr("Button")
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 16
        anchors.bottomMargin: 16
        flat: true

        icon.color: "#d0d0d0"

        icon.height: 48
        icon.width: 48
        icon.source: !checked ? "assets/prev_of.png" :  "assets/prev_on.png"
        display: AbstractButton.IconOnly
        Material.roundedScale: Material.SmallScale

        ColorOverlay { }

        onClicked: wasd.focus = true;

    }

    Rectangle {
        id: _item
        width: !listButton.checked ? 200: 0
        height: !listButton.checked ? columnLayout.implicitHeight + 64 : 0
        color: "#c021252b"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 16
        anchors.topMargin: 16
        clip: true
        Behavior on width { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad } }
        Behavior on height { NumberAnimation { duration: 400; easing.type: Easing.InOutQuad } }

        ColumnLayout {
            id: columnLayout
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 32
            anchors.rightMargin: 32
            anchors.topMargin: 32
            clip: true
            spacing: 16
            //anchors.fill: parent
            Label {
                id: label
                text: qsTr("Sphere")
                font.pointSize: 16
                Layout.bottomMargin: 16
            }

            Repeater {
                model: [
                    {name: "delta.x", data: cuberoom.sphere.deltaX},
                    {name: "delta.y", data: cuberoom.sphere.deltaY},
                    {name: "delta.z", data: cuberoom.sphere.deltaZ},
                    {name: "scale.x", data: cuberoom.sphere.scale.x},
                    {name: "scale.y", data: cuberoom.sphere.scale.y},
                    {name: "scale.z", data: cuberoom.sphere.scale.z},
                    {name: "x", data: cuberoom.sphere.x},
                    {name: "y", data: cuberoom.sphere.y},
                    {name: "z", data: cuberoom.sphere.z},
                    {name: "top", data: cuberoom.sphere.top},
                    {name: "bottom", data:cuberoom.sphere.bottom},
                    {name: "left", data: cuberoom.sphere.left},
                    {name: "right", data: cuberoom.sphere.right},
                    {name: "back", data: cuberoom.sphere.back},
                    {name: "front", data: cuberoom.sphere.front},
                    {name: "speed", data: slider.value},
                ]

                RowLayout {
                    Label {
                        text: modelData.name
                        Layout.preferredWidth: 75
                    }
                    Label {
                        text: modelData.data.toFixed(2)
                        color: modelData.data.toFixed(2) > 0 ? '#d0d0d0' : '#ff6160'
                    }
                }
            }

        }



    }

    Navigation {
        id: navigation
        anchors.bottom: slider.top
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Slider {
        id: slider
        y: 920
        width: 294
        height: 48
        value: 1

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 32
        stepSize: 1
        anchors.horizontalCenter: parent.horizontalCenter
        Material.accent: '#ff6160'

        to: 10
        from: 1
        onMoved:  {
            cuberoom.timer.speed =  value

        }
    }

    Timer {
        id: cameraTimer
        interval: 3000
        repeat: true
        running: !cameraAutoButton.checked
        onTriggered: {
            navigation.currentIndex ++;
            const index = Math.abs(navigation.currentIndex) % navigation.arrayLength

            const camera = cuberoom.camera;
            Cam.selectCamera(camera, index)

            wasd.focus = true;

            if(navigation.currentIndex === navigation.arrayLength)
                navigation.currentIndex = 0;
        }
    }

    Button {
        id: exitButton
        width: 60
        height: 60
        text: qsTr("Button")
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 16
        anchors.topMargin: 16
        bottomInset: 0
        topInset: 0
        icon.width: 48
        icon.source:  "assets/exit.png"
        icon.height: 48
        icon.color: "#d0d0d0"
        flat: true
        display: AbstractButton.IconOnly
        ColorOverlay {
        }

        Material.roundedScale: Material.SmallScale
        onClicked: {
            window.close()
        }
    }

    Button {
        id: listButton
        width: 60
        height: 60
        text: qsTr("Button")
        anchors.left: _item.right
        anchors.top: parent.top
        anchors.leftMargin: 16
        anchors.topMargin: 16
        bottomInset: 0
        topInset: 0
        icon.width: 48
        icon.source: !checked ? "assets/prev_of.png" :  "assets/prev_on.png"
        icon.height: 48
        icon.color: "#d0d0d0"
        flat: true
        display: AbstractButton.IconOnly
        ColorOverlay {
        }
        checked: false
        checkable: true
        Material.roundedScale: Material.SmallScale
    }

}


/*##^##
Designer {
    D{i:0}D{i:1;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}D{i:3;cameraSpeed3d:25;cameraSpeed3dMultiplier:1}
}
##^##*/
