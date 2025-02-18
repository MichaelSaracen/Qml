QT += quick sql

SOURCES += \
        cpp/database.cpp \
        cpp/server.cpp \
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

DISTFILES +=

DEFINES += DATABASE_PATH=\\\"$$PWD/db/kino.db\\\"
DEFINES += SERVER_PATH=\\\"$$PWD/server/server.js\\\"

HEADERS += \
    cpp/database.h \
    cpp/server.h
