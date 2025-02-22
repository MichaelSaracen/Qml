import QtQuick

import QtQuick.Controls.Material
import QtQuick.Layouts
import "Camera.js" as Cam
import Generated.Effects.ColorOverlay

Item {
    id: navigation
    width: rowLayout.implicitWidth
    height: rowLayout.implicitHeight
    property int arrayLength: Cam.arr.length
    property int currentIndex: 0


    RowLayout {
        id: rowLayout
        spacing: 25

        Button {
            id: button
            Layout.preferredWidth: 125
            
            icon.color: "#d0d0d0"
            flat: true
            icon.height: 48
            icon.width: 48
            icon.source: "assets/arrow_b.png"
            display: AbstractButton.IconOnly
            Material.roundedScale: Material.SmallScale

            onClicked: {
                navigation.currentIndex --;
                
                if(navigation.currentIndex < 0)
                    navigation.currentIndex = navigation.arrayLength  - 1;
                
                
                console.log( navigation.currentIndex)
                
                const camera = cuberoom.camera;
                Cam.selectCamera(camera, navigation.currentIndex)
                
                wasd.focus = true;
                
            }
            
            ColorOverlay {
                id: colorOverlay
            }
        }
        
        Button {
            id: button1
            text: qsTr("Button")
            flat: true
            
            icon.color: "#d0d0d0"
            
            icon.height: 48
            icon.width: 48
            icon.source: "assets/cube.png"
            display: AbstractButton.IconOnly
            Material.roundedScale: Material.SmallScale
            onClicked: {
                navigation.currentIndex = 0;
                const camera = cuberoom.camera;
                Cam.selectCamera(camera, navigation.currentIndex)
                wasd.focus = true;
                
            }
            ColorOverlay { }
            
        }
        Button {
            id: button2
            Layout.preferredWidth: 125
            
            icon.color: "#d0d0d0"
            flat: true
            icon.height: 48
            icon.width: 48
            icon.source: "assets/arrow_f.png"
            display: AbstractButton.IconOnly
            Material.roundedScale: Material.SmallScale
            
            onClicked: {
                navigation.currentIndex ++;
                const index = Math.abs(navigation.currentIndex) % navigation.arrayLength
                
                const camera = cuberoom.camera;
                Cam.selectCamera(camera, index)

                wasd.focus = true;
                
                if(navigation.currentIndex === navigation.arrayLength)
                    navigation.currentIndex = 0;
                
            }
            ColorOverlay { }
            
            
        }
    }




    Item {
        id: __materialLibrary__
    }
    
}
