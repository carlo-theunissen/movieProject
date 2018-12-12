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
RUN apt-get install -y --no-install-recommends software-properties-common
RUN add-apt-repository -y ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y openjdk-8-jre
RUN update-alternatives --config java
RUN update-alternatives --config javac

#copy run.sh
COPY ./run.sh ./run.sh

RUN chmod -R 777 .

# Run server
CMD ./run.sh