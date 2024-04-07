## App Java to test Observability Stack
This is a simple web application, when making an http request, it adds up the number of requests. This application can be used to test the observability stack, targeting the three pillars (Metrics, Tracking and Logs).


### Exposed Endpoints
The exposed endpoints in http://localhost:8080/actuator
```bash
$ curl localhost:8080/actuator | jq .
{
  "_links": {
    "self": {
      "href": "http://localhost:8080/actuator",
      "templated": false
    },
    "health": {
      "href": "http://localhost:8080/actuator/health",
      "templated": false
    },
    "health-path": {
      "href": "http://localhost:8080/actuator/health/{*path}",
      "templated": true
    },
    "prometheus": {
      "href": "http://localhost:8080/actuator/prometheus",
      "templated": false
    },
    "metrics-requiredMetricName": {
      "href": "http://localhost:8080/actuator/metrics/{requiredMetricName}",
      "templated": true
    },
    "metrics": {
      "href": "http://localhost:8080/actuator/metrics",
      "templated": false
    }
  }
}
```

`http://localhost:8080/actuator` - Shows all endpoints exposed  
`http://localhost:8080/actuator/health` - Endpoint to use in probes for health check  
`http://localhost:8080/actuator/prometheus` - Expose application and jvm metrics  
`http://localhost:8080/actuator/metrics` - Expose metrics application  

### Docker default variables:
```Dockerfile
ENV OTEL_SDK_DISABLED=true
ENV OTEL_EXPORTER_OTLP_TRACES_ENDPOINT=http://localhost:4318/v1/metrics
ENV OTEL_SERVICE_NAME=app-name
ENV OTEL_INSTRUMENTATION_LIBRARY_NAMES=java.util.logging
```

`OTEL_SDK_DISABLED`: (On/Off Switch)  
Sets whether the OpenTelemetry SDK is entirely disabled.  
Set to true to completely turn off tracing (default).  

`OTEL_EXPORTER_OTLP_TRACES_ENDPOINT`: (URL)  
Defines the endpoint URL of the collector where trace data will be sent.  
Required if you want to export traces to a collector.

`OTEL_SERVICE_NAME`: (String)  
Identifies your application within the distributed tracing system.  
Helps understand which service generated specific traces.

`OTEL_INSTRUMENTATION_LIBRARY_NAMES`: (Comma-separated list of strings)  
Specifies the instrumentation libraries (e.g., Spring Web) that will be enabled for tracing.  
Controls which parts of your application are instrumented for trace collection.  

### Libraries used in the application

`spring-boot-starter-web`: This is the main dependency for web development with Spring Boot.  
`pring-boot-starter-actuator`: This dependency allows you to expose management endpoints for your Spring Boot application.  
`micrometer-registry-prometheus`: This dependency allows your application to expose metrics (such as number of requests, response time, memory usage) in the Prometheus format.  
`spring-boot-starter-log4j2`: It configures log4j2 for your application, allowing detailed and flexible logging of events during execution.  
`spring-boot-starter-test`: This dependency provides the essential tools for writing unit and integration tests for your Spring Boot application, it includes libraries such as JUnit and Mockito, making it easy to create test scenarios and verify the expected behavior of your application.  

### Running Application

```shell
$ make run-app
```

### Building Application artefact .jar

```shell
$ make build-package
```
Output evidence storage in `/app/target/app-v1.0.0.jar`

### Building Application to Docker

```shell
$ make docker IMAGE_NAME=java-app IMAGE_VERSION=v1.0.0
```
This step build app and docker image.  
Set environments to name image (`IMAGE_NAME`) and tag (`IMAGE_VERSION`).

### Building docker image and pushing to dockerhub
```shell
$ make docker-publish IMAGE_NAME=java-app IMAGE_VERSION=v1.0.0
```
This step build app, docker image and push to https://hub.docker.com.

### Cleaning the environment
```shell
$ make docker-publish IMAGE_NAME=yourdockerhub/java-app IMAGE_VERSION=v1.0.0
```
Cleaning `target/*` java path



### Contribute
That's it for now, I hope I can help you test your observability stack.  
If you want to contribute, feel free to make the PR or open an Issue.


----

### MIT License

Copyright (c) 2024 Gerson Carneiro

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
