const http = require("http");
const sqlite3 = require("sqlite3");

function getAllMovies() {
    return new Promise((resolve, reject) => {
        const db = new sqlite3.Database("../db/kino.db");

        db.all(`SELECT * FROM Movie`, (err, rows) => {
            if (err) {
                console.error(err);
                reject(err);
            } else {
                resolve(rows);
            }
            db.close(); // Datenbank erst NACH der Abfrage schließen!
        });
    });
}

const server = http.createServer((req, res) => {
    if (req.method === "GET") {
        getAllMovies()
            .then(rows => {
                res.writeHead(200, { "Content-Type": "text/html" });

                let html = `
                    <html>
                    <head>
                        <style>
                            body {
                                font-family: Arial, sans-serif;
                                background-color: #1e1e1e;
                                color: white;
                                display: flex;
                                flex-wrap: wrap;
                                gap: 20px;
                                padding: 20px;
                            }
                            .movie-card {
                                position: relative;
                                width: 200px;
                                height: 300px;
                                border-radius: 10px;
                                overflow: hidden;
                                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.5);
                                transition: transform 0.3s ease-in-out;
                            }
                            .movie-card:hover {
                                transform: scale(1.05);
                            }
                            .movie-card img {
                                width: 100%;
                                height: 100%;
                                object-fit: cover;
                            }
                            .movie-title {
                                position: absolute;
                                bottom: 0;
                                width: 100%;
                                background: rgba(0, 0, 0, 0.6);
                                color: white;
                                padding: 10px;
                                text-align: center;
                                font-size: 16px;
                                font-weight: bold;
                            }
                        </style>
                    </head>
                    <body>
                        <div id="movies-container">
                `;

                rows.forEach(row => {
                    html += `
                        <div class="movie-card">
                            <img src="${row.picture}" />
                            <div class="movie-title">${row.title}</div>
                        </div>
                    `;
                });

                html += `
                        </div>
                        <script>
                            async function fetchMovies() {
                                try {
                                    let response = await fetch("/");
                                    let text = await response.text();
                                    let parser = new DOMParser();
                                    let newDocument = parser.parseFromString(text, "text/html");
                                    let newMoviesContainer = newDocument.getElementById("movies-container").innerHTML;
                                    document.getElementById("movies-container").innerHTML = newMoviesContainer;
                                } catch (error) {
                                    console.error("Fehler beim Abrufen der Filme:", error);
                                }
                            }

                            setInterval(fetchMovies, 1000); // Alle 5 Sekunden aktualisieren
                        </script>
                    </body>
                    </html>
                `;

                res.end(html);
            });
    } else {
        res.writeHead(404);
        res.end("");
    }
});

server.listen(8080, () => {
    console.log("waiting");
});
