import QtQuick 2.0
import Qt.labs.folderlistmodel 2.1

Item {
    id: folderView
    property alias currentFolder: folderModel.folder

    FolderListModel {
        id: folderModel

        folder: "/Users/Luca/Documents/"
        showDirs: true
        showDotAndDotDot: true
        showFiles: false
        nameFilters: ["*.*"]
    }

    Rectangle {
        id: folderName
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        height: 30
        border.color: "black"

        Text {
            anchors.centerIn: parent
            text: currentFolder
        }
    }

    ListView {
        id: folderListView

        anchors.top: folderName.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Component {
            id: folderDelegate
            Rectangle {
                height: 30
                width: folderView.width
                color: "#EEE"
                border.color: "#DDD"
                Text {
                    anchors.centerIn: parent
                    text: getPath(filePath)
                }
                MouseArea {
                    anchors.fill: parent
                    onDoubleClicked: {
                        folderModel.folder = filePath;
                        currentFolder = filePath;

                    }
                }
                function getPath(full_path) {
                    var path = filePath;
                    var idx = path.indexOf("/");
                    var lastIdx = -1;
                    while (idx <= path.lastIndexOf("/") && idx !== -1) {
                        lastIdx = idx;
                        idx = path.indexOf("/", idx+1);
                    }
                    return path.substring(lastIdx+1);
                }
            }
        }
        delegate: folderDelegate
        model: folderModel
    }
}
