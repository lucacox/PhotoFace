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
            currentFolder: pictures_folder
        }
        // main view
        Item {
            Layout.fillWidth: true
            PhotoListView {
                id: photo_list
                anchors.fill: parent
                visible: true
                enabled: visible
                folder: folderView.currentFolder
                onFolderChanged: {
                    console.log(folder);
                }

                onShowPhoto: {
                    photo_list.visible = false;
                    photo_view.visible = true;
                    photo_view.image = file_path;

//                    console.log("stting file: " + file_path);
//                    recognizer.photoPath = file_path;
//                    photo_view.rectangles = recognizer.detectFaces();
                }
            }
            PhotoView {
                id: photo_view
                anchors.fill: parent
                visible: false
                enabled: visible

                onClose: {
                    photo_view.visible = false;
                    photo_view.image = "";
                    photo_list.visible = true;
                }
            }
        }

        Item {
            Layout.minimumWidth: 200
            FacePanel {
                id: facepanel
                anchors.fill: parent
                filename: photo_list.selectedFile

            }
        }
    }

    statusBar: StatusBar {

    }
}
