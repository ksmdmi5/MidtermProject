package com.skilldistillery.dejabrew.data;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Beer;
import com.skilldistillery.dejabrew.entities.BeerType;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.Review;
import com.skilldistillery.dejabrew.entities.User;

@Transactional
@Service
public class DejaBrewDAOImpl implements DejaBrewDAO {

	@PersistenceContext
	private EntityManager em;

//	CF - find User entity by id
	@Override
	public User findUserById(int id) {
		return em.find(User.class, id);
	}
	public Review findReviewById(int id) {
		return em.find(Review.class, id);
	}

	@Override
	public User findUserByName(String name) {
		String query = "SELECT user FROM User user where user.username = :name";
		return em.createQuery(query, User.class).setParameter("name", name).getResultList().get(0);
	}

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
		return em
				.createQuery(
						"SELECT brew FROM Brewery brew WHERE brew.name LIKE :keyword"
								+ " OR brew.description LIKE :keyword OR brew.address.city" + " LIKE :keyword",
						Brewery.class)
				.setParameter("keyword", "%" + keyword + "%").getResultList();
	}

	@Override
	public Brewery updateBrew(int id, Brewery brew) {
		Brewery chgBrew = em.find(Brewery.class, id);
		chgBrew.setName(brew.getName());
		chgBrew.setAddress(updateAddress(brew.getAddress().getId(), brew.getAddress()));
		chgBrew.setUrl(brew.getUrl());
		chgBrew.setDescription(brew.getDescription());
		chgBrew.setActive(brew.isActive());
		em.persist(chgBrew);
		em.flush();
		em.close();

		return chgBrew;
	}

	@Override
	public Brewery addBrewery(Brewery brew) {
		em.persist(brew);
		em.flush();
		return em.find(Brewery.class, brew.getId());
	}

	@Override
	public boolean deleteBrewery(int id) {
		try {
			Brewery brew = em.find(Brewery.class, id);
			List<Beer> beers = brew.getBeers();
			for (Beer beer : beers) {
				em.remove(beer);
			}
			em.remove(brew);
		} catch (Exception e) {
			return false;
		}
		em.close();
		return true;
	}

	@Override
	public User addUser(User user) {
		em.persist(user);
		em.flush();
		return em.find(User.class, user.getId());
	}

	@Override
	public boolean deleteUser(int id) {
		try {
			em.remove(em.find(User.class, id));
		} catch (Exception e) {
			return false;
		}
		em.close();
		return true;
	}
	

	@Override
	public Beer addBeer(Beer beer) {
		em.persist(beer);
		em.flush();
		return em.find(Beer.class, beer.getId());
	}

	@Override
	public Address addAddress(Address address) {
		em.persist(address);
		em.flush();
		return em.find(Address.class, address.getId());
	}

	@Override
	public boolean deleteAddress(int id) {
		try {
			System.out.println(id);
			em.remove(em.find(Address.class, id));
		} catch (Exception e) {
			return false;
		}
		em.close();
		return true;
	}

	@Override
	public Review addReview(Review review) {
		review.setRating(review.getRating());
		review.setDateReviewed(LocalDate.now());
		em.persist(review);
		em.flush();
		return em.find(Review.class, review.getId());
	}

	@Override
	public Review updateReview(int id, Review review) {
		Review chgReview = em.find(Review.class, id);
		chgReview.setRating(review.getRating());
		chgReview.setDetails(review.getDetails());
		chgReview.setDateReviewed(LocalDate.now());
		em.persist(chgReview);
		em.flush();
		em.close();

		return chgReview;
	}

	@Override
	public boolean deleteReview(int id) {
		try {
			System.out.println(id);
			em.remove(em.find(Review.class, id));
		} catch (Exception e) {
			return false;
		}
		em.close();
		return true;
	}

	@Override
	public Address updateAddress(int id, Address addr) {
		Address chgAddr = em.find(Address.class, id);
		chgAddr.setCity(addr.getCity());
		chgAddr.setState(addr.getState());
		chgAddr.setStreet(addr.getStreet());
		chgAddr.setZip(addr.getZip());
		em.persist(chgAddr);
		em.flush();
		em.close();

		return chgAddr;
	}

	@Override
	public BeerType findByBeerType(int id) {
		return em.find(BeerType.class, id);
	}
}
