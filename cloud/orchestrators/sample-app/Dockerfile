FROM node:12.18-slim
LABEL maintainer="Leonardo Rebouças de Carvalho"
COPY . /var/www
WORKDIR "/var/www/"
RUN npm install
EXPOSE 80
CMD "npm" "start"
