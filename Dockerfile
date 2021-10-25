#Phase 1: Build Phase (Creating build file generated from npm run build)
FROM node:alpine AS builder

USER node
RUN mkdir /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

RUN npm run build

#Phase 2: Run Phase (Create ngix server, copy over build file to this image and run)
FROM nginx
#Copy build file from previous phase to Nginix
COPY --from=builder /home/node/app/build /usr/share/nginx/html