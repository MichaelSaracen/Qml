#ifndef FIELD_H
#define FIELD_H

#include <QQuickPaintedItem>
#include <QTimer>
#include "targetfield.h"
#include "paddel.h"
//#include "ball.h"

class Ball;
class Field : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged FINAL)
    QML_ELEMENT
public:
    Field( QQuickItem *parent = nullptr );

    void addScorePoints( int points );

    QColor color() const;
    void setColor(const QColor &color);
    void paint(QPainter *painter);

    Q_INVOKABLE void createField();
    Q_INVOKABLE void movePaddel( int x );
    Q_INVOKABLE void restartGame();
    Q_INVOKABLE void startGame();


    int totalScore() const;
    void setTotalScore(int totalScore);

    Paddel *paddel() const;

    int lifes() const;
    void setLifes(int newLifes);

    int medals() const;
    void setMedals(int newMedals);

    int maxScore() const;
    void setMaxScore(int newMaxScore);

signals:
    void colorChanged();
    void totalScoreChanged();
    void lifesChanged();
    void medalsChanged();
    void gameFinished();
    void maxScoreChanged();

private:
    void drawTargets(QPainter *painter);
private:
    QColor m_color;
    QList<TargetField*> m_targets;
    Paddel *m_paddel;
    Ball *m_ball;
    int m_totalScore;
    int m_lifes;
    int m_medals;
    int m_maxScore;
    QTimer *m_timer;
    Q_PROPERTY(int totalScore READ totalScore WRITE setTotalScore NOTIFY totalScoreChanged FINAL)
    Q_PROPERTY(int lifes READ lifes WRITE setLifes NOTIFY lifesChanged FINAL)
    Q_PROPERTY(int medals READ medals WRITE setMedals NOTIFY medalsChanged FINAL)
    Q_PROPERTY(int maxScore READ maxScore WRITE setMaxScore NOTIFY maxScoreChanged FINAL)
};




#endif // FIELD_H
