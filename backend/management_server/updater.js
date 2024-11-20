const fs = require("fs");
const fse = require("fs-extra");
const extract = require("extract-zip");
const path = require("path");

class Updater {
    async update(files) {
        console.log("Updating the server");
        if (files["zipfile"].name.indexOf(".zip") < 0) throw "Invalid payload";
        console.log("Copying the uploaded files to upload directory ");
        for (let f in files) files[f].mv("./upload/" + files[f].name);
        return this.extractAndCopy("./upload");
    }

    async extractAndCopy(folder) {
        return new Promise((res, rej) =>
            setTimeout(async () => {
                try {
                    for (let uploadedfile of fs.readdirSync(folder)) {
                        if (uploadedfile.indexOf(".zip") > 0) {
                            console.log("Extracting zip file " + uploadedfile);
                            await extract(folder + "/" + uploadedfile, {
                                dir: `${path.join(__dirname, '..', path.join(folder.substring(1) + "/extract"))}`,
                            });
                        }
                    }
                    await new Promise((res, rej) => setTimeout(() => res(), 500));
                    let target = `${path.join(__dirname, '..', path.join(folder.substring(1) + "/extract"))}`;
                    if (!fs.existsSync(target)) {
                        console.log(`Nothing to extract, done....`);
                        res(true);
                        return;
                    }

                    console.log(`Moving extracted files`);
                    fse.moveSync(target, `${path.join(__dirname, '..', path.join('backend'))}`, { overwrite: true });
                    console.log("Removing temp files and folders");
                    fse.removeSync(`${path.join(__dirname, '..', path.join(folder.substring(1)))}`, { recursive: true, force: true });
                    console.log("Updating completed");
                    res(true);
                } catch (e) {
                    console.log("Updating failed");
                    rej(e);
                }
            }, 500)
        );
    }
}

module.exports = Updater;
