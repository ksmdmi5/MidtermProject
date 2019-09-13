package com.skilldistillery.dejabrew.entities;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class BreweryTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Brewery brew;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("VideoStore");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		brew = em.find(Brewery.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		brew = null;
	}
	
	@Test
	@DisplayName("Testing Brewery entity mapping")
	public void test1() {
		
	}

}
