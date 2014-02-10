import QtQuick 2.0
import Qt.labs.folderlistmodel 2.0

Item {
    id: photo_view
    property alias folder: imageModel.folder

    FolderListModel {
        id: imageModel
        nameFilters: ["*.jpg", "*.JPG", "*.png"]
        showDotAndDotDot: false
        showDirs: false
    }

    Component {
        id: imageDelegate
        Item {
            width: photo_grid.cellWidth
            height: photo_grid.cellHeight
            Rectangle {
                anchors.fill: parent
                color: photo_grid.currentIndex === index ? "steelblue" : "transparent"

                Image {
                    id: img
                    source: filePath
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: {
                        top: 5
                        bottom: 5
                        left: 5
                        right: 5
                    }
                    asynchronous: true
                    height: 200
                }
                Text {
                    anchors.top: img.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    text: fileName
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    photo_grid.currentIndex = index;
                }
            }
        }
    }

    GridView {
        id: photo_grid
        cellHeight: height / 4
        cellWidth: width / 5
        anchors.fill: parent
        delegate: imageDelegate
        model: imageModel
    }
}
