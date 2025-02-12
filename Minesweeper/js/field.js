class Field {
    constructor( x, y, width, height ) {
        this.x      = x;
        this.y      = y;
        this.width  = width;
        this.height = height;
        this.selected = false;
        this.visible = false;

        this.type = 'None';
        this.mineCount = 0;
    }

    /**
     * Gibt die Koordinate für die linke Seite wieder.
     * @returns {Number}
     */
    get left() { return this.x }

    /**
     * Gibt die Koordinate für die rechte Seite wieder.
     * @returns {*}
     */
    get right() { return this.x + this.width }

    /**
     * Gibt die Koordinate für die unter Seite wieder.
     * @returns {*}
     */
    get bottom() { return this.y + this.height }

    /**
     * Gibt die Koordinate für die obere Seite wieder.
     * @returns {*}
     */
    get top() { return this.y }

    /**
     * Zeichnet das Feld auf dem Canvas wenn es ausgewählt ist.
     */
    draw() {
        let ctx = minesweeper.canvas.context;
        ctx.save();
        if ( this.visible ) {
            ctx.fillStyle = 'transparent';
            if ( this.type === 'Mine' ) {
<<<<<<< HEAD
=======
                ctx.fillStyle = 'transparent';
                ctx.fillRect( this.x, this.y , this.width, this.height );
>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28
                ctx.fillStyle = 'white';
                ctx.font = '400 30px Arial'
                ctx.fillText("💣", this.x + (this.width / 2) - 20 , this.y + (this.height / 2) +10);
            } else if ( this.mineCount === 0 ) {
<<<<<<< HEAD
                ctx.fillStyle = '#7644ff';
                ctx.fillRect( this.x + 2, this.y +2 , this.width - 4, this.height - 4 );

            } else {
=======
                ctx.fillStyle = Qt.lighter("#242329");
                ctx.fillRect( this.x, this.y , this.width, this.height );
            } else {
                ctx.fillStyle = 'transparent';
                ctx.fillRect( this.x, this.y , this.width, this.height );
            }

            if ( this.mineCount > 0 && this.type !== "Mine") {
>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28
                ctx.font = '400 20px Arial'
                let clr = this.mineCount === 1 ? "#9bfdb3"
                                               : this.mineCount === 2 ? "#9cf7ff"
                                                                      : this.mineCount === 3 ? "#ffea9c" : "#ff9c9c"
                ctx.fillStyle = clr;
                ctx.fillText(this.mineCount, this.x + (this.width / 2) - 5, this.y + (this.height / 2) +5);
<<<<<<< HEAD

=======
>>>>>>> 54ab01889fb3158f3c4c160874b13733c2052f28
            }
        }
        ctx.restore();
    }
}





