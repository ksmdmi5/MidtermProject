package com.skilldistillery.dejabrew.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.dejabrew.entities.Brewery;

@Transactional
@Service
public class DejaBrewDAOImpl implements DejaBrewDAO {
	
	@PersistenceContext
	private EntityManager em;

	@Override
	public List<Brewery> showAll() {
		String query = "SELECT brewery FROM Brewery brewery ORDER BY id";
		return em.createQuery(query, Brewery.class).getResultList();
	}
//	CF - find Brewery entity by id
	@Override
	public Brewery findById(int id) {
		return em.find(Brewery.class, 1);
	}
//	CF - find Brewery entity name, desc, and city by keyword
	@Override
	public List<Brewery> findBreweryByKeyword(String keyword) {
		return em.createQuery("SELECT brew FROM Brewery brew WHERE brew.name LIKE :keyword"
				+ " OR brew.description LIKE :keyword OR brew.address.city"
				+ " LIKE :keyword", Brewery.class)
				.setParameter("keyword", "%"+keyword+"%").getResultList();
	}
	
	
}
