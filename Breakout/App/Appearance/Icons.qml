/*!
    Alle Icons sind von Google - Material Icons:
    https://fonts.google.com/icons
*/

pragma Singleton
import QtQuick



QtObject {
    property url collapseContent: "qrc:/assets/icons/collapse_content.png"
    property url expandContent: "qrc:/assets/icons/expand_content.png"
    property url colorMode: Theme.darkmode ? "qrc:/assets/icons/lightMode.png" : "qrc:/assets/icons/darkMode.png"
    property url play: "qrc:/assets/icons/play.png"
    property url stop: "qrc:/assets/icons/stop.png"
    property url fav: "qrc:/assets/icons/fav.png"
    property url medal: "qrc:/assets/icons/medal.png"
    //property url expandContent: "qrc:/assets/icons/expand_content.png"
}
