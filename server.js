const url = require("url");
const http = require("http"),
  server = http.createServer();

server.on("request", (request, response) => {
  const parsedUrl = url.parse(request.url, true);
  if (parsedUrl.query && parsedUrl.query.ssn) {
    const ssn = parsedUrl.query.ssn;
    const ssnWithoutDashes = ssn.replace(new RegExp(/-/, "g"), "");

    response.writeHead(200, { "Content-Type": "application/json" });
    if (/^([0-9\-]*)$/.test(ssnWithoutDashes)) {
      response.end(JSON.stringify({ error: null }));
      global.ssn = ssn;
    } else {
      response.end(
        JSON.stringify({ error: `Contains characters besides - and [0-9].` })
      );
    }
  } else {
    response.writeHead(200, { "Content-Type": "application/json" });
    response.end(JSON.stringify({ ssnInput: global.ssn }));
  }
});

server.listen(3000, () => {
  console.log("Node server running at  http://localhost:3000");
});
