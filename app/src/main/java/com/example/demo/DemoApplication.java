package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import java.util.concurrent.atomic.AtomicInteger;

@SpringBootApplication
@RestController
public class DemoApplication {

    private final AtomicInteger counter = new AtomicInteger(0); // Thread-safe counter

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    @GetMapping("/")
    public String incrementCounter() {
        int currentCount = counter.incrementAndGet();
        return "Count current requests: " + currentCount;
    }

    @GetMapping("/**")  // Captures any route that is not explicitly mapped
    public ResponseEntity<String> notFound() {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("404 Página não encontrada!!!");
    }

}