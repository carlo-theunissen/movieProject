# Get latest nginx image 
FROM java:8

EXPOSE 80
EXPOSE 443

COPY ./MovieDatabaseBackend/target/*.jar ./app.jar
# Copy build into nginx image
COPY ./MovieFrontend/dist/livePerformance/ /var/www 
# Copy nginx config file to default.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

#installing nginx
RUN apt-get update
RUN apt-get -yq install net-tools nginx
RUN useradd -ms /bin/bash aurora

#install supervisor
RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#correct permisions
RUN chmod 777 ./app.jar
RUN chmod 777 ./etc/supervisor/conf.d/supervisord.conf
RUN chmod -R 777 ./var/www
RUN chmod 777 ./etc/nginx/conf.d/default.conf

RUN which java

#run supervisord
CMD ["/usr/bin/supervisord"]