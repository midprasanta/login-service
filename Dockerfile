FROM openjdk:8-jdk-alpine as builder
RUN  mkdir -p /workdir
COPY . /workdir
WORKDIR /workdir
RUN ./mvnw clean package -Dmaven.test.skip=true

FROM openjdk:8-jdk-alpine as runtime
COPY --from=builder  /workdir/target/*.jar /app.jar
CMD ["java", "-jar", "/app.jar"]