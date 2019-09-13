package com.skilldistillery.dejabrew.data;

import java.util.List;

import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.User;


public interface DejaBrewDAO {
	public List<Brewery> showAll();
	
}
