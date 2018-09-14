FROM gradle:jdk8 as builder

COPY --chown=gradle:gradle . /home/gradle/music
WORKDIR /home/gradle/music
RUN gradle clean assemble

FROM openjdk:8-jre-alpine
COPY --from=builder /home/gradle/music/build/libs/music*.jar /spring-music.jar

EXPOSE 8080

CMD java -jar -Dspring.profiles.active="in-memory" /spring-music.jar

