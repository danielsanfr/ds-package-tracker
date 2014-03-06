/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <bb/cascades/Application>

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
    Settings settings;
    // use "theme" key for property showing what theme to use on application start
    return settings.getValueFor(value, "bright");
}

Q_DECL_EXPORT int main(int argc, char **argv) {
	// update env variable before an application instance created
	qputenv("CASCADES_THEME", getValue("theme").toUtf8());

	Application app(argc, argv);
	// Show console debug
	qInstallMsgHandler(myMessageOutput);

    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    new ApplicationUI(&app);

    // Enter the application main event loop.
    return Application::exec();
}
