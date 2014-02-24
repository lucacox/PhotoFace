TEMPLATE = app

INCLUDEPATH += "C:/opencv/build/include"

QT += core gui widgets quick


HEADERS = \
    face_recon/FaceRecon.h \
    face_recon/Face.h

SOURCES = \
    main.cpp \
    face_recon/FaceRecon.cpp \
    face_recon/Face.cpp

# x86 VS2012 -> vc11/lib
#LIBS += -L"C:/opencv/build/x86/vc11/lib"

# x64 VS2012 -> vc11/lib
LIBS += -L"C:/opencv/build/x64/vc11/lib"

contains(CONFIG, debug) {
message("linking against DEBUG opencv")
    LIBS += \
        -lopencv_core248d \
        -lopencv_highgui248d \
        -lopencv_imgproc248d \
        -lopencv_objdetect248d
} else {
message("linking against RELEASE opencv")
    LIBS += \
        -lopencv_core248 \
        -lopencv_highgui248 \
        -lopencv_imgproc248 \
        -lopencv_objdetect248
}

OTHER_FILES += \
    ../qml/MainView.qml \
    ../qml/FolderView.qml \
    ../qml/PhotoListView.qml \
    ../qml/PhotoView.qml \
    ../qml/FacePanel.qml


