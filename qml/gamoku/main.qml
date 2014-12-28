import QtQuick 2.0

Rectangle {
    id: canvas

    property int cellDimension: 19
    property real canvasSmallerSize: width < height? width: height
    property real cellSize: canvasSmallerSize / cellDimension

    width: 600
    height: 600
    color: "lightblue"

    Rectangle {
        id: fieldCanvas

        width: fakeGrid.width
        height: fakeGrid.height
        color: "sandybrown"
        anchors.centerIn: canvas

        Rectangle {
            width: fakeGrid.width - cellSize
            height: fakeGrid.height - cellSize
            color: "transparent"
            anchors.centerIn: fieldCanvas

            Grid {
                id: cellGrid
                rows: cellDimension - 1
                columns: cellDimension - 1

                Repeater {
                    model: (cellDimension - 1) * (cellDimension - 1)
                    delegate: cellField
                }
            }
        }

        Grid {
            id: fakeGrid
            rows: cellDimension
            columns: cellDimension

            Repeater {
                model: cellDimension * cellDimension
                delegate: cellFake
            }
        }
    }

    Component {
        id: cellField

        Rectangle {
            width: cellSize
            height: cellSize
            color: "transparent"
            border.color: "darkgreen"
            border.width: 1
        }
    }

    Component {
        id: cellFake

        Rectangle {
            width: cellSize
            height: cellSize
            color: "transparent"

            Stone {
                id: gameStone

                width: parent.width * 3/4
                anchors.centerIn: parent
                visible: false
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    gameStone.whichIs = 1
                    gameStone.visible = true
                }
            }
        }
    }
}
