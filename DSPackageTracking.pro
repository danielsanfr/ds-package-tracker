APP_NAME = DSPackageTracking

CONFIG += qt warn_on cascades10
QT += network
LIBS += -lbbcascadespickers -lbbsystem -lbbdevice -lbbplatform -lbbmultimedia -lbbcascadesadvertisement
#LIBS += -libbbmsp -libbbplatformbbm -libbbplatform -libbps

include(build/build.pri)
include(config.pri)