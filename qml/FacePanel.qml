import QtQuick 2.0
import QtQuick.Controls 1.1

Item {
    id:  face_panel
    anchors.fill: parent

    property string filename: ""

    Item {
        id: image_details
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 400
        anchors.margins: {
            left: 10
            right: 10
        }

        Text {
            id: file_name
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottomMargin: 35
            height: 26
            font.pixelSize: 25
            horizontalAlignment: Text.Center
            text: filename.substring(filename.lastIndexOf("/")+1);
        }
        Text {
            id: file_size
            anchors.top: file_name.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottomMargin: 15
            text: "Size: 827181 bytes"
            font.pixelSize: 20
            height: 21
        }
        Text {
            id: date_taken
            anchors.top: file_size.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            text: "Date taken: 12/02/2014"
            font.pixelSize: 20
            height: 21
        }
    }

    Button {
        id: detect_btn
        anchors.top: image_details.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        height: 60

        text: qsTr("Find Faces")
    }
}
