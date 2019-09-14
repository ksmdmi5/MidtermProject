package com.skilldistillery.dejabrew.data;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

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
	@Disabled
	@Test
	void test() {
		assertEquals(1,dao.findById(1).getId());
	}
	@Test
	void test2() {
		assertEquals(47,dao.showAll().size());
	}

}
