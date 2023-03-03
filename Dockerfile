FROM node:16

WORKDIR /app

COPY package*.json /app/

RUN npm install

COPY . /app

RUN npx prisma generate

EXPOSE 3003

CMD node src/app.js
