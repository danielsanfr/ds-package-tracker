/*
 * ActiveFrame.h
 *
 *  Created on: Apr 2, 2013
 *      Author: wbarichak
 */

#ifndef ACTIVEFRAMEQML_H_
#define ACTIVEFRAMEQML_H_

#include <QObject>
#include <bb/cascades/SceneCover>

class ActiveFrameQML: public bb::cascades::SceneCover {
    Q_OBJECT

public:
    ActiveFrameQML(QObject *parent=0);

public slots:

private:
};

#endif /* ACTIVEFRAMEQML_H_ */
