FROM maven:3.8.4-openjdk-8 AS build_image

RUN git clone https://github.com/shayh85/hello-world-war.git

WORKDIR /hello-world-war

RUN mvn package


FROM openjdk

WORKDIR /app

COPY --from=build_image /hello-world-war/target/*.war .

EXPOSE 8080

CMD java -jar *.war



