package com.skilldistillery.dejabrew.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;

@Entity
public class Beer {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@ManyToOne
	@JoinColumn(name = "brewery_id")
	private Brewery brewery;
	
	@ManyToMany
	@JoinTable(name="beer_has_type",
			joinColumns = @JoinColumn(name="beer_id"),
			inverseJoinColumns = @JoinColumn(name="beer_type_id"))
	private List<BeerType> types;
	
	
	public Beer() {
	}

	public Beer(String name, Brewery brewery) {
		super();
		this.name = name;
		this.brewery = brewery;
	}
	
	public Brewery getBrewery() {
		return brewery;
	}

	public void setBrewery(Brewery brewery) {
		this.brewery = brewery;
	}

	public List<BeerType> getTypes() {
		return new ArrayList<>(types);
	}

	public void setTypes(List<BeerType> types) {
		this.types = types;
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
		Beer other = (Beer) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Beer [id=" + id + ", name=" + name + ", brewery=" + brewery + ", types=" + types + "]";
	}

}
