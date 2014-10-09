Node.js w/ Bower & Grunt runtime Dockerfile
===========================================

This repository contains a **Dockerfile** that builds a [Node.js](http://nodejs.org/) w/ [Bower](http://bower.io/) & [Grunt](http://gruntjs.com/) runtime. It is also the base for an [automated build](https://registry.hub.docker.com/u/digitallyseamless/nodejs-bower-grunt-runtime/) that is maintained on the public [Docker Hub Registry](https://registry.hub.docker.com/).

This is a base image for deploying/running your [Node.js](http://nodejs.org/) applications.

It can automatically bundle a `Node.js` application with its dependencies and set the default command with no additional Dockerfile instructions.

This project was heavily inspired by code from: [dockerfile/nodejs-bower-grunt-runtime](https://registry.hub.docker.com/u/dockerfile/nodejs-bower-grunt-runtime/).

### Base Docker Image - [dockerfile/nodejs-bower-grunt](http://dockerfile.github.io/#/nodejs-bower-grunt)


Installation
============
**Optional** - docker will download the image if needed when you build your nodejs docker application image.

1. Download an [automated build](https://registry.hub.docker.com/u/digitallyseamless/nodejs-bower-grunt-runtime/) from the public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull digitallyseamless/nodejs-bower-grunt-runtime`

   (alternatively, you can build an image from Dockerfile: `docker build -t="digitallyseamless/nodejs-bower-grunt-runtime" github.com/DigitallySeamless/nodejs-bower-grunt-runtime`)


Usage
=====

This image assumes that your application:

* has a file named [package.json](https://www.npmjs.org/doc/json.html) listing its dependencies.
* has a file named [bower.json](http://bower.io/docs/creating-packages/) listing any client dependencies.
* has a file named [.bowerrc](http://bower.io/docs/config/#bowerrc-specification), used to configure bower.
* has a file named [Gruntfile.js](http://gruntjs.com/sample-gruntfile) that registers a `build` task.
* builds to a `dist` folder with a `package.json` file that should be installed with `npm install --production`.
* has a file named `server.js` as the entrypoint script or defines a `start` script in package.json: `"scripts": {"start": "node <entrypoint_script_js>"}`
* uses `process.env.NODE_ENV` to determine `production` environment.
* listens on port `8080`

When building your application docker image, `ONBUILD` triggers NPM to install your application's dependencies.

* **Step 1**: Create a Dockerfile in your `Node.js` application directory with the following content:

```dockerfile
    FROM digitallyseamless/nodejs-bower-grunt-runtime
```

* **Step 2**: Build your container image by running the following command in your application directory:

```sh
    docker build -t="app" .
```

* **Step 3**: Run application by mapping port `8080`:

```sh
    APP=$(docker run -d -p 8080 app)
    PORT=$(docker port $APP 8080 | awk -F: '{print $2}')
    echo "Open http://localhost:$PORT/"
```

Branches
========

This repo also includes "feature branches" that add various libraries and other components to the base image. Each feature branch is an automated build as well, and is tagged in the Docker Hub Registry by it's branch name.

* [image-support](https://github.com/DigitallySeamless/nodejs-bower-grunt-runtime/tree/image-support) [`digitallyseamless/nodejs-bower-grunt-runtime:image-support`] - adds `graphicsmagick` and `imagemagick` to the base image
