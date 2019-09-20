package com.skilldistillery.dejabrew;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.skilldistillery.dejabrew.security.UserRepository;

@SpringBootApplication
@EnableJpaRepositories(basePackageClasses = UserRepository.class)
@ComponentScan(basePackages = { "com.skilldistillery.dejabrew" })
public class DejaBrewApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(DejaBrewApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(DejaBrewApplication.class, args);
	}

}
