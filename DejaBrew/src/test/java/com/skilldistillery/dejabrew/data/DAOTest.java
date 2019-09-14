package com.skilldistillery.dejabrew.data;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.Test;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;

class DAOTest {

	private DejaBrewDAO dao;
	
	@BeforeEach
	void setUp() throws Exception {
		dao = new DejaBrewDAOImpl();
	}

	@AfterEach
	void tearDown() throws Exception {
		dao = null;
	}

	@Test
	void test() {
		System.out.println("hello");
		assertEquals(55, dao.findById(55).getDescription().length());
	}

}
