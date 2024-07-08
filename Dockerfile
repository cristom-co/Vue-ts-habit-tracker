# Usa una imagen base oficial de Node.js para construir la imagen
FROM node:16-alpine AS build-stage

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código de la aplicación
COPY . .

# Construye la aplicación para producción
RUN npm run build

# Usa una imagen base oficial de Nginx para servir la aplicación
FROM nginx:stable-alpine AS production-stage

# Copia los archivos de build de la primera etapa al directorio Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Copia el archivo de configuración de Nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 80

# Comando por defecto para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
