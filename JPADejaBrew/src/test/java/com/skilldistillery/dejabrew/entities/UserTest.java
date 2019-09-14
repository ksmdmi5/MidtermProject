package com.skilldistillery.dejabrew.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UserTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("DejaBrew");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}


	@Test
	void test_user_entity_mapping() {
		assertEquals("fred" ,user.getUsername());
		assertEquals("password", user.getPassword());
		user.setRole("admin");
		assertEquals("admin", user.getRole());
		user.setEnabled(false);
		assertFalse(user.getEnabled());
		assertEquals(1, user.getReviews().size());
		assertEquals(47, user.getBreweries().size());
	}
	
	@Test
	@DisplayName("Testing add/remove brewery")
	public void test2() {
		Brewery brewery = new Brewery();
		user.addBrewery(brewery);
		assertEquals(48, user.getBreweries().size());
		user.removeBrewery(brewery);
		assertEquals(47, user.getBreweries().size());
	}
	
	@Test
	@DisplayName("Testing add/remove review")
	public void test3() {
		Review review = new Review();
		user.addReview(review);
		assertEquals(2, user.getReviews().size());
		user.removeReview(review);
		assertEquals(1, user.getReviews().size());
	}

}
