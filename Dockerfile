# Get latest nginx image 
FROM nginx
#
COPY ./MovieDatabaseBackend/target/*.jar ./app.jar
# Copy build into nginx image
COPY ./MovieFrontend/dist/livePerformance/ /var/www 
# Copy nginx config file to default.conf
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

#installing java
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list

RUN apt-get -y update
RUN apt-get install tzdata-java
RUN apt-get install openjdk-7-jdk openjdk-7-jre-headless
RUN apt-get install default-jre

#copy run.sh
COPY ./run.sh ./run.sh

RUN chmod -R 777 .

# Run server
CMD ./run.sh