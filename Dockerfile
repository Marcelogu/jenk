FROM node:alpine3.18
WORKDIR /app
COPY app.js .
CMD ["node", "app.js"]
