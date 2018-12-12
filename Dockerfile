# Get tomcat image with java 10
FROM tomcat:9.0.13-jre10
# Set WORKDIR to root
WORKDIR ./MovieDatabaseBackend/
# Copy target jar file into the image
COPY ./MovieDatabaseBackend/target/*.jar ./app.jar


# Get latest nginx image 
FROM nginx
# Copy build into nginx image
COPY ./MovieFrontend/dist/livePerformance/ /var/www 
# Copy nginx config file to default.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

#installing java
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list

RUN apt-get -y update

RUN apt-get install default-jre

#copy run.sh
COPY ./run.sh ./run.sh

RUN chmod -R 777 .

# Run server
CMD ./run.sh