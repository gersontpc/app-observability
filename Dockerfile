FROM amazoncorretto:21-alpine3.19-jdk

RUN adduser -u 1001 -h /app -S appuser

ENV OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:4318/v1/metrics
ENV OTEL_SDK_DISABLED=true
ENV OTEL_SERVICE_NAME=app-name
ENV OTEL_INSTRUMENTATION_LIBRARY_NAMES=java.util.logging

COPY --chown=appuser:appuser --chmod=755 app/target/app-v1.0.0.jar /app/app.jar
COPY --chown=appuser:appuser --chmod=755 agent/opentelemetry-javaagent.jar /app/opentelemetry-javaagent.jar

WORKDIR /app

ENTRYPOINT ["java", "-javaagent:/app/opentelemetry-javaagent.jar", "-jar", "/app/app.jar"]
