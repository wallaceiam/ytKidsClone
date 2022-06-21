const playlists = require("./playlists");
const path = require("path");
const sharp = require("sharp");

const { rmdir, mkdir, readFile, readdir, copyFile, writeFile } = require("fs/promises");
const { spawn } = require('child_process');

const downloadVideos = async (id, url) => {
  await rmdir(id, { recursive: true, force: true });
  await mkdir(id);

  await new Promise((resolve) => {

    const ls = spawn("../yt-dlp", [
      "-f",
      "(mp4)[height<720]",
      "--ignore-errors",
      "--yes-playlist",
      url,
      "--write-thumbnail",
      "--write-info-json"],
      {
        cwd: id
      });

    ls.stdout.on('data', (data) => {
      console.log(`${data}`);
    });

    ls.stderr.on('data', (data) => {
      console.error(`${data}`);
    });

    ls.on('close', (code) => {
      console.log(`child process close all stdio with code ${code}`);
      resolve();
    });

    ls.on('exit', (code) => {
      console.log(`child process exited with code ${code}`);
      resolve();
    });
  });
}

const createImages = async (id, fileName) => {
  const img = sharp(await readFile(fileName))
  // 1280x780 
  const mediaDist = path.join("..", "ytKidsClone", "ytKidsClone", "Media.xcassets", `${id}_thumb.imageset`);
  
  try {
    await mkdir(mediaDist);
  } catch (err) {
    if (err.code !== 'EEXIST')
      throw err;
  }
  await img.resize(1280 * 0.75, 780 * 0.75).toFile(path.join(mediaDist, `${id}_thumb@3x.jpeg`));
  await img.resize(1280 * 0.50, 780 * 0.50).toFile(path.join(mediaDist, `${id}_thumb@2x.jpeg`));
  await img.resize(1280 * 0.25, 780 * 0.25).toFile(path.join(mediaDist, `${id}_thumb@1x.jpeg`));

  const contents = {
    images: ["1x", "2x", "3x"].map((v) => (
      {
        filename: `${id}_thumb@${v}.jpeg`,
        idiom: "universal",
        scale: v
      })),
    info: {
      author: "xcode",
      version: 1
    }
  };


  await writeFile(path.join(mediaDist, `Contents.json`), JSON.stringify(contents));
}

const processVideos = async (cwd) => {
  const results = [];
  const files = await readdir(cwd)
  for (const file of files) {
    if (!file.endsWith(".info.json")) {
      continue;
    }

    if (!files.includes(file.replace(".info.json", ".mp4"))) {
      continue;
    }

    const contents = await readFile(path.join(cwd, file));
    const { id, title, description, uploader } = JSON.parse(contents);

    const result = {
      id,
      title,
      description,
      uploader
    };
    results.push(result);

    console.log(`${uploader}:\t${id}\t${title}`);

    const videoDist = path.join("..", "ytKidsClone", "ytKidsClone", "Resources");

    await copyFile(path.join(cwd, file.replace(".info.json", ".mp4")), path.join(videoDist, `${id}_video.mp4`));

    await createImages(id, path.join(cwd, file.replace(".info.json", ".webp")));

    // break;
  }

  return results;
}

const main = async () => {
  await rmdir("dist", { recursive: true, force: true });
  
  let index = [];
  for (const { id, url } of playlists) {
    console.log(`${id}: ${url}`);
    // await downloadVideos(id, url);
    const result = await processVideos(id);
    index = [...index, ...result];
  }
  const dist = path.join("..", "ytKidsClone", "ytKidsClone");
  await writeFile(path.join(dist, "videos.json"), JSON.stringify(index));
}

main();