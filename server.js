const url = require("url");
const http = require("http"),
  server = http.createServer();

server.on("request", (request, response) => {
  const ssn = url.parse(request.url, true).query.ssn;
  const ssnWithoutDashes = ssn.replace(new RegExp(/-/, "g"), "");

  response.writeHead(200, { "Content-Type": "application/json" });
  if (/^([0-9\-]*)$/.test(ssnWithoutDashes)) {
    response.end(JSON.stringify({ error: null }));
  } else {
    response.end(
      JSON.stringify({ error: `Contains characters besides - and [0-9].` })
    );
  }
});

server.listen(3000, () => {
  console.log("Node server running at  http://localhost:3000");
});
