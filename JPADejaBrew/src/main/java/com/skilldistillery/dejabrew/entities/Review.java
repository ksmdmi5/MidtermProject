package com.skilldistillery.dejabrew.entities;

import java.time.LocalDate;

import javax.persistence.Column;
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
	private Integer rating;
	@Column(name="date_reviewed")
	private LocalDate dateReviewed; 
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="brewery_id")
	private Brewery brewery;


	public Review() {
		super();
	}

	
	public Review(String details, Integer rating, LocalDate dateReviewed, User user, Brewery brewery) {
		super();
		this.details = details;
		this.rating = rating;
		this.dateReviewed = dateReviewed;
		this.user = user;
		this.brewery = brewery;
	}

	public LocalDate getDateReviewed() {
		return dateReviewed;
	}

	public void setDateReviewed(LocalDate dateReviewed) {
		this.dateReviewed = dateReviewed;
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

	public Integer getRating() {
		return rating;
	}

	public void setRating(Integer rating) {
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
		return "Review [id=" + id + ", details=" + details + ", rating=" + rating + ", dateReviewed=" + dateReviewed
				+ "]";
	}

}