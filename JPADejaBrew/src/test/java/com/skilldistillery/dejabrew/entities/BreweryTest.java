package com.skilldistillery.dejabrew.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

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
		emf = Persistence.createEntityManagerFactory("DejaBrew");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		brew = em.find(Brewery.class, 2);
		
//		|  2 |          2 |              1 | Avery Brewing Company |      1 | Established in 1993, Avery Brewing Co. is a family owned and operated micro-brewery dedicated to brewing the finest quality English and Belgian style ales.. From humble beginnings, brewing 800 barrels of three different beers in 1994, we have progressed to brewing 13,000 barrels of twenty different beers in 2007. We attribute this success to beer drinkers gravitating to beers with more interesting flavor profiles. The unique flavor complexity of Avery beers occurs through a combination of sparing no expense with regard to ingredients and our hopping methods. Sparing no expense means using lots of specialty malts, imported hops, such as Styrian Goldings, and imported Belgian candy sugar. | http://www.averybrewing.com/ |    1 |

	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		brew = null;
	}
	
	@Test
	@DisplayName("Testing Brewery entity mapping")
	public void test1() {
		assertEquals(2, brew.getAddress().getId());
		assertEquals(1, brew.getUser().getId());
		assertEquals("Avery Brewing Company", brew.getName());
		assertTrue(brew.isActive());
		assertEquals("Established in 1993", brew.getDescription().substring(0,19));
		assertEquals("http://www.averybrewing.com/", brew.getUrl());
		assertTrue(brew.getMenu());
	}

}
