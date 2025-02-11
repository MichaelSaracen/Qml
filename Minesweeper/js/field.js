class Field {
    constructor( x, y, width, height ) {
        this.x      = x;
        this.y      = y;
        this.width  = width;
        this.height = height;
        this.selected = false;
        this.visible = true;

        this.type = '';
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
            if ( this.type === 'Mine' ) {
                ctx.fillStyle = "red";
            } else if ( this.mineCount === 0 ) {
                ctx.fillStyle = '#ddd';
            } else {
                ctx.fillStyle = '#bbb';
            }
            ctx.fillRect( this.x, this.y , this.width, this.height );

            if ( this.mineCount > 0 && this.type !== "Mine") {
                ctx.fillStyle = "black";
                ctx.fillText(this.mineCount, this.x + this.width / 2, this.y + this.height / 2);
            }
        }
        ctx.restore();
    }
}





