FROM node:lts

WORKDIR /usr/app

COPY package.json .
RUN npm install --quiet

COPY . .
ENV PORT 8080
EXPOSE 8080
CMD ["node" , "index.js"]