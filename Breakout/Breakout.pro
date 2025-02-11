QT += quick

SOURCES += \
        cpp/ball.cpp \
        cpp/field.cpp \
        main.cpp


RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += "."

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    Breakout.qmlproject \
    docs/TODO.md

HEADERS += \
    cpp/abstractshape.h \
    cpp/ball.h \
    cpp/field.h \
    cpp/paddel.h \
    cpp/targetfield.h
