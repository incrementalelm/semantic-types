const url = require("url");
const http = require("http"),
  server = http.createServer();

server.on("request", (request, response) => {
  const ssn = url.parse(request.url, true).query.ssn;
  const ssnWithoutDashes = ssn.replace(new RegExp(/-/, "g"), "");

  if (/^([0-9\-]*)$/.test(ssnWithoutDashes)) {
    response.writeHead(200, { "Content-Type": "text/plain" });
    response.write("success");
    response.end();
  } else {
    response.writeHead(200, { "Content-Type": "text/plain" });
    response.write("error");
    response.end();
  }
});

server.listen(3000, () => {
  console.log("Node server running at  http://localhost:3000");
});
