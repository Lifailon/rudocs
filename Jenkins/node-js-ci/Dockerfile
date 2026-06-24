FROM node:26.3-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm clean-install
COPY . .
RUN npm run build

FROM node:26.3-alpine
WORKDIR /app
RUN npm install --global serve
COPY --from=builder /app/dist ./dist
EXPOSE 3000
CMD ["serve", "--single", "dist", "--listen", "3000"]