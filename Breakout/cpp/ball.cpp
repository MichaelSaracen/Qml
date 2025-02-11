#include "ball.h"
#include "field.h"


Ball::Ball(Field *parent, int x, int y, int width, int height)
    : AbstractShape( x, y, width, height ), m_parent(parent)
{
    dx = 4;
    dy = 4;
    speed = 0;
    m_count = 0;
}

Ball::~Ball() { qDebug() << "Ball - dtor - Ball removed"; }


/**
 * @brief Ball::move
 * Bwegegt den Ball in verschiedene Richtungen, bei Kollisionen findet ein Richtungswechsel statt,
 * @param targets
 */
bool Ball::canMove(QList<TargetField *> &targets)
{
    // [!] --- false zurückgeben, wenn keine Targets mehr da sind
    if ( !m_parent && targets.isEmpty() ) return false;

    QRect r = rect();

    int newX = r.x() + dx;
    int maxX = m_parent->width() - r.width();
    int newY = r.y() + dy;
    int maxY = m_parent->height() - r.height();

    // [!] --- Spielfeld links und rechts
    if ( newX < 0  || newX > maxX ) {
        dx = -dx;
        newX = r.x() + dx;
    }

    // [!] --- obere Seite
    if ( newY < 0 ) {
        dy = -dy;
        newY = r.top() + dy;
    }

    // [!] --- Obere Seite des Paddels
    if ( collidesWithPaddel() ) {
        qDebug() << "collidesWithPaddel";
        dy = -dy;
        newY = r.top() + dy;
    }
    // [!] --- Kantencheck
    else if (collidesWithCorner() ) {
        qDebug() << "collidesWithCorner";
        dy = -dy;
        dx = -dx;
        newX = r.x() + dx;
        newY = r.top() + dy;
    }

    // [! --- Linke Seite des Padels
    else if ( collidesWithLeftSide() ) {
        qDebug() << "collidesWithSides";
        dx = -dx;
        newX = r.x() + dx;
        newY = r.top() - dy;
    }
    // [!] --- Rechte Seite des Paddels
    else if ( collidesWithRightSide() ) {
        qDebug() << "collidesWithRightSide";
        dx = -dx;
        newX = r.x() + dx;
        newY = r.top() - dy;
    }

    // [!] --- Target Kollisionen
    if ( collidesWithTarget(targets)) {
        dy = -dy;
        newY = r.top() + dy;
        m_count++;
        // [! --- m_count wird in collidesWithTarget hoch gezählt.
        if ( targets.length() % 10 == 0 && m_count > 0 ) {
            m_parent->setMedals(m_parent->medals() + 1);
            qDebug() << "Medals: " << m_parent->medals();
        }
    }

    // [!] --- Springt solange noch Leben vorhanden sind wieder hoch.
    if ( newY > maxY && m_parent->lifes() > 0) {
        dy = -dy;
        newY = r.top() + dy;
        m_parent->setLifes(m_parent->lifes() - 1);
        qDebug() << "Lifes: " << m_parent->lifes();
    }

    r.moveLeft( newX );
    r.moveTop( newY );
    setRect( r );



    return m_parent->lifes() > 0;
}


/**
 * @brief Ball::collidesWithTarget
 * Kollisionen mit den Feldern überprüfen
 * @param targets
 * @return
 */
bool Ball::collidesWithTarget(QList<TargetField*> &targets)
{
    if ( targets.isEmpty() ) return false;

    QRect ballRect = rect();

    bool collisionDetected = false;

    auto it = std::remove_if(targets.begin(), targets.end(),
                             [&](TargetField *target) {
                                 if ( ballRect.intersects( target->rect() )) {
                                     qDebug() << "Collision with TargetField";
                                     m_parent->addScorePoints( target->scorePoint() );
                                     speed += target->scorePoint() * 0.01;
                                     emit m_parent->totalScoreChanged();
                                     collisionDetected = true;

                                     delete target;
                                     return true;
                                 }
                                 return false;
                             } );
    targets.erase( it, targets.end() );

    return collisionDetected;
}

/**
 * @brief Ball::collidesWithCorner
 * Eckenkollisionen überprüfen
 * @return
 */
bool Ball::collidesWithCorner()
{
    if ( !m_parent->paddel() ) return false;
    QRect ballRect = rect();
    QRect padelRect = m_parent->paddel()->rect();

    QPoint ballBottomRight = ballRect.bottomRight();
    QPoint ballBottomLeft = ballRect.bottomLeft();
    QPoint padelTopLeft = padelRect.topLeft();
    QPoint padelTopRight = padelRect.topRight();

    int tolerance = 5; // Erlaubt eine kleine Ungenauigkeit

    bool bottomRightHitsTopLeft = (qAbs(ballBottomRight.x() - padelTopLeft.x()) <= tolerance) &&
                                  (qAbs(ballBottomRight.y() - padelTopLeft.y()) <= tolerance);

    bool bottomLeftHitsTopRight = (qAbs(ballBottomLeft.x() - padelTopRight.x()) <= tolerance) &&
                                  (qAbs(ballBottomLeft.y() - padelTopRight.y()) <= tolerance);

    return bottomRightHitsTopLeft || bottomLeftHitsTopRight;
}

/**
 * @brief Ball::collidesWithLeftSide
 * Überprüft, ob der Ball die Linke Seite des Paddels berührt
 * @return
 */
bool Ball::collidesWithLeftSide()
{
    if ( !m_parent->paddel() ) return false;

    QRect padelRect         = m_parent->paddel()->rect();
    QRect ballRect          = rect();

    bool verticalOverlap    = ballRect.bottom() >= padelRect.top() && ballRect.top() <= padelRect.bottom();
    bool hitsLeft           = ballRect.right() >= padelRect.left() && ballRect.left() < padelRect.left();

    return verticalOverlap && hitsLeft;
}


/**
 * @brief Ball::collidesWithRightSide
 * Überprüft, ob der Ball die Rechte Seiter des Paddels brührt.
 * @return
 */
bool Ball::collidesWithRightSide()
{
    if ( !m_parent->paddel() ) return false;

    QRect padelRect         = m_parent->paddel()->rect();
    QRect ballRect          = rect();

    bool verticalOverlap    = ballRect.bottom() >= padelRect.top() && ballRect.top() <= padelRect.bottom();
    bool hitsRight          = ballRect.left() <= padelRect.right() && ballRect.right() > padelRect.right();

    return verticalOverlap && hitsRight;
}

qreal Ball::getSpeed() const
{
    return speed;
}



/**
 * @brief Ball::collidesWithPaddel
 * Überprüfen ob der Ball mit dem Paddel kollidiert
 * @return
 */
bool Ball::collidesWithPaddel()
{
    if ( !m_parent->paddel() ) return false;
    //return rect().intersects( m_parent->paddel()->rect() );
    return  m_parent->paddel()->rect().contains(rect().bottomLeft()) || m_parent->paddel()->rect().contains(rect().bottomRight());
}

















// QPoint padelTopLeft = padelRect.topLeft();
// QPoint padelTopRight = padelRect.topRight();

// int tolerance = 5;

// bool bottomRightHitsTopLeft = (qAbs(ballBottomRight.x() - padelTopLeft.x()) <= tolerance) &&
//                               (qAbs(ballBottomRight.y() - padelTopLeft.y()) <= tolerance);

// bool bottomLeftHitsTopRight = (qAbs(ballBottomLeft.x() - padelTopRight.x()) <= tolerance) &&
//                               (qAbs(ballBottomLeft.y() - padelTopRight.y()) <= tolerance);

// return bottomRightHitsTopLeft || bottomLeftHitsTopRight;
