package com.skilldistillery.dejabrew.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

	@Entity
	public class User {
		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private int id;

		private String username;
		private String password;
		private Boolean enabled;
		private String role;
		
		@OneToMany(mappedBy = "user")
		private List<Review> reviews;
		
		@OneToMany(mappedBy = "user")
		private List<Brewery> breweries;
		
		
		public User() {
		}
		
		public User(String username, String password, Boolean enabled, String role) {
			super();
			this.username = username;
			this.password = password;
			this.enabled = enabled;
			this.role = role;
		}

		public void addReview(Review review) {
			if(reviews == null) {
				reviews = new ArrayList<>();
			}
			
			if(!reviews.contains(review)) {
				reviews.add(review);
				if(review.getUser() != null) {
					review.getUser().getReviews().remove(review);
				}
				review.setUser(this);
			}
		}
		
		public void removeReview(Review review) {
			review.setUser(null);
			if(reviews != null) {
				reviews.remove(review);
			}
		}

		public void addBrewery(Brewery brewery) {
			if(breweries == null) {
				breweries = new ArrayList<>();
			}
			
			if(!breweries.contains(brewery)) {
				breweries.add(brewery);
				if(brewery.getUser() != null) {
					brewery.getUser().getBreweries().remove(brewery);
				}
				brewery.setUser(this);
			}
		}
		
		public void removeBrewery(Brewery brewery) {
			brewery.setUser(null);
			if(breweries != null) {
				breweries.remove(brewery);
			}
		}
		
		public List<Brewery> getBreweries() {
			return new ArrayList<>(breweries);
		}

		public void setBreweries(List<Brewery> breweries) {
			this.breweries = breweries;
		}

		public Boolean getEnabled() {
			return enabled;
		}

		public void setEnabled(Boolean enabled) {
			this.enabled = enabled;
		}

		public List<Review> getReviews() {
			return new ArrayList<>(reviews);
		}

		public void setReviews(List<Review> reviews) {
			this.reviews = reviews;
		}

		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getUsername() {
			return username;
		}
		public void setUsername(String username) {
			this.username = username;
		}
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}
		public boolean isEnabled() {
			return enabled;
		}
		public void setEnabled(boolean enabled) {
			this.enabled = enabled;
		}
		public String getRole() {
			return role;
		}
		public void setRole(String role) {
			this.role = role;
		}
		
		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + id;
			return result;
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			User other = (User) obj;
			if (id != other.id)
				return false;
			return true;
		}

		@Override
		public String toString() {
			return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
					+ ", role=" + role + ", reviews=" + reviews + "]";
		}


}
