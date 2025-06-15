// Config created by loukwn https://github.com/loukwn/dots
// Copyright (C) 2025 loukwn
// A modified copy of https://github.com/Keyitdev/sddm-astronaut-theme
// Distributed under the GPLv3+ License https://www.gnu.org/licenses/gpl-3.0.html

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Column {
    id: inputContainer

    Layout.fillWidth: true

    property ComboBox exposeSession: sessionSelect.exposeSession
    property bool failed

    Item {
        id: errorMessageField

        // change also in selectSession
        height: root.font.pointSize * 2
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: errorMessage

            width: parent.width
            horizontalAlignment: Text.AlignHCenter

            text: failed ? textConstants.loginFailed + "!" : keyboard.capsLock ? textConstants.capslockWarning : null
            font.pointSize: root.font.pointSize * 0.8
            font.italic: true
            color: config.ForegroundWarningColor
            opacity: 0

            states: [
                State {
                    name: "fail"
                    when: failed
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                },
                State {
                    name: "capslock"
                    when: keyboard.capsLock
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 100
                    }
                }
            ]
        }
    }

    Item {
        id: usernameField

        height: root.font.pointSize * 4.5
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        ComboBox {
            id: selectUser

            width: parent.height
            height: parent.height
            anchors.left: parent.left
            z: 2

            model: userModel
            currentIndex: model.lastIndex
            textRole: "name"
            hoverEnabled: true
            onActivated: {
                username.text = currentText
            }

            Keys.onPressed: function(event) {
                if (event.key == Qt.Key_Down && !popup.opened)
                    username.forceActiveFocus();
                if ((event.key == Qt.Key_Up || event.key == Qt.Key_Left) && !popup.opened)
                    popup.open();
                }

            KeyNavigation.down: username
            KeyNavigation.right: username

            delegate: ItemDelegate {
                width: popupHandler.width - 20
                anchors.horizontalCenter: popupHandler.horizontalCenter

                contentItem: Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                    text: model.name
                    font.pointSize: root.font.pointSize * 0.8
                    font.capitalization: Font.AllLowercase
                    font.family: root.font.family
                    color: selectUser.highlightedIndex === index ? config.ForegroundInverseColor : config.ForegroundPrimaryColor
                }

                background: Rectangle {
                  color: selectUser.highlightedIndex === index ? config.SurfaceHighlightColor : "transparent"
                  radius: config.RoundCorners
                }
            }

            indicator: Button {
                id: usernameIcon

                width: selectUser.height * 1
                height: parent.height
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: selectUser.height * 0

                icon.height: parent.height * 0.25
                icon.width: parent.height * 0.25
                enabled: false
                icon.color: config.ForegroundPrimaryColor
                icon.source: Qt.resolvedUrl("../assets/user.svg")

                background: Rectangle {
                    color: "transparent"
                    border.color: "transparent"
                }
            }

            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

            popup: Popup {
                id: popupHandler

                implicitHeight: contentItem.implicitHeight
                width: usernameField.width
                y: parent.height - username.height / 3
                rightMargin: config.RightToLeftLayout == "true" ? root.padding + usernameField.width / 2 : undefined
                padding: 10

                contentItem: ListView {
                    implicitHeight: contentHeight + 20

                    clip: true
                    model: selectUser.popup.visible ? selectUser.delegateModel : null
                    currentIndex: selectUser.highlightedIndex
                    ScrollIndicator.vertical: ScrollIndicator { }
                }

                background: Rectangle {
                    radius: config.RoundCorners
                    color: config.SurfaceLighterColor
                    layer.enabled: true
                }

                enter: Transition {
                    NumberAnimation { property: "opacity"; from: 0; to: 1 }
                }
            }

            states: [
                State {
                    name: "pressed"
                    when: selectUser.down
                    PropertyChanges {
                        target: usernameIcon
                        opacity: 0.3
                    }
                },
                State {
                    name: "hovered"
                    when: selectUser.hovered
                    PropertyChanges {
                        target: usernameIcon
                        opacity: 0.3
                    }
                },
                State {
                    name: "focused"
                    when: selectUser.activeFocus
                    PropertyChanges {
                        target: usernameIcon
                        opacity: 0.3
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "color, border.color, icon.color, opacity"
                        duration: 150
                    }
                }
            ]
        }

        TextField {
            id: username

            anchors.centerIn: parent
            height: root.font.pointSize * 3
            width: parent.width
            horizontalAlignment: TextInput.AlignHCenter
            z: 1

            text: selectUser.currentText
            color: config.ForegroundPrimaryColor
            font.bold: true
            font.capitalization: Font.AllLowercase
            placeholderText: textConstants.userName
            placeholderTextColor: config.ForegroundPlaceholderColor
            selectByMouse: true
            renderType: Text.QtRendering

            onFocusChanged:{
                if(focus)
                    selectAll()
            }

            background: Rectangle {
              color: config.SurfaceLightestColor
                opacity: 0.2
                border.color: "transparent"
                border.width: parent.activeFocus ? 2 : 1
                radius: config.RoundCorners || 0
            }

            onAccepted: sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession)
            KeyNavigation.down: passwordIcon

            states: [
                State {
                    name: "focused"
                    when: username.activeFocus
                    PropertyChanges {
                        target: username.background
                        border.color: config.ForegroundPrimaryColor
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "border.color"
                        duration: 150
                    }
                }
            ]
        }
    }

    Item {
        id: passwordField

        height: root.font.pointSize * 4.5
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter

        Button {
            id: passwordIcon

            height: parent.height
            width: selectUser.height * 1
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            z: 2

            icon.height: parent.height * 0.25
            icon.width: parent.height * 0.25
            icon.color: config.ForegroundPrimaryColor
            icon.source: Qt.resolvedUrl("../assets/password2.svg")

            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

            states: [
                State {
                    name: "passwordFocusedAndChecked"
                    when: (passwordIcon.hovered || passwordIcon.activeFocus) && passwordIcon.checked
                    PropertyChanges {
                        target: passwordIcon
                        opacity: 0.3
                        icon.source: Qt.resolvedUrl("../assets/password.svg")
                    }
                },
                State {
                    name: "passwordFocusedAndUnchecked"
                    when: (passwordIcon.hovered || passwordIcon.activeFocus) && !passwordIcon.checked
                    PropertyChanges {
                        target: passwordIcon
                        opacity: 0.3
                        icon.source: Qt.resolvedUrl("../assets/password2.svg")
                    }
                },
                State {
                    name: "passwordCheckedGeneralCase"
                    when: passwordIcon.checked 
                    PropertyChanges {
                        target: passwordIcon
                        opacity: 1
                        icon.source: Qt.resolvedUrl("../assets/password.svg")
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 150
                    }
                }
            ]

            onClicked: {
              toggle()
              password.focus = true
            }
            Keys.onReturnPressed: {
              toggle()
              password.focus = true
            }
            Keys.onEnterPressed: {
              toggle()
              password.focus = true
            }

            KeyNavigation.down: password
        }

        TextField {
            id: password

            height: root.font.pointSize * 3
            width: parent.width
            anchors.centerIn: parent
            horizontalAlignment: TextInput.AlignHCenter

            font.bold: true
            color: config.ForegroundPrimaryColor
            focus: true
            echoMode: passwordIcon.checked ? TextInput.Normal : TextInput.Password
            placeholderText: config.TranslatePlaceholderPassword || textConstants.password
            placeholderTextColor: config.ForegroundPlaceholderColor
            passwordCharacter: "•"
            passwordMaskDelay: undefined
            renderType: Text.QtRendering
            selectByMouse: true

            background: Rectangle {
                color: config.SurfaceLightestColor
                opacity: 0.2
                border.color: "transparent"
                border.width: parent.activeFocus ? 2 : 1
                radius: config.RoundCorners || 0
            }
            onAccepted: sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession)
            KeyNavigation.down: loginButton.enabled ? loginButton : systemButtons.children[0]
        }

        states: [
            State {
                name: "focused"
                when: password.activeFocus
                PropertyChanges {
                    target: password.background
                    border.color: config.ForegroundPrimaryColor
                }
            }
        ]
        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "border.color"
                    duration: 150
                }
            }
        ]
    }

    Item {
        id: login

        // important
        // try 4 or 9 ...
        height: root.font.pointSize * 9
        width: parent.width / 2
        anchors.horizontalCenter: parent.horizontalCenter


        Button {
            id: loginButton

            height: root.font.pointSize * 3
            implicitWidth: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            text: config.TranslateLogin || textConstants.login
            enabled: username.text != "" && password.text != "" ? true : false
            hoverEnabled: true

            contentItem: Text {
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.bold: true
                font.pointSize: root.font.pointSize
                font.family: root.font.family
                color: config.ForegroundInverseColor
                text: parent.text
                opacity: 0.5
            }

            background: Rectangle {
                id: buttonBackground

                color: config.SurfaceInverseColor
                opacity: 0.2
                radius: config.RoundCorners
            }

            states: [
                State {
                    name: "pressed"
                    when: loginButton.down && loginButton.enabled
                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.darker(config.SurfaceInverseColor, 1.1)
                        opacity: 1
                    }
                    PropertyChanges {
                        target: loginButton.contentItem
                    }
                },
                State {
                    name: "hovered"
                    when: loginButton.hovered && loginButton.enabled
                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.lighter(config.SurfaceInverseColor, 1.15)
                        opacity: 1
                    }
                    PropertyChanges {
                        target: loginButton.contentItem
                        opacity: 1
                    }
                },
                State {
                    name: "enabled"
                    when: loginButton.enabled
                    PropertyChanges {
                        target: buttonBackground;
                        color: config.SurfaceInverseColor;
                        opacity: 1
                    }
                    PropertyChanges {
                        target: loginButton.contentItem;
                        opacity: 1
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity, color";
                        duration: 300
                    }
                }
            ]

            onClicked: sddm.login(username.text.toLowerCase(), password.text, sessionSelect.selectedSession)
            Keys.onReturnPressed: clicked()
            Keys.onEnterPressed: clicked()
            KeyNavigation.down: systemButtons.children[0]
        }
    }

    Connections {
        target: sddm
        function onLoginSucceeded() {}
        function onLoginFailed() {
            failed = true
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}
