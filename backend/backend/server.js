const express = require("express");
const app = express();
const args = process.argv;
const portArg = args.find(arg => arg.startsWith('--PORT='));

let PORT = 3000; // Default port
if (portArg) {
    PORT = parseInt(portArg.split('=')[1], 10); // Extract and parse the port number
}

app.use(express.json());

app.use((req, res, next) => {
    console.log(`${req.method} request for '${req.url}'`);
    next();
});

app.get("/version", (req, res) => {
    res.send({ version: "0.0.0" });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
