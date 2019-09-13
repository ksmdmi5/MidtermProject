package com.skilldistillery.dejabrew.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Review {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String details;
	private String rating;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="brewery_id")
	private Brewery brewery;


	public Review() {
		super();
	}

	public Review(String details, String rating, User user, Brewery brewery) {
		super();
		this.details = details;
		this.rating = rating;
		this.user = user;
		this.brewery = brewery;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getRating() {
		return rating;
	}

	public void setRating(String rating) {
		this.rating = rating;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Brewery getBrewery() {
		return brewery;
	}

	public void setBrewery(Brewery brewery) {
		this.brewery = brewery;
	}

	@Override
	public String toString() {
		return "Review [id=" + id + ", details=" + details + ", rating=" + rating + ", user=" + user + ", brewery="
				+ brewery + "]";
	}

}
