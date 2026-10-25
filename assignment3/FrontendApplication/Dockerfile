FROM node:22-alpine AS build

WORKDIR /app
COPY package.json ./
RUN npm install --no-package-lock
COPY webpack.config.js ./
COPY src/ ./src/
RUN npm run build

FROM nginx:alpine
COPY --from=build /app/dist/ /usr/share/nginx/html/
