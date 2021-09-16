FROM maven:3.8.2-jdk-8-openj9 AS build

COPY pom.xml src/ /usr/local/src/

WORKDIR /usr/local/src/

RUN mvn package

FROM open-liberty:21.0.0.7-full-java8-openj9

COPY --chown=1001:0 --from=build /usr/local/src/target/sample-app.war /config/dropins/

RUN configure.sh
