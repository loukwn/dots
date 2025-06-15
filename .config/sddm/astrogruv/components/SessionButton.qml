// Config created by loukwn https://github.com/loukwn/dots
// Copyright (C) 2025 loukwn
// A modified copy of https://github.com/Keyitdev/sddm-astronaut-theme
// Distributed under the GPLv3+ License https://www.gnu.org/licenses/gpl-3.0.html

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Column {
    id: sessionContainer

    Layout.fillWidth: true
    property ComboBox exposeSession: selectSession
    property var selectedSession: selectSession.currentIndex

    Item {
      id: sessionButton

      height: root.font.pointSize * 4.5
      width: parent.width / 2
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottom: parent.bottom


     property string textConstantSession
      property int loginButtonWidth


      ComboBox {
          id: selectSession

          width: parent.width
          height: parent.height
          anchors.left: parent.left
          z: 2

          model: sessionModel
          currentIndex: model.lastIndex
          textRole: "name"
          hoverEnabled: true

          Keys.onPressed: function(event) {
              if ((event.key == Qt.Key_Left || event.key == Qt.Key_Right) && !popup.opened) {
                  popup.open();
              }
          }

          delegate: ItemDelegate {
              width: popupHandler.width - 20
              anchors.horizontalCenter: popupHandler.horizontalCenter

              contentItem: Text {
                  verticalAlignment: Text.AlignVCenter
                  horizontalAlignment: Text.AlignHCenter

                  text: model.name
                  font.pointSize: root.font.pointSize * 0.8
                  font.family: root.font.family
                  color: selectSession.highlightedIndex === index ? config.ForegroundInverseColor : config.ForegroundPrimaryColor
              }

              background: Rectangle {
                  color:  selectSession.highlightedIndex === index ? config.SurfaceHighlightColor : "transparent"
                  radius: config.RoundCorners
              }
          }

          indicator {
              visible: false
          }

          contentItem: Text {
              id: displayedItem

              verticalAlignment: Text.AlignVCenter
              horizontalAlignment: Text.AlignHCenter

              text: "Session" + " (" + selectSession.currentText + ")"
              color: config.ForegroundPrimaryColor
              font.pointSize: root.font.pointSize * 0.8
              font.family: root.font.family

              Keys.onReleased: parent.popup.open()
          }

          background: Rectangle {
              height: parent.height
              width: parent.width

              color: "transparent"
          }

          popup: Popup {
              id: popupHandler

              implicitHeight: contentItem.implicitHeight
              width: sessionButton.width
              y: sessionButton.height/2 + root.font.pointSize
              x:  -popupHandler.width/2 + displayedItem.width/2
              padding: 10

              contentItem: ListView {
                  implicitHeight: contentHeight + 20

                  clip: true
                  model: selectSession.popup.visible ? selectSession.delegateModel : null
                  currentIndex: selectSession.highlightedIndex
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
                  when: selectSession.down || selectSession.hovered || selectSession.visualFocus
                  PropertyChanges {
                      target: displayedItem
                      opacity: 0.3
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

        }
    }
}
