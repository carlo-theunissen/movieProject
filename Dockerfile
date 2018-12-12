# Get tomcat image with java 10
FROM tomcat:9.0.13-jre10
# Set WORKDIR to root
WORKDIR ./MovieDatabaseBackend/
# Copy target jar file into the image
COPY ./MovieDatabaseBackend/target/*.jar ./app.jar


# Get latest nginx image 
FROM nginx
WORKDIR ./MovieDatabaseFrontend/
# Copy build into nginx image
COPY ./MovieDatabaseFrontend/dist/*/ /var/www
# Copy nginx config file to default.conf
COPY ./MovieDatabaseFrontend/nginx.conf /etc/nginx/conf.d/default.conf
# Run server
CMD ./run.sh