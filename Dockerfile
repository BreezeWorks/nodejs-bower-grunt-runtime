#
# Node.js w/ Bower & Grunt runtime Dockerfile
#
# https://github.com/dockerfile/nodejs-bower-grunt-runtime
#

# Pull base image.
FROM dockerfile/nodejs-bower-grunt

# Temporary fix for npm lock file issue
ONBUILD RUN npm install -g npm\@2.1.1

# Set instructions on build.
ONBUILD ADD package.json /app/
ONBUILD RUN npm install
ONBUILD ADD bower.json /app/
ONBUILD ADD .bowerrc /app/
ONBUILD RUN bower install --allow-root
ONBUILD ADD . /app
ONBUILD RUN grunt build
ONBUILD WORKDIR /app/dist
ONBUILD ENV NODE_ENV production
ONBUILD RUN npm install

# Define working directory.
WORKDIR /app

# Define default command.
CMD ["npm", "start"]

# Expose ports.
EXPOSE 8080
