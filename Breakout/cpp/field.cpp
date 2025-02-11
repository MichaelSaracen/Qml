#include "field.h"
#include "ball.h"
#include <QPainter>

Field::Field(QQuickItem *parent)
    : QQuickPaintedItem( parent ),
    m_color( 36, 40, 47 ), m_ball(nullptr),
    m_totalScore(0),
    m_lifes(5),
    m_medals(0),
    m_maxScore(1)
{
    m_timer = new QTimer(this);

    // [!] -> Timer für das Ball Movement.
    connect(m_timer, &QTimer::timeout, this, [=]() {
        if (m_ball) {
            if (m_ball->canMove( m_targets ) ) {
                m_timer->setInterval(10 - m_ball->getSpeed());

            } else {
                m_timer->stop();
                qDebug() << "Spiel - Ende";
                emit gameFinished();
            }
            update();
        }
    });

}


/**
 * @brief Field::addScorePoints
 * erhöht die Score
 * @param points
 */
void Field::addScorePoints(int points)
{
    qDebug() << points;
    m_totalScore += points;
    //update();
}


/*!
 * \brief Field::createField
 * Erstellt das Feld mit den Items drauf.
 */
void Field::createField()
{
    qDebug() << "Field created";
    m_maxScore = 0;

    const int ROWS               = 7;
    const int HORIZONTAL_COUNT  = int(width() / 10);
    const int ITEM_HEIGHT       = int(width() * 0.04);
    const int SPACING           = 2;

    // [!] --- Felder setzen
    for ( int y = 0; y < ROWS; ++y ) {
        for ( int x = 0; x < width(); x+=HORIZONTAL_COUNT ) {
            TargetField *target = new TargetField(x + SPACING, (y * ITEM_HEIGHT) + SPACING, HORIZONTAL_COUNT - (SPACING*2), ITEM_HEIGHT- (SPACING * 2));
            QColor clr = y == 0 || y == 1 ?
                            QColor( 255, 97 , 96 ) : y == 2 || y == 3 ?
                            QColor( 255, 224, 130 ) : QColor( 165, 214, 167 );
            target->setColor(clr);
            target->setBorderColor(clr.darker());
            target->setScorePoint(clr);
            m_maxScore += target->scorePoint();
            m_targets << target;
        }
    }

    // [!] --- Paddel initialisieren
    const int PADDEL_HEIGHT     = int( ITEM_HEIGHT * 0.5 );
    const int PADDEL_WIDTH      = HORIZONTAL_COUNT;
    const int PADDEL_X          = ( width() / 2 ) - ( PADDEL_WIDTH / 2 );
    const int PADDEL_Y          = height() - PADDEL_HEIGHT - SPACING;
    m_paddel = new Paddel( this, PADDEL_X , PADDEL_Y, PADDEL_WIDTH, PADDEL_HEIGHT );


    // [!] --- Ball initialisieren
    m_ball = new Ball(this, 200, 500, PADDEL_WIDTH * 0.25, PADDEL_WIDTH * 0.25);
    //update();
    qDebug() << "Max - Score:" << m_maxScore;
    update();
}


/**
 * @brief Field::drawTargets
 * Zeichnet die Felder auf dem Painter.
 * @param painter
 */
void Field::drawTargets(QPainter *painter)
{
    // [!] --- TargetFields zeichnen
    if ( !m_targets.empty() ) {
        for ( TargetField *target : std::as_const(m_targets) ) {
            painter->setPen(QPen(target->borderColor(),1));
            painter->setBrush(QBrush(target->color()));
            QRect r = target->rect();
            painter->drawRect(r.x(), r.y(), r.width(), r.height());
        }

        painter->setPen(QPen(m_paddel->borderColor(),1));
        painter->setBrush(QBrush(m_paddel->color()));
        painter->drawRect(m_paddel->rect());

        painter->setPen(QPen(m_ball->borderColor(),1));
        painter->setBrush(QBrush(m_ball->color()));
        painter->drawEllipse(m_ball->rect());
    }
}

/**
 * @brief Field::maxScore
 * Gibt den Maximalen Score wieder.
 * @return
 */
int Field::maxScore() const { return m_maxScore; }
void Field::setMaxScore(int newMaxScore)
{
    m_maxScore = newMaxScore;
    emit maxScoreChanged();
}

/**
 * @brief Field::medals
 * Gibt die Anzahl der errungenen Medals zurück.
 * @return
 */
int Field::medals() const { return m_medals; }
void Field::setMedals(int newMedals)
{
    m_medals = newMedals;
    emit medalsChanged();
}

/**
 * @brief Field::lifes
 * Anzahl der Leben
 * @return
 */
int Field::lifes() const { return m_lifes; }

void Field::setLifes(int newLifes)
{
    m_lifes = newLifes;
    emit lifesChanged();
}

/**
 * @brief Field::paddel
 * Gibt einen Zeiger auf das Paddel wieder.
 * @return
 */
Paddel *Field::paddel() const { return m_paddel; }


/**
 * @brief Field::movePaddel
 * Bewegen des Paddels
 * @param x
 */
void Field::movePaddel(int x)
{
    if ( m_paddel ) {
        m_paddel->moveBy( x );
        update();
    }
}


void Field::paint(QPainter *painter)
{
    painter->fillRect(QRect(0,0,width(), height()), m_color);
    drawTargets(painter);
}


/**
 * @brief Field::restartGame
 *
 * Setzt das Spielfeld zurück.
 */
void Field::restartGame()
{

    if ( !m_targets.empty() && m_paddel ) {
        qDebug() << "Game restarted";

        // [!] --- Alle Targets löschen
        qDeleteAll(m_targets);
        m_targets.clear();

        // [!] --- Paddel löschen
        if (m_paddel) {
            delete m_paddel;
            m_paddel = nullptr;
        }

        // [!] --- Ball löschen
        if (m_ball) {
            delete m_ball;
            m_ball = nullptr;
        }
        m_totalScore = 0;
        m_maxScore = 0;
        m_lifes = 5;
        m_medals = 0;

        emit lifesChanged();
        emit medalsChanged();
        emit totalScoreChanged();
        update();
    }
}

void Field::startGame() {
    m_timer->start(10);
    emit maxScoreChanged();
}


/*!
 * \brief Field::setColor
 * Setzt die Farbe für das Spielfeld. Default - Wert ist weiß.
 * \param color
 */
void Field::setColor( const QColor &color ) { m_color = color; emit colorChanged(); update(); }
QColor Field::color( ) const { return m_color; }

/**
 * @brief Field::totalScore
 * Gibt die GesamtPunkte zurück.
 * @return
 */
int Field::totalScore() const { return m_totalScore; }
void Field::setTotalScore(int totalScore)
{
    m_totalScore = totalScore;
    emit totalScoreChanged();
}

