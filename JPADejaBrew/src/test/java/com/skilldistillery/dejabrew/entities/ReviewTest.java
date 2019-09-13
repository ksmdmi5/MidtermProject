package com.skilldistillery.dejabrew.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.time.LocalDate;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class ReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Review review;

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
		review = em.find(Review.class, 1);
		
//		|  1 |       1 |          1 |      4 | great beer, avg service | NULL          |
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		review = null;
	}
	
	@Test
	@DisplayName("Testing Review entity mapping")
	public void test1() {
		assertEquals(1, review.getUser().getId());
		assertEquals(1, review.getBrewery().getId());
		assertEquals(4, review.getRating());
		assertEquals("great beer, avg service", review.getDetails());
		assertEquals(4, review.getRating());
		
		review.setDateReviewed(LocalDate.now());
		assertEquals(LocalDate.now(), review.getDateReviewed());
	}

}
