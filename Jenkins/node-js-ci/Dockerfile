FROM node:26.3-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm clean-install
COPY . .
RUN npm run build

# FROM node:26.3-alpine
# WORKDIR /app
# RUN npm install --global serve
# COPY --from=builder /app/dist ./dist
# EXPOSE 3000
# CMD ["serve", "--single", "dist", "--listen", "3000"]

FROM nginx:1.30-alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]