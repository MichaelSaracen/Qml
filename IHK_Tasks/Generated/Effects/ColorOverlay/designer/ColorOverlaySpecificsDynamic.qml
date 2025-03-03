
// Created with Qt Design Studio (version 4.7.0), Mon Mar 3 06:01:50 2025
// Do not manually edit this file, it will be overwritten if effect is modified in Qt Design Studio.

import QtQuick
import QtQuick.Layouts
import HelperWidgets
import StudioTheme as StudioTheme

Column {

    Section {
        caption: "Color Overlay"
        width: parent.width

        SectionLayout {

            PropertyLabel {
                text: "Color"
                tooltip: "This property defines the color value which is used to colorize the source.\n\nBy default, the property is set to \c \"transparent\"."
            }

            SecondColumnLayout {

                ColorEditor {
                    backendValue: backendValues.colorOverlayColor
                    supportGradient: false
                }

                ExpandingSpacer {}
            }
        }
    }
}
