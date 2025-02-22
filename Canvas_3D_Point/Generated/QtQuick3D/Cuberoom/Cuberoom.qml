import QtQuick
import QtQuick3D

import Generated.QtQuick3D.Mountain
import QtQuick3D.Particles3D 6.8

Node {
    id: node
    property alias camera: camera
    property alias sphere: sphere
    property alias timer: timer;
    Model {
        id: cube

        objectName: "Cube"

        scale.x: 300
        scale.y: 100
        scale.z: 200
        source: "meshes/cube_002_mesh.mesh"
        z: 0
        property real top: y + scale.y
        property real bottom: y - scale.y
        property real left: z + scale.z
        property real right: z - scale.z
        property real back: x + scale.x
        property real front: x - scale.x

        materials: material_material

    }
    Node {
        y: cube.top
        z: cube.left
        x: cube.front
        scale.z: 1
        scale.y: 1
        scale.x: 1
        eulerRotation.x: 90

        Rectangle {
            id: rectTop
            opacity: 0
            color: "#ff6160"
            width: cube.scale.x*2
            height: cube.scale.z*2

        }


        NumberAnimation {
            target: rectTop
            property: "opacity"
            duration: 300
            from: 1
            to: 0
            alwaysRunToEnd: true
            running: sphere.top >= cube.top
        }
    }

    Node {
        y: cube.bottom
        z: cube.left
        x: cube.front
        scale.z: 1
        scale.y: 1
        scale.x: 1
        eulerRotation.x: 90

        Rectangle {
            id: rectBottom
            opacity: 0
            color: "#ff6160"
            width: cube.scale.x*2
            height: cube.scale.z*2
        }

        NumberAnimation {
            target: rectBottom
            property: "opacity"
            duration: 300
            from: 1
            to: 0
            alwaysRunToEnd: true
            running: sphere.bottom <= cube.bottom
        }
    }

    Node {
        y: cube.top
        z: cube.left
        x: cube.front
        scale.z: 1
        scale.y: 1
        scale.x: 1

        Rectangle {
            id: rectLeft
            opacity: 0
            color: "#ff6160"
            width: cube.scale.x*2
            height: cube.scale.y*2
        }

        NumberAnimation {
            target: rectLeft
            property: "opacity"
            duration: 300
            from: 1
            to: 0
            alwaysRunToEnd: true
            running: sphere.left >= cube.left
        }
    }

    Node {
        y: cube.top
        z: cube.right
        x: cube.front
        scale.z: 1
        scale.y: 1
        scale.x: 1

        Rectangle {
            id: rectRight
            opacity: 0
            color: "#ff6160"
            width: cube.scale.x*2
            height: cube.scale.y*2

        }

        NumberAnimation {
            target: rectRight
            property: "opacity"
            duration: 300
            from: 1
            to: 0
            alwaysRunToEnd: true
            running: sphere.right <= cube.right
        }
    }

    Node {
        y: cube.top
        z: cube.left
        x: cube.front
        scale.z: 1
        scale.y: 1
        scale.x: 1
        eulerRotation.y: 90

        Rectangle {
            id: rectBack
            opacity: 0
            color: "#ff6160"
            width: cube.scale.z*2
            height: cube.scale.y*2
        }

        NumberAnimation {
            target: rectFront
            property: "opacity"
            duration: 300
            from: 1
            to: 0
            alwaysRunToEnd: true
            running: sphere.back >= cube.back
        }
    }

    Node {
        y: cube.top
        z: cube.left
        x: cube.back
        scale.z: 1
        scale.y: 1
        scale.x: 1
        eulerRotation.y: 90

        Rectangle {
            id: rectFront
            opacity: 0
            color: "#ff6160"
            width: cube.scale.z*2
            height: cube.scale.y*2
        }

        NumberAnimation {
            target: rectBack
            property: "opacity"
            duration: 300
            from: 1
            to: 0
            alwaysRunToEnd: true
            running: sphere.front <= cube.front
        }
    }



    Model {
        id: sphere
        x: -0
        y: -0
        objectName: "Sphere"

        scale.x: 15
        scale.y: 15
        scale.z: 15
        source: "meshes/sphere_mesh.mesh"
        z: 0

        property real top: y + scale.y
        property real bottom: y - scale.y
        property real left: z + scale.z
        property real right: z - scale.z
        property real back: x + scale.x
        property real front: x - scale.x

        property real deltaY: (Math.random() * (2.5 - 1) + 1)
        property real deltaZ: (Math.random() * (2.5 - 1) + 1)
        property real deltaX: (Math.random() * (2.5 - 1) + 1)

        materials: ball

        NumberAnimation on eulerRotation.x { from: 0; to: 360; running: !pausePlayButton.checked; duration: 300; loops: Animation.Infinite }
        NumberAnimation on eulerRotation.z { from: 0; to: 360; running: !pausePlayButton.checked; duration: 500; loops: Animation.Infinite }
        NumberAnimation on eulerRotation.y { from: 0; to: 360; running: !pausePlayButton.checked; duration: 550; loops: Animation.Infinite }
    }


    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: material_material
            emissiveFactor.y: 3.08113
            emissiveFactor.z: 1.19556
            emissiveFactor.x: 0
            objectName: "Material"
            baseColor: "#ffcccccc"
            roughness: 0.5
        }

        PrincipledMaterial {
            id: defaultMaterial_material
            objectName: "DefaultMaterial"
            baseColor: "#ffcccccc"
        }

        PrincipledMaterial {
            id: ball
            opacity: 1
            emissiveFactor.y: 0
            emissiveFactor.z: 0
            transmissionFactor: 0
            heightAmount: 0
            occlusionAmount: 1
            roughness: 1
            baseColor: "#838383"
            emissiveFactor.x: 0
            objectName: "Ball"
        }
    }

    PerspectiveCamera {
        id: camera
        x: -1859.188
        y: -1557.189
        z: 1768.87964
        eulerRotation.x: 30.83041
        eulerRotation.z: -0
        eulerRotation.y: -45.16463



        Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad  } }
        Behavior on y { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad  } }
        clipFar: 80000
        Behavior on z { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad  } }
        Behavior on eulerRotation.z { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad  } }
        Behavior on eulerRotation.x { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad  } }
        Behavior on eulerRotation.y { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad  } }

    }
    DirectionalLight {
        x: -0
        y: 137.069
        color: "#ffffff"
        castsShadow: true
        ambientColor: "#ffffff"
        eulerRotation.z: 0.00005
        eulerRotation.y: -0.00003
        eulerRotation.x: -67.61315
        brightness: 0.4
        z: 57.33538

    }


    Timer {
        id: timer
        interval: 10

        running: !pausePlayButton.checked
        repeat: true

        property int speed: 1


        onTriggered: {
            sphere.z += sphere.deltaZ * speed
            sphere.y += sphere.deltaY * speed
            sphere.x += sphere.deltaX * speed

            if(sphere.top >= cube.top || sphere.bottom <= cube.bottom) {
                sphere.deltaY = -sphere.deltaY
            }

            if(sphere.left >= cube.left || sphere.right <= cube.right) {
                sphere.deltaZ = -sphere.deltaZ
            }

            if(sphere.back >= cube.back || sphere.front <= cube.front) {
                sphere.deltaX = -sphere.deltaX
            }
            // console.log( )
        }
    }

    Mountain {
        id: mountain
        x: -3000
        y: -4750
        eulerRotation.y: -135
        z: 650
    }

    ParticleSystem3D {
        id: dust
        x: -3.434
        y: 0
        z: 2.06807
        ParticleEmitter3D {
            id: dustEmitter
            velocity: dustDirection
            shape: dustShape
            particleScaleVariation: 0.25
            particleScale: 1.75
            particle: dustParticle
            lifeSpanVariation: 100
            lifeSpan: 10000
            emitRate: 200
            SpriteParticle3D {
                id: dustParticle
                color: "#6ed0d0d0"
                sprite: dustTexture
                maxAmount: 500
                fadeOutDuration: 1500
                fadeInDuration: 1500
                VectorDirection3D {
                    id: dustDirection
                    directionVariation.z: 2
                    directionVariation.y: 2
                    directionVariation.x: 2
                    direction.z: 0
                    direction.y: 2
                }

                Texture {
                    id: dustTexture
                    source: "sphere.png"
                }
                billboard: true
            }
        }

        ParticleShape3D {
            id: dustShape
            extents.z: 1500
            extents.y: 1200
            extents.x: 1500
        }

        Wander3D {
            id: dustWander
            uniquePaceVariation: 0.5
            uniquePace.z: 0.05
            uniquePace.y: 0.05
            uniquePace.x: 0.05
            uniqueAmountVariation: 0.5
            uniqueAmount.z: 100
            uniqueAmount.y: 100
            uniqueAmount.x: 100
            system: dust
            particles: dustParticle
        }
    }
    // Animations:
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:31;cameraSpeed3dMultiplier:1;matPrevColorDoc:"#716666";matPrevEnvDoc:"SkyBox";matPrevEnvValueDoc:"preview_studio";matPrevModelDoc:"#Sphere"}
}
##^##*/
