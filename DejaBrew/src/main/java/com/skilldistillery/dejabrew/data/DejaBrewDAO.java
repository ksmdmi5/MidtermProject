package com.skilldistillery.dejabrew.data;

import java.util.List;

import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Beer;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.Review;
import com.skilldistillery.dejabrew.entities.User;


public interface DejaBrewDAO {
	Brewery findById(int id);
	Review findReviewById(int id);
	List<Brewery> showAll();
	List<Brewery> findBreweryByKeyword(String keyword);
	Brewery updateBrew(int id, Brewery brew);
	Address updateAddress(int id, Address address);
	Brewery addBrewery(Brewery brew);
	Address addAddress(Address address);
	User addUser(User user);
	boolean deleteUser(int id);
	User findUserById(int id);
	Review addReview(Review review);
	Review updateReview(int id, Review review);
	boolean deleteReview(int id);
	Beer addBeer(Beer beer);
	boolean deleteBrewery(int id);
	boolean deleteUser(int id, User user);
	boolean deleteAddress(int id);

}
