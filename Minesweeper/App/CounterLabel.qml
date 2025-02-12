import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ColumnLayout {
    id: columnLayout

    property int count: 0
    property string name: "Title"

    Label {
        id: totalPoints
        text: parseInt( count )
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        font.pointSize: 32
    }
    
    Label {
        id: label
        text: name
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        font.pointSize: 9
    }
}
