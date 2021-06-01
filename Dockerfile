FROM maven:3.6.3-adoptopenjdk-11 as build

ADD ./ /src

WORKDIR /src
RUN mvn clean package


FROM adoptopenjdk:11.0.10_9-jre-hotspot
COPY --from=build /src/jmx_prometheus_javaagent/target/jmx_prometheus_javaagent-*.jar /opt/jmx_exporter/
RUN ln -s /opt/jmx_exporter/jmx_prometheus_javaagent-*.jar /jmx_prometheus_javaagent.jar

CMD ["/bin/bash"]
