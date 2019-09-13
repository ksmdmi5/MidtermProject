package com.skilldistillery.dejabrew.data;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

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
		assertEquals(1, dao.findById(2).getId());
	}

}
