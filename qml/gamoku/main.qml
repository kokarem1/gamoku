import QtQuick 2.0

Rectangle {
    id: canvas

    property int cellDimension: 19
    property real canvasSmallerSize: width < height? width: height
    property real cellSize: canvasSmallerSize / cellDimension

    width: 600
    height: 600
    color: "lightblue"
    focus: true

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
                model: listModel
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
                visible: lM_visible
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    gameStone.whichIs = lM_whichIs
                    gameStone.visible = true
                }
            }
        }
    }

    Keys.onPressed: {
        var newGameKeys = event.key === Qt.Key_N

        if (newGameKeys)
            initNewGame()
    }

    ListModel { id: listModel }

    Component.onCompleted: {
        fill_lM()
    }

    function fill_lM()
    {
        listModel.clear()
        for (var i = 0; i < cellDimension * cellDimension; ++i)
            listModel.append( { lM_visible: false, lM_whichIs: 0 } )
    }

    function fieldIndex(rowI, colI)
    {
        return rowI * cellDimension + colI
    }

    function initNewGame()
    {
        listModel.clear()
        fill_lM()
    }
}
