class Card {
    constructor(x, y, width, height, source, pairID) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.source = source;
        this.pairID = pairID;
        console.log(this.pairID);
        this.visible = false;
        this.hasMatch = false;
    }

    draw(ctx) {
        if ( this.visible) {
            ctx.drawImage(this.source, this.x, this.y, this.width, this.height);
        } else {
            ctx.strokeStyle = '#000000'
            ctx.lineWidth = 2
            ctx.fillStyle = '#d0d0d0'
            ctx.fillRect(this.x , this.y , this.width , this.height );
            ctx.strokeRect(this.x + 1, this.y + 1, this.width - 2, this.height - 2);
        }
    }

    get right() { return this.x + this.width }
    get left() { return this.x }
    get top() { return this.y }
    get bottom() { return this.y + this.height }

    swap ( other ) {
        let tempX = this.x;
        let tempY = this.y;

        this.x = other.x;
        this.y = other.y;

        other.x = tempX;
        other.y = tempY;


    }
}
