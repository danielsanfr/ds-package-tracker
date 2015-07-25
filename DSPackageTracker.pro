APP_NAME = DSPackageTracker

CONFIG += qt warn_on cascades10
QT += network
LIBS += -lbbcascadespickers -lbbsystem -lbbdevice -lbbplatform -lbbmultimedia -lbbdata -lbb

include(build/build.pri)
include(config.pri)