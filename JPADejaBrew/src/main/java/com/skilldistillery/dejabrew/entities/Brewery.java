package com.skilldistillery.dejabrew.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Brewery {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String description;
	private String url;
	private boolean active;
	private boolean menu;
	private String logourl;

	@OneToMany(mappedBy = "brewery")
	private List<Review> reviews;

	@OneToMany(mappedBy = "brewery")
	private List<Beer> beers = new ArrayList<>();

	@OneToOne
	@JoinColumn(name = "address_id")
	private Address address;

	@ManyToOne
	@JoinColumn(name = "createdby_user")
	private User user;

	public Brewery() {
	}
	
	public Brewery(String name, String description, String url, boolean active, Boolean menu, Address address,
			User user) {
		super();
		this.name = name;
		this.description = description;
		this.url = url;
		this.active = active;
		this.menu = menu;
		this.address = address;
		this.user = user;
	}

	public void addReview(Review review) {
		if (reviews == null) {
			reviews = new ArrayList<>();
		}

		if (!reviews.contains(review)) {
			reviews.add(review);
			if (review.getBrewery() != null) {
				review.getBrewery().getReviews().remove(review);
			}
			review.setBrewery(this);
		}
	}

	public void removeReview(Review review) {
		review.setBrewery(null);
		if (reviews != null) {
			reviews.remove(review);
		}
	}

	public void addBeer(Beer beer) {
		if (beers == null) {
			beers = new ArrayList<>();
		}

		if (!beers.contains(beer)) {
			beers.add(beer);
			if (beer.getBrewery() != null) {
				beer.getBrewery().getBeers().remove(beer);
			}
			beer.setBrewery(this);
		}
	}

	public void removeBeer(Beer beer) {
		beer.setBrewery(null);
		if (beers != null) {
			beers.remove(beer);
		}
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public Boolean getMenu() {
		return menu;
	}

	public void setMenu(Boolean menu) {
		this.menu = menu;
	}

	public List<Review> getReviews() {
		return new ArrayList<>(reviews);
	}

	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Beer> getBeers() {
		return new ArrayList<>(beers);
	}

	public void setBeers(List<Beer> beers) {
		this.beers = beers;
	}

	public String getLogourl() {
		return logourl;
	}

	public void setLogourl(String logourl) {
		this.logourl = logourl;
	}

	public void setMenu(boolean menu) {
		this.menu = menu;
	}

	@Override
	public String toString() {
		return "Brewery [id=" + id + ", name=" + name;// + ", description=" + description + ", url=" + url + ", active="
				//+ active + ", menu=" + menu + ", address=" + address + "]";
	}

}
