#ifndef PADDEL_H
#define PADDEL_H

#include "abstractshape.h"

class Paddel : public AbstractShape {

public:
    Paddel(QQuickPaintedItem *parent, int x, int y, int width, int height);
    ~Paddel();

    void moveBy( int x );

private:
    QQuickPaintedItem *m_parent;
};

inline Paddel::Paddel(QQuickPaintedItem *parent, int x, int y, int width, int height)
    : AbstractShape( x, y, width, height ),
    m_parent(parent)
{
    setColor(QColor(255, 97, 96));
}

inline Paddel::~Paddel() { qDebug() << "Paddel - dtor - Paddel released"; }


/**
 * @brief Paddel::moveBy
 * Beweget das Padel auf der X - Koordinate
 * @param x
 */
inline void Paddel::moveBy(int x)
{
    if ( !m_parent ) return;

    QRect r = rect();
    int newX = r.x() + x;
    int maxX = m_parent->width() - r.width();

    if ( newX < 0) newX = 0;
    if ( newX > maxX ) newX = maxX;

    r.moveLeft ( newX );
    setRect(r);
}

#endif // PADDEL_H
