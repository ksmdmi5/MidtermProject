package com.skilldistillery.dejabrew.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.dejabrew.data.DejaBrewDAO;
import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.CreateForm;
import com.skilldistillery.dejabrew.entities.Review;
import com.skilldistillery.dejabrew.entities.User;

@Controller
@SessionAttributes("loggedIn")
public class DejaBrewController {
	@Autowired
	private DejaBrewDAO dao;

	// home page
	@RequestMapping(path = { "/", "/DejaBrew" })
	public ModelAndView index(Principal principal) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("brews", dao.showAll());
		mv.addObject("loggedIn", principal);
		mv.setViewName("index");
		return mv;
	}

	// handles going to details of specific brewery
	@RequestMapping(path = "details.do", method = RequestMethod.GET)
	public ModelAndView viewBrewery(Brewery brew, @RequestParam("id") int id, Principal principal) {
		brew = dao.findById(brew.getId());
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", brew);
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
		redir.addFlashAttribute("newUser", user);
		dao.addUser(user);
		return "redirect:userAdded.do";
	}

	// after user user created it goes to index
	@RequestMapping(path = "userAdded.do", method = RequestMethod.GET)
	public String filmAdded(@ModelAttribute("newUser") User user, RedirectAttributes redir) {
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
	public String createBrewery(CreateForm breweryForm, RedirectAttributes redir) {
		redir.addFlashAttribute("newbrew", breweryForm);
		Address address = new Address(breweryForm.getStreet(), breweryForm.getCity(), breweryForm.getState(),
				breweryForm.getZip());
		dao.addAddress(address);
		dao.addBrewery(new Brewery(breweryForm.getName(), breweryForm.getDescription(), breweryForm.getUrl(), true,
				breweryForm.getMenu(), address, dao.findUserById(breweryForm.getUserId())));
		return "redirect:/DejaBrew";
	}

	// redirection goes to details of created brewery
	@RequestMapping(path = "breweryAdded.do", method = RequestMethod.GET)
	public ModelAndView filmAdded(@ModelAttribute("newBrew") Brewery brew) {
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
	public ModelAndView createReview(@RequestParam("brewery") int id,@RequestParam("details") String detail, Principal principal ) {
		Review review = new Review();
		review.setDetails(detail);
		//dao.findById(id);
		review.setUser(dao.findUserByName(principal.getName()));
		review.setBrewery(dao.findById(id));
		Review newReview = dao.addReview(review);;
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", dao.findById(id));
		mv.setViewName("details");
		return mv;
	}

	@RequestMapping(path = "updateReview.do", method = RequestMethod.GET)
	public ModelAndView editReview(@RequestParam("id") int id, Model model) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("editReview", dao.findById(id));
		mv.setViewName("brewCRUD");
		return mv;
	}

	@RequestMapping(path = "reviewEdited.do", method = RequestMethod.POST)
	public ModelAndView editReview(Review review) {
		Review updatedReview = dao.updateReview(review.getId(), review);
		ModelAndView mv = new ModelAndView();
		mv.addObject("review", updatedReview);
		mv.setViewName("details");
		return mv;
	}

	@RequestMapping(path = "deleteReview.do", method = RequestMethod.POST)
	public String deleteReview(Review review, RedirectAttributes redir) {
		boolean status = false;
		int brewId = review.getBrewery().getId();
		int userId = review.getUser().getId();
		int revId = review.getId();
		if (dao.deleteReview(revId) && dao.deleteBrewery(brewId) && dao.deleteUser(userId)) {
			status = true;
		}
		redir.addFlashAttribute("status", status);
		return "redirect:details";
	}
}
