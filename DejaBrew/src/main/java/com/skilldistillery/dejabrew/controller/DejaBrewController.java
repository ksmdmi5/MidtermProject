package com.skilldistillery.dejabrew.controller;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.dejabrew.data.DejaBrewDAO;
import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Beer;
import com.skilldistillery.dejabrew.entities.BeerType;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.CreateForm;
import com.skilldistillery.dejabrew.entities.Review;
import com.skilldistillery.dejabrew.entities.User;

@Controller
@SessionAttributes({"loggedIn", "auth"})
public class DejaBrewController {
	@Autowired
	private DejaBrewDAO dao;

	// home page
	@RequestMapping(path = { "/", "/DejaBrew" })
	public ModelAndView index(Principal principal) {
		ModelAndView mv = new ModelAndView();
		List<Brewery> brews = dao.showAll();
		for (Brewery brewery : brews) {
//			brewery.setDescription(brews.get(0));
		}
		mv.addObject("auth", SecurityContextHolder.getContext().getAuthentication().getAuthorities());
		mv.addObject("brews", dao.showAll());
		mv.addObject("loggedIn", principal);
		mv.setViewName("index");
		return mv;
	}

	// handles going to details of specific brewery
	@RequestMapping(path = "details.do", method = RequestMethod.GET)
	public ModelAndView viewBrewery(Brewery brew, Principal principal) {
		brew = dao.findById(brew.getId());
		ModelAndView mv = new ModelAndView();
		Beer beer = new Beer();
		beer.setTypes(dao.getAllBeerTypes());
		mv.addObject("auth", SecurityContextHolder.getContext().getAuthentication().getAuthorities());
		mv.addObject("review", new Review());
		mv.addObject("brew", brew);
		mv.addObject("types", beer);
		mv.addObject("loggedIn", principal);
		mv.setViewName("details");
		return mv;
	}
	
	// handles going to details of specific brewery
	@RequestMapping(path = "userBrewDetails.do", method = RequestMethod.GET)
	public ModelAndView userBrewDetails(@RequestParam("brewId")int brewId, Principal principal) {
		System.err.println("*******************************" + brewId);
		Brewery brew = dao.findById(brewId);
		ModelAndView mv = new ModelAndView();
		Beer beer = new Beer();
		beer.setTypes(dao.getAllBeerTypes());
		mv.addObject("auth", SecurityContextHolder.getContext().getAuthentication().getAuthorities());
		mv.addObject("review", new Review());
		mv.addObject("brew", brew);
		mv.addObject("types", beer);
		mv.addObject("loggedIn", principal);
		mv.setViewName("details");
		return mv;
	}

	// handles keyword search function
	@RequestMapping(path = "searchKeyword.do", params = "keyword", method = RequestMethod.GET)
	public ModelAndView getFilmByKeyword(String keyword) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("brews", dao.findBreweryByKeyword(keyword));
		mv.setViewName("index");
		return mv;
	}

	// goes to form to create user
	@RequestMapping(path = "registration.do", method = RequestMethod.GET)
	public ModelAndView gotoForm() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", new User());
		mv.setViewName("register");
		return mv;
	}

	// creation of user redirects
	@RequestMapping(path = "createUser.do", method = RequestMethod.POST)
	public String createBrewery(User user, RedirectAttributes redir) {
		try {
			dao.addUser(user);
			redir.addFlashAttribute("newUser", user);
			return "redirect:userAdded.do";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error";
		}
	}
	

	// after user user created it goes to index
	@RequestMapping(path = "userAdded.do", method = RequestMethod.GET)
	public String userAdded(@ModelAttribute("newUser") User user, RedirectAttributes redir) {
		redir.addFlashAttribute("user", user);
		return "redirect:/DejaBrew";
	}

	@RequestMapping(path = "login", method = RequestMethod.GET)
	public ModelAndView login(User user) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", user);
		mv.setViewName("login");
		return mv;
	}

	// goes to form to create brewery
	@RequestMapping(path = "creationFormBrewery.do", method = RequestMethod.GET)
	public ModelAndView gotoBrewForm() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", new Brewery());
		mv.setViewName("brewCRUD");
		return mv;
	}

	// creation of brewery redirects
	@RequestMapping(path = "createBrewery.do", method = RequestMethod.POST)
	public String createBrewery(CreateForm breweryForm, RedirectAttributes redir, Principal principal) {
		redir.addFlashAttribute("newbrew", breweryForm);
		
		Address address = new Address(breweryForm.getStreet(), breweryForm.getCity(), breweryForm.getState(),
				breweryForm.getZip());
		
		dao.addAddress(address);
		
//		dao.addBrewery(new Brewery(breweryForm.getName(), breweryForm.getDescription(), breweryForm.getUrl(), true,
//				breweryForm.getMenu(), address, dao.findUserById(breweryForm.getUserId())));

		dao.addBrewery(new Brewery(breweryForm.getName(), breweryForm.getDescription(), breweryForm.getUrl(), true,
				breweryForm.getMenu(), address, dao.findUserByName(principal.getName())));
		return "redirect:/DejaBrew";
	}

	// redirection goes to details of created brewery
	@RequestMapping(path = "breweryAdded.do", method = RequestMethod.GET)
	public ModelAndView breweryAdded(@ModelAttribute("newBrew") Brewery brew) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", brew);
		mv.setViewName("details");
		return mv;
	}

	// after editing it goes to details page
	@RequestMapping(path = "breweryEdited.do", method = RequestMethod.POST)
	public ModelAndView editBrewery(@RequestParam("brewId") int id, CreateForm breweryForm) {
		ModelAndView mv = new ModelAndView();
		int addrId = dao.findById(id).getAddress().getId();
		
		Address address = new Address(breweryForm.getStreet(), breweryForm.getCity(), breweryForm.getState(),
				breweryForm.getZip());
		
		address.setId(addrId);
		dao.updateAddress(addrId, address);
		
		dao.updateBrew(id, new Brewery(breweryForm.getName(), breweryForm.getDescription(), breweryForm.getUrl(), true,
				breweryForm.getMenu(), address, dao.findUserById(breweryForm.getUserId())));
		
		mv.addObject("brew", dao.findById(id));
		mv.setViewName("details");
		return mv;
	}

	// goes to form to update Brewery
	@RequestMapping(path = "editBrewery.do", method = RequestMethod.GET)
	public ModelAndView editedBrewery(Brewery brew) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("editBrew", dao.findById(brew.getId()));
		mv.setViewName("brewCRUD");
		return mv;
	}

	// deletion redirects
	@RequestMapping(path = "deleteBrewery.do", method = RequestMethod.POST)
	public String deleteBrewery(Brewery brew, RedirectAttributes redir) {
		boolean status = false;
		brew = dao.findById(brew.getId());
		int addrId = brew.getAddress().getId();
		int brewId = brew.getId();
		if (dao.deleteBrewery(brewId) && dao.deleteAddress(addrId)) {
			status = true;
		}
		redir.addFlashAttribute("status", status);

		return "redirect:/DejaBrew";

	}

	// allows user to create a Review
	@RequestMapping(path = "createReview.do", method = RequestMethod.POST)
	public ModelAndView createReview(Principal principal, Review review, @RequestParam("breweryID") int id) {
		review.setUser(dao.findUserByName(principal.getName()));
		review.setBrewery(dao.findById(id));
		dao.addReview(review);
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", dao.findById(review.getBrewery().getId()));
		mv.setViewName("details");
		return mv;
	}

	@RequestMapping(path = "updateReview.do", method = RequestMethod.POST, params = { "breweryID", "reviewID" })
	public ModelAndView editReview(Review review, int breweryID, int reviewID) {
		dao.updateReview(reviewID, review);
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", dao.findById(breweryID));
		mv.setViewName("details");
		return mv;
	}

	@RequestMapping(path = "deleteReview.do", method = RequestMethod.POST, params = { "brewID", "reviewID" })
	public ModelAndView deleteReview(int reviewID, int brewID) {
		ModelAndView mv = new ModelAndView("details");
		mv.addObject("brew", dao.findById(brewID));
		dao.deleteReview(reviewID);
		return mv;
	}

	@RequestMapping(path = "addBeer.do", method = RequestMethod.POST, params = { "beerTypeId", "beerName", "brewId" })
	public ModelAndView addBeer(int beerTypeId, String beerName, int brewId) {
		ModelAndView mv = new ModelAndView();
		Beer beer = new Beer();
		beer.setBrewery(dao.findById(brewId));
		List<BeerType> types = Arrays.asList(dao.findByBeerType(beerTypeId));
		beer.setTypes(types);
		beer.setName(beerName);
		dao.addBeer(beer);
		mv.addObject("brew", dao.findById(brewId));

		mv.setViewName("details");
		return mv;
	}

	// Shows list of users
	@RequestMapping(path = "admin.do")
	public ModelAndView showUsers(Principal principal) {
		List<User> users = dao.showAllUsers();
		ModelAndView mv = new ModelAndView();
		mv.addObject("users", dao.showAllUsers());
		mv.addObject("loggedIn", principal);
		mv.setViewName("admin");
		return mv;
	}

	// Delete user, only intended for admin
	@RequestMapping(path = "deleteUser.do", method = RequestMethod.POST)
	public ModelAndView deleteUser(int id) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("id", id);
		dao.deleteUser(id);
		mv.addObject("users", dao.showAllUsers());
		mv.setViewName("admin");
		return mv;
	}

//	//User can see their comments on their account page
	@RequestMapping(path = "user.do", method = RequestMethod.GET)
	public ModelAndView showUserComments(Review review, Principal principal) {
		ModelAndView mv = new ModelAndView();
		List<Review> reviews = dao.showUserComments(dao.findUserByName(principal.getName()).getId());
		mv.addObject("reviews", reviews);
		mv.addObject("loggedIn", principal);
		mv.setViewName("user");
		return mv;
	}

}
