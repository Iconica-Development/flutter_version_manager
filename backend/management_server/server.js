const express = require('express')
const app = express()
const fetch = require('node-fetch')
const { spawn } = require('child_process');
const Updater = require("./updater.js");
const exprfup = require("express-fileupload");

let child;

const PORT = 3000
const BACKENDPORT = 3001
const AUTOSTART = true

app.use(express.json());
app.use(exprfup({ createParentPath: true }));

app.use((req, _, next) => {
    console.log(`${req.method} request for '${req.url}'`);
    next();
});

app.post('/update', function (req, res) {
    console.log("Update request");
    const updater = new Updater();

    killBackendServer();

    updater.update(req.files).then(() => {
        res.send({ updated: true });
        startBackendServer();
    }).catch((err) => {
        res.send({ updated: false, error: err });
        startBackendServer();
    });
})

app.get('/shutdown', function (_, res) {
    console.log("Shutdown request");
    var success = killBackendServer();

    if (success) {
        res.send({ status: "success" });
    } else {
        res.send({ status: "failed" });
    }
})

app.get('/start', function (_, res) {
    console.log("Start request");
    startBackendServer();
    res.send({ status: "success" });
})

app.get('/api/*', function (req, res) {
    fetch(`http://localhost:${BACKENDPORT}/${req.url.split('/api/')[1]}`)
        .then(response => response.json())
        .then(data => res.send(data))
        .catch(err => res.send({ error: err }));

});

startBackendServer = () => {
    killBackendServer();

    child = spawn('node', ['server.js', `--PORT=${BACKENDPORT}`], { cwd: 'backend' });

    child.stdout.on('data', (data) => {
        console.log(`BACKEND:\n${data}`);
    });

    child.stderr.on('data', (data) => {
        console.error(`BACKEND:\n${data}`);
    });

    child.on('close', (code) => {
        console.log(`Child process exited with code ${code}`);
    });

    child.on('error', (err) => {
        console.error(`Failed to start subprocess: ${err}`);
    });
}

killBackendServer = () => {
    if (child) {
        child.kill();
        return true;
    }

    return false;
}

app.listen(PORT, () => {
    console.log(`Management Server is running on http://localhost:${PORT}`);

    if (AUTOSTART) {
        console.log("AUTOSTART is enabled");
        startBackendServer();
    } else {
        console.log("AUTOSTART is disabled, please start the backend server manually");
    }
});