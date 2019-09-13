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

class AddressTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Address addr;

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
		addr = em.find(Address.class, 1);
		
//		|  1 | 136 East Second Street | Salida | Colorado | 81201 |
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		addr = null;
	}
	
	@Test
	@DisplayName("Testing Address entity mapping")
	public void test1() {
		assertEquals("136 East Second Street", addr.getStreet());
		assertEquals("Salida", addr.getCity());
		assertEquals("Colorado", addr.getState());
		assertEquals("81201", addr.getZip());
	}

}
