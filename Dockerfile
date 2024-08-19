FROM node:15 as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM node:15-alpine

WORKDIR /app

COPY --from=builder /app /app

RUN npm install --production

ENV PORT=8080

EXPOSE 8080

ENTRYPOINT ["npm", "start"]