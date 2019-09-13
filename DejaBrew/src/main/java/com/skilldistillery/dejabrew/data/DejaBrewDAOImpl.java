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
}
