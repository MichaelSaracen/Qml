import QtQuick 2.15
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Effects

import App.Appearance


import QtQuick.Controls 2.15

ListView {
    id: listAddQandA
    spacing: 2
    model: lmSubjects
    delegate: EditSubjectDelegate { }
}
