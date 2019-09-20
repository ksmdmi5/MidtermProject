package com.skilldistillery.dejabrew;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.skilldistillery.dejabrew.security.UserRepository;


@SpringBootApplication
@EnableJpaRepositories(basePackageClasses = UserRepository.class)
@ComponentScan(basePackages = { "com.skilldistillery.dejabrew" })
public class DejaBrewApplication {

	public static void main(String[] args) {
		SpringApplication.run(DejaBrewApplication.class, args);
	}

}
