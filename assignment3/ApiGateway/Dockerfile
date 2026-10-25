FROM node:22-alpine

WORKDIR /app
COPY package.json ./
RUN npm install --no-package-lock --omit=dev
COPY index.js ./

CMD ["node", "index.js"]
