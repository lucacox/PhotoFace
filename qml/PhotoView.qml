import QtQuick 2.0

Item {
    id: photo_view

    property alias image: img.source
    property variant rectangles: []

    signal close()

    Rectangle {
        anchors.fill: parent
        color: "#DDD"
    }

    Image {
        id: img
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit

        Canvas {
            id: canvas
            anchors.centerIn: parent
            height: parent.paintedHeight
            width: parent.paintedWidth

            onPaint: {
                var ctx = canvas.getContext("2d");

                // Store the current transformation matrix
                ctx.save();

                // Use the identity matrix while clearing the canvas
                ctx.setTransform(1, 0, 0, 1, 0, 0);
                ctx.clearRect(0, 0, canvas.width, canvas.height);

                // Restore the transform
                ctx.restore();

                var fx = canvas.width / img.sourceSize.width
                var fy = canvas.height / img.sourceSize.height

                console.log("img size: " + img.sourceSize);
                console.log("canvas size: " + canvas.width, canvas.height);

                console.log("Fx: " + fx);
                console.log("Fy: " + fy);

                ctx.lineWidth = 3;
                ctx.strokeStyle = "#F00";
                for (var i=0; i<rectangles.length; i++) {
                    var rect = rectangles[i].boundingRect;
                    ctx.rect(rect.x * fx, rect.y * fy, rect.width * fx, rect.height * fy);
                    ctx.stroke();
                }


            }
        }

    }

    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        height: 50
        color: "transparent"
        border.width: 1
        border.color: "black"
        width: 50
        Text {
            anchors.fill: parent
            text: "X"
            font.pixelSize: 47
            horizontalAlignment: Text.Center
            verticalAlignment: Text.Center
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    photo_view.close();
                }
            }
        }
    }
}
