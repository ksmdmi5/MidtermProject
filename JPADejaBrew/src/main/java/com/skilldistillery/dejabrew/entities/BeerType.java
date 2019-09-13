package com.skilldistillery.dejabrew.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name = "beer_type")
public class BeerType {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String description;

	@ManyToMany(mappedBy = "types")
	private List<Beer> beers;

	public BeerType() {
	}

	public BeerType(String name, String description) {
		super();
		this.name = name;
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

	public List<Beer> getBeers() {
		return new ArrayList<>(beers);
	}

	public void setBeers(List<Beer> beers) {
		this.beers = beers;
	}

	@Override
	public String toString() {
		return "BeerType [id=" + id + ", name=" + name + ", description=" + description + ", beers=" + beers + "]";
	}

}
