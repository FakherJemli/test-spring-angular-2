FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build --prod

FROM nginx:alpine
COPY --from=build /app/dist/employees-front-end /usr/share/nginx/html
EXPOSE 8080
HEALTHCHECK CMD curl -f http://localhost:8080 || exit 1
CMD ["nginx", "-g", "daemon off;"]