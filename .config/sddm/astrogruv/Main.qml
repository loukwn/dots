// Config created by loukwn https://github.com/loukwn/dots
// Copyright (C) 2025 loukwn
// A modified copy of https://github.com/Keyitdev/sddm-astronaut-theme
// Distributed under the GPLv3+ License https://www.gnu.org/licenses/gpl-3.0.html

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Effects

import "components"

Pane {
    id: root

    height: Screen.Height
    width: Screen.Width

    palette.window: config.SurfaceLighterColor
    palette.highlight: config.SurfaceHighlightColor
    palette.highlightedText: config.ForegroundOnHighlightColor
    palette.buttonText: config.ForegroundPrimaryColor

    font.family: config.Font
    font.pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80) || 13

    focus: true

    Item {
        id: sizeHelper

        height: parent.height
        width: parent.width
        anchors.fill: parent

        Rectangle {
            id: formBackground

            anchors.fill: form
            anchors.centerIn: form
            z: 1
            color: config.SurfaceColor
        }

        LoginForm {
            id: form

            height: parent.height
            width: parent.width / 2.5
            anchors.left: parent.left
            anchors.horizontalCenter: undefined
            anchors.right: undefined
            z: 1
        }

        Image {
            id: backgroundImage
            height: parent.height
            width:  parent.width
            source: config.BackgroundImage
        }

        MouseArea {
            anchors.fill: backgroundImage
            onClicked: parent.forceActiveFocus()
        }
    }
}
