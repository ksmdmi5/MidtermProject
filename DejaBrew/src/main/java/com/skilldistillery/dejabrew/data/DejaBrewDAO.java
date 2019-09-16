package com.skilldistillery.dejabrew.data;

import java.util.List;

import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Beer;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.Review;
import com.skilldistillery.dejabrew.entities.User;


public interface DejaBrewDAO {
	Brewery findById(int id);
	List<Brewery> showAll();
	List<Brewery> findBreweryByKeyword(String keyword);
	User findUserById(int id);
	Brewery updateBrew(int id, Brewery brew);
	Address updateAddress(int id, Address address);
	Brewery addBrewery(Brewery brew);
	Address addAddress(Address address);
	User addUser(User user);
<<<<<<< HEAD
	boolean deleteUser(int id);
	User findUserById(int id);
	Review addReview(Review review);
	Review updateReview(int id, Review review);
	boolean deleteReview(int id);
=======
	Beer addBeer(Beer beer);
	boolean deleteBrewery(int id);
	boolean deleteUser(int id, User user);
>>>>>>> 41119c7fa9387618a38134d26e2fc4bd7d4a0eab
	boolean deleteAddress(int id);

}
