#ifndef ELAPSEDTIMER_H
#define ELAPSEDTIMER_H

#include <QObject>
#include <QElapsedTimer>

class ElapsedTimer: public QObject {
    Q_OBJECT
    Q_PROPERTY( qint64 milliSeconds READ milliSeconds )
    Q_PROPERTY( qint64 seconds READ seconds )
    Q_PROPERTY( qint64 minutes READ minutes )
public:
    ElapsedTimer( QObject *parent = nullptr );

    qint64 milliSeconds() const;
    qint64 seconds() const;
    qint64 minutes() const;

public slots:
    void start();
    void stop();
    void pause();

private:
    QElapsedTimer *m_timer;
    qint64 m_pausedTime = 0;
    bool m_isPaused;
};

inline ElapsedTimer::ElapsedTimer(QObject *parent) : QObject(parent)
{
    m_timer = new QElapsedTimer();
    m_isPaused = true;

}

inline qint64 ElapsedTimer::milliSeconds() const {
    if ( m_isPaused ) return m_pausedTime;
    return (m_pausedTime + m_timer->elapsed()) % 1000;
}

inline qint64 ElapsedTimer::seconds() const
{
    if ( m_isPaused ) return m_pausedTime / 1000;
    return ((m_pausedTime + m_timer->elapsed()) / 1000) % 60;
}

inline qint64 ElapsedTimer::minutes() const
{
    if ( m_isPaused ) return m_pausedTime / 60000;
    return ((m_pausedTime + m_timer->elapsed()) / 60000) % 60;
}

inline void ElapsedTimer::start() {

    m_timer->start();
    m_isPaused = false;

}

inline void ElapsedTimer::stop()
{
    m_timer->invalidate();
    m_pausedTime = 0;
    m_isPaused = true;
}

inline void ElapsedTimer::pause()
{
    if ( !m_isPaused ) {
        m_pausedTime += m_timer->elapsed();
        m_isPaused = true;
    }
}

































#endif // ELAPSEDTIMER_H
