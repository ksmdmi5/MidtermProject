package com.skilldistillery.dejabrew.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class BeerTypeTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private BeerType beer;

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
		beer = em.find(BeerType.class, 1);
		
//		|  1 | I.P.A                   | NULL        |
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		beer = null;
	}

	@Test
	@DisplayName("Testing Beer entity mapping")
	public void test1() {
		assertEquals("I.P.A", beer.getName());
		assertEquals(1, beer.getBeers().size());

		beer.setDescription("hello, World");
		assertEquals("hello, World", beer.getDescription());
	}
}
