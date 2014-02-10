TEMPLATE = app

INCLUDEPATH += "C:/opencv/build/include"

QT += core gui widgets quick


HEADERS =

SOURCES = \
    main.cpp

# x86 VS2012 -> vc11/lib
#LIBS += -L"C:/opencv/build/x86/vc11/lib"

# x64 VS2012 -> vc11/lib
LIBS += -L"C:/opencv/build/x64/vc11/lib"

LIBS += \
    -lopencv_core248 \
    -lopencv_highgui248 \
    -lopencv_imgproc248

OTHER_FILES += \
    ../qml/MainView.qml \
    ../qml/FolderView.qml \
    ../qml/PhotoView.qml


