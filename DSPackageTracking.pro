APP_NAME = DSPackageTracking

CONFIG += qt warn_on cascades10
QT += network
LIBS += -lbbcascadespickers -lbbsystem -lbbdevice

include(build/build.pri)
include(config.pri)