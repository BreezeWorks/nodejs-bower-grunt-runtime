#
# Node.js w/ Bower & Grunt runtime Dockerfile
#
# https://github.com/DigitallySeamless/nodejs-bower-grunt-runtime
#

# Pull base image.
FROM digitallyseamless/nodejs-bower-grunt

# Install image libs
ONBUILD RUN apt-get update && apt-get install -y ruby ruby-dev graphicsmagick imagemagick && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ONBUILD RUN gem install compass

# Set instructions on build.
ONBUILD ADD package.json /app/
ONBUILD RUN npm install
ONBUILD ADD bower.json /app/
ONBUILD ADD .bowerrc /app/
ONBUILD RUN bower install
ONBUILD ADD . /app
ONBUILD RUN grunt build --force
ONBUILD WORKDIR /app/dist
ONBUILD ENV NODE_ENV production
ONBUILD RUN npm install

# Define working directory.
WORKDIR /app

# Define default command.
CMD ["npm", "start"]

# Expose ports.
EXPOSE 8080
