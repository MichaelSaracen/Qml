import QtQuick
import QtQuick3D

Node {
    id: node


    // Resources

    // Nodes:

    Model {
        id: landscape_003
        objectName: "Landscape.003"
        z: -110.13605499267578
        rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
        scale.x: 31079.5
        scale.y: 31079.5
        scale.z: 31079.5
        source: "meshes/landscape_004_mesh.mesh"
        materials: defaultMaterial_material
    }


    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: defaultMaterial_material
            //emissiveFactor.z: 1
            //emissiveFactor.x: 1
            //emissiveFactor.y: 1.0316
            objectName: "DefaultMaterial"
            baseColor: "#21252b"
        }
    }

    // Animations:
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:31;cameraSpeed3dMultiplier:1;matPrevEnvDoc:"SkyBox";matPrevEnvValueDoc:"preview_studio";matPrevModelDoc:"#Sphere"}
}
##^##*/
