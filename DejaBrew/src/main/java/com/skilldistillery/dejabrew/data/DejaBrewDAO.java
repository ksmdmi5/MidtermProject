package com.skilldistillery.dejabrew.data;

import java.util.List;

import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Beer;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.Review;
import com.skilldistillery.dejabrew.entities.User;

public interface DejaBrewDAO {

	Brewery findById(int id);
	User findUserById(int id);
	List<Brewery> showAll();
	List<Brewery> findBreweryByKeyword(String keyword);
	Address updateAddress(int id, Address addr);
	Review updateReview(int id, Review review);
	Brewery updateBrew(int id, Brewery brew);
	Brewery addBrewery(Brewery brew);
	User addUser(User user);
	Beer addBeer(Beer beer);
	Review addReview(Review review);
	Address addAddress(Address address);
	boolean deleteBrewery(int id);
	boolean deleteUser(int id);
	boolean deleteAddress(int id);
	boolean deleteReview(int id);

}
