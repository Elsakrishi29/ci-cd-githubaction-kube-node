const http = require('http');
const PORT = process.env.PORT || 5000;

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'application/json'});
  res.end(JSON.stringify({ message: 'Hello from myapp', ts: Date.now() }));
});

server.listen(PORT, () => console.log(`Server listening on ${PORT}`));
