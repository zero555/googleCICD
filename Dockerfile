FROM maven:3.6.1-jdk-8 as maven_builder
WORKDIR /app
ADD pom.xml .

RUN ["/usr/local/bin/mvn-entrypoint.sh", "mvn", "verify", "clean", "--fail-never"]
ADD . $HOME
RUN ["mvn","clean","install"]

FROM anapsix/alpine-java
COPY --from=maven_builder /app/target/googleCICD.jar /home/googleCICD.jar
CMD ["java","-jar","/home/googleCICD.jar"]