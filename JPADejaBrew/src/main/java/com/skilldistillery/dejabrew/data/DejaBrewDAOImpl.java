package com.skilldistillery.dejabrew.data;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.skilldistillery.dejabrew.entities.Brewery;

public class DejaBrewDAOImpl implements DejaBrewDAO {
	
	private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DejaBrew");
	private EntityManager em = emf.createEntityManager();

	@Override
	public List<Brewery> showAll() {
		String query = "SELECT brewery FROM Brewery brewery ORDER BY id";
		return em.createQuery(query, Brewery.class).getResultList();
	}
//	CF - find Brewery entity by id
	@Override
	public Brewery findById(int id) {
		return em.find(Brewery.class, id);
	}
//	CF - find Brewery entity name, desc, and city by keyword
	@Override
	public List<Brewery> findBreweryByKeyword(String keyword) {
		return em.createQuery("SELECT brew FROM Brewery brew WHERE brew.name LIKE :keyword"
				+ " OR brew.description LIKE :keyword OR brew.address.city"
				+ " LIKE :keyword", Brewery.class)
				.setParameter("keyword", "%"+keyword+"%").getResultList();
	}
	
	@Override
	public Brewery updateBrew(int id, Brewery brew) {
		
		em.getTransaction().begin();
		Brewery chgBrew = em.find(Brewery.class, id);
		chgBrew.setName(brew.getName());
		chgBrew.setAddress(brew.getAddress());
		chgBrew.setBeers(brew.getBeers());
		chgBrew.setUrl(brew.getUrl());
		chgBrew.setDescription(brew.getDescription());
		chgBrew.setActive(brew.isActive());
		chgBrew.setReviews(brew.getReviews());
		em.persist(chgBrew);
		em.flush();
		em.getTransaction().commit();
		em.close();
		
		return chgBrew;
	}
	
	@Override
	public Brewery addBrewery(Brewery brew) {
		em.getTransaction().begin();
		em.persist(brew);
		em.flush();
		em.getTransaction().commit();
		return em.find(Brewery.class, brew.getId());
	}
	
	
}
