pragma Singleton
import QtQuick

QtObject {
    id: root
    property int width: 1800
    property int height: 1200

    property var genres: ["Action", "Biografie", "Doku", "Horror", "Sci-Fi", "Thriller"]
    property var fsks: ["Keine", "6", "12", "16", "18"]
}
