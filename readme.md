Open jenkins via je publieke ip op port 8080
Volg de stappen

installeer de plugings
- locale
- blue ocean 

ga naar *ipadres*:8080/configureTools/
en zet bij maven 
name : maven 3.6.0
path: /usr/local/src/apache-maven

verander de Jenkinsfile en docker file, daar staan namelijk de naam movie

open nginx.conf en controlleer als daar al de poorten goed stann
