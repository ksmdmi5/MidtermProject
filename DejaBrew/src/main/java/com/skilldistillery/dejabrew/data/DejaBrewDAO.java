package com.skilldistillery.dejabrew.data;

import java.util.List;

import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.User;


public interface DejaBrewDAO {
	public List<Brewery> showAll();
	public Brewery findById(int id);
	public List<Brewery> findBreweryByKeyword(String keyword);
	Brewery updateBrew(int id, Brewery brew);
	Brewery addBrewery(Brewery brew);
	Brewery deleteBrewery(int id);
	public Address addAddress(Address address);
	public User addUser(User user);
	public boolean deleteUser(int id, User user);
	User findUserById(int id);

}
