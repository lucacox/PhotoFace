import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

ApplicationWindow {
    id: mainApp
    title: "PhotoFace"

    menuBar: MenuBar {
        Menu {
            title: qsTr("File");
            MenuItem {
                text: qsTr("Open")
                shortcut: "Ctrl+O"
                onTriggered: function() {
                    console.log("NOT IMPLEMENTED");
                }
            }
            MenuItem {
                text: qsTr("Close")
                shortcut: "Ctrl+Q"
                onTriggered: mainApp.close()
            }
        }
    }

    toolBar: ToolBar {

    }

    SplitView {
        id: splitView1

        orientation: Qt.Horizontal
        anchors.fill: parent

        // file tree view
        FolderView {
            id: folderView
            Layout.minimumWidth: 200
            currentFolder: "/Users/Luca/Pictures/"
            onCurrentFolderChanged: {
                console.log(currentFolder);
            }
        }
        // main view
        PhotoView {
            Layout.fillWidth: true
            folder: folderView.currentFolder
        }
        // detail panes
        Rectangle {
            color: "green"
            Layout.minimumWidth: 200
        }
    }

    statusBar: StatusBar {

    }
}
