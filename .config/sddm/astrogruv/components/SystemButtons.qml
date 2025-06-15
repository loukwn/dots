// Config created by loukwn https://github.com/loukwn/dots
// Copyright (C) 2025 loukwn
// A modified copy of https://github.com/Keyitdev/sddm-astronaut-theme
// Distributed under the GPLv3+ License https://www.gnu.org/licenses/gpl-3.0.html

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {

    spacing: root.font.pointSize

    property var shutdown: ["Shutdown", "shutdown", sddm.canPowerOff]
    property var reboot: ["Reboot", "reboot", sddm.canReboot]

    property ComboBox exposedSession

    Repeater {
        id: systemButtons

        model: [shutdown, reboot]

        RoundButton {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.topMargin: root.font.pointSize * 6.5

            text: modelData[0]
            font.pointSize: root.font.pointSize * 0.8
            icon.source: modelData ? Qt.resolvedUrl("../assets/" + modelData[1] + ".svg") : ""
            icon.height: 2 * Math.round((root.font.pointSize * 3) / 2)
            icon.width: 2 * Math.round((root.font.pointSize * 3) / 2)
            icon.color: config.ForegroundPrimaryColor
            palette.buttonText: config.ForegroundPrimaryColor
            display: AbstractButton.TextUnderIcon
            visible: modelData[2]
            hoverEnabled: true

            background: Rectangle {
                height: 2
                width: parent.width

                color: "transparent"
            }

            Keys.onReturnPressed: clicked()
            onClicked: {
                parent.forceActiveFocus()
                index == 0 ? sddm.powerOff() : sddm.reboot()
            }
            KeyNavigation.left: index > 0 ? parent.children[index-1] : null

            states: [
                State {
                    name: "pressed"
                    when: parent.children[index].down
                    PropertyChanges {
                        target: parent.children[index]
                        opacity: 0.3
                    }
                },
                State {
                    name: "hovered"
                    when: parent.children[index].hovered
                    PropertyChanges {
                        target: parent.children[index]
                        opacity: 0.3
                    }
                },
                State {
                    name: "focused"
                    when: parent.children[index].activeFocus
                    PropertyChanges {
                        target: parent.children[index]
                        opacity: 0.3
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "palette.buttonText, opacity"
                        duration: 150
                    }
                }
            ]
        }
    }
}
