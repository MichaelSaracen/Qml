#ifndef BALL_H
#define BALL_H

#include "abstractshape.h"
#include "targetfield.h"


class Field;
class Ball: public AbstractShape {
public:
    Ball( Field *parent, int x, int y, int width, int height );
    ~Ball();

    bool canMove(QList<TargetField *> &targets );
    bool collidesWithTarget( QList<TargetField *> &targets );
    bool collidesWithPaddel( );
    bool collidesWithCorner( );
    bool collidesWithLeftSide( );
    bool collidesWithRightSide( );

    qreal getSpeed() const;

private:
    Field *m_parent;
    qreal dx;
    qreal dy;
    qreal speed;
    int m_count;
};





#endif // BALL_H
