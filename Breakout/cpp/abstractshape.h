#ifndef ABSTRACTSHAPE_H
#define ABSTRACTSHAPE_H

#include <QObject>
#include <QDebug>
#include <QRect>
#include <QColor>
#include <QQuickPaintedItem>

class AbstractShape {
public:
    AbstractShape(int x, int y, int width, int height);
    virtual ~AbstractShape() = default;

    QRect rect() const;
    void setRect(const QRect &rect);

    QColor color() const;
    void setColor(const QColor &color);

    QColor borderColor() const;
    void setBorderColor(const QColor &borderColor);

private:
    QRect m_rect;
    QColor m_color;
    QColor m_borderColor;
};

inline AbstractShape::AbstractShape(int x, int y, int width, int height) :
    m_rect(x,y,width, height),
    m_color(Qt::red),
    m_borderColor(Qt::black)
{

}

/**
 * @brief AbstractShape::rect
 * Gibt das Rect für das TargetField wieder.
 * @return
 */
inline QRect AbstractShape::rect() const { return m_rect; }
inline void AbstractShape::setRect(const QRect &rect) { m_rect = rect; }

/*!
 * \brief TargetField::setColor
 * setzt die Farbe des Feldes
 * \param clr
 */
inline QColor AbstractShape::color() const { return m_color; }
inline void AbstractShape::setColor(const QColor &color) { m_color = color; }

/*!
 * \brief AbstractShape::borderColor
 *  setzt die Rahmenfarbe des Feldes
 * \return
 */
inline QColor AbstractShape::borderColor() const { return m_borderColor; }
inline void AbstractShape::setBorderColor(const QColor &borderColor) { m_borderColor = borderColor; }

#endif // ABSTRACTSHAPE_H
