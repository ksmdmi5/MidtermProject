package com.skilldistillery.dejabrew.data;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.User;

class DAOtests {
	private DejaBrewDAO dao;
	@BeforeEach
	void setUp() throws Exception {
		dao = new DejaBrewDAOImpl();
		
	}

	@AfterEach
	void tearDown() throws Exception {
		dao = null;
	}
//	@Disabled
	@Test
	void test() {
		assertEquals(1,dao.findById(55).getDescription().length());
	}
	@Disabled
	@Test
	void test2() {
		assertEquals(47,dao.showAll().size());
	}
	@Disabled
	@Test
	@DisplayName("")
	void test3() {
		User user1 = new User("asdf", "asdf", true,"asdf");
		user1.setId(3);
		Address addy = new Address("Fake st", "fake state", "fake city", "12347");
		addy.setId(5);
		Brewery brew = new Brewery("fred", "fred", "fred", true, true,addy, user1 );
		brew.setBeers(null);
		brew.setReviews(null);
		assertEquals("fred", dao.addBrewery(brew).getName());
	}

}
