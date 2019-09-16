package com.skilldistillery.dejabrew;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.skilldistillery.dejabrew.data.UserRepository;


@SpringBootApplication
@EnableJpaRepositories(basePackageClasses = UserRepository.class)
public class DejaBrewApplication {

	public static void main(String[] args) {
		SpringApplication.run(DejaBrewApplication.class, args);
	}

}
