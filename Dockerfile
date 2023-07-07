FROM maven AS warfile
RUN apt update && apt install git wget -y
WORKDIR /home
RUN mkdir source
WORKDIR source
COPY . .
RUN mvn clean package


FROM tomcat
WORKDIR /usr/local/tomcat
RUN cp -r webapps.dist/*  webapps
COPY --from=warfile /home/source/target/*.war webapps
EXPOSE 8080
