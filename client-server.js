const proxy = require("http-proxy-middleware");
const Bundler = require("parcel-bundler");
const express = require("express");
const opn = require("opn");

const bundler = new Bundler("./social.html", {
  cache: false
});

const app = express();

app.use(
  "/api",
  proxy({
    target: "http://localhost:3000"
  })
);

app.use(bundler.middleware());

app.listen(Number(process.env.PORT || 1234));
opn("http://localhost:1234");
