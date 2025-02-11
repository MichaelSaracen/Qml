#ifndef TARGETFIELD_H
#define TARGETFIELD_H

#include "abstractshape.h"

class TargetField : public AbstractShape {

public:
    TargetField(int x, int y, int width, int height);
    ~TargetField();

    int scorePoint() const;
    void setScorePoint(const QColor &color);

private:
    int m_scorePoint;
};


inline TargetField::TargetField( int x, int y, int width, int height )
    : AbstractShape( x, y, width, height )
{
    setColor(Qt::blue);
    setBorderColor(Qt::black);
}

inline TargetField::~TargetField() {
    // qDebug() << "TargetField - dtor - TargetField destroyed & released";
}



inline int TargetField::scorePoint() const { return m_scorePoint; }
/**
 * @brief TargetField::setScorePoint
 * Hier werden die Scorepunkte anhand der Farben festgelegt. Dafür wird der Farbton überprüft.
 * @param color
 */
inline void TargetField::setScorePoint( const QColor &color )
{
    int h, s, v;

    color.getHsv( &h, &s, &v );

    if ( h >= 0 && h <= 20 ) {
        m_scorePoint = 3;
    } else if ( h > 20 && h <= 65 ) {
        m_scorePoint = 2;
    } else {
        m_scorePoint = 1;
    }

    // else if ( h > 65 &&  h <= 160 ) {
    //     m_scorePoint = 1;
    // }
}


#endif // TARGETFIELD_H
