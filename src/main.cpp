/****************************************************************************
 *
 * Copyright (c) 2014-2015 Daniel San, All rights reserved.
 *
 *    Contact: daniel.samrocha@gmail.com
 *       File: main.cpp
 *     Author: daniel
 * Created on:
 *    Version:
 *
 * This file is part of the DS Package Tracker.
 *
 * DS Package Tracker is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 3 of the
 * License, or (at your option) any later version.
 *
 * DS Package Tracker is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with DS Package Tracker. If not, see <http://www.gnu.org/licenses/>.
 *
 ***************************************************************************/

#include <bb/cascades/Application>

#include <QDebug>
#include <QString>
#include <QLocale>
#include <QTranslator>
#include <Qt/qdeclarativedebug.h>

#include "Settings.hpp"
#include "applicationui.hpp"

using namespace bb::cascades;

void myMessageOutput(QtMsgType type, const char* msg){
	Q_UNUSED(type);
    fprintf(stdout, "%s\n", msg);
    fflush(stdout);
}

QString getValue(QString value) {
	Settings *settings = Settings::getInstance();
    // use "theme" key for property showing what theme to use on application start
	QString result = settings->getValueFor(value, "").toString();
	return result;
}

Q_DECL_EXPORT int main(int argc, char **argv) {
	// update env variable before an application instance created
	QString selectedTheme = getValue("theme");
	if (selectedTheme != "")
		qputenv("CASCADES_THEME", selectedTheme.toUtf8());

	Application app(argc, argv);
	// Show console debug
	qInstallMsgHandler(myMessageOutput);

    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    new ApplicationUI(&app);

    // Enter the application main event loop.
    return Application::exec();
}
