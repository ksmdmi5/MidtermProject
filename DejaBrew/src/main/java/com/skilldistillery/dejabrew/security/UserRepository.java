package com.skilldistillery.dejabrew.security;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.dejabrew.entities.User;


public interface UserRepository extends JpaRepository<User, Integer> {
	Optional<User> findByUsername(String username);
}
