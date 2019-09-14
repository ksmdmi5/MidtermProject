package com.skilldistillery.dejabrew.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.dejabrew.data.DejaBrewDAO;
import com.skilldistillery.dejabrew.entities.Address;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.CreateForm;
import com.skilldistillery.dejabrew.entities.User;

@Controller
public class DejaBrewLoggedInController {
	@Autowired
	private DejaBrewDAO dao;
	// home page
//	@RequestMapping(path = "/", "/DejaBrew")
//	public ModelAndView index() {
//		ModelAndView mv = new ModelAndView();
//		mv.setViewName("index");
//		return mv;
//	}

	// handles keyword search function
	@RequestMapping(path = "searchKeyword.do", params = "keyword", method = RequestMethod.GET)
	public ModelAndView getFilmByKeyword(String keyword) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("brews", dao.findBreweryByKeyword(keyword));
		mv.setViewName("index");
		return mv;
	}

	// goes to form to create brewery
	@RequestMapping(path = "creationFormBrewery.do", method = RequestMethod.GET)
	public ModelAndView gotoBrewForm() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", new Brewery());
		mv.setViewName("CRUD");
		return mv;
	}

	// goes to form to create user
	@RequestMapping(path = "registration.do", method = RequestMethod.GET)
	public ModelAndView gotoRegisterForm() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", new User());
		mv.setViewName("Registration");
		return mv;
	}

	// creation of brewery redirects
	@RequestMapping(path = "createBrewery.do", method = RequestMethod.POST, params = "brewForm")
	public String createBrewery(CreateForm brewForm, RedirectAttributes redir) {
		redir.addFlashAttribute("newbrew", brewForm);
		Address address = new Address(brewForm.getStreet(), brewForm.getCity(),
				brewForm.getState(), brewForm.getZip());
		dao.addAddress(address);
		dao.addBrew(brewForm.getName(), brewForm.getDescription(), brewForm.getUrl(), true,
				brewForm.getMenu(), address, brewForm.getUserId());
		return "redirect:brewFormeryAdded.do";
	}

	// redirection goes to details of created brewery
	@RequestMapping(path = "breweryAdded.do", method = RequestMethod.GET)
	public ModelAndView filmAdded(@ModelAttribute("newBrew") Brewery brew) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", brew);
		mv.setViewName("details");
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
	public ModelAndView filmAdded(@ModelAttribute("newUser") User user) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", user);
		mv.setViewName("index");
		return mv;
	}

	// goes to form to update Brewery
	@RequestMapping(path = "editBrewery.do", method = RequestMethod.GET)
	public ModelAndView editBrewery(Brewery brew) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("editBrew", dao.findById(brew.getId()));
		mv.setViewName("CRUD");
		return mv;
	}

	// after editing it goes to details page
	@RequestMapping(path = "breweryEdited.do", method = RequestMethod.POST)
	public ModelAndView editedFilm(Brewery brew) {
		dao.updateBrew(brew.getId(), brew);
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", brew);
		mv.setViewName("details");
		return mv;
	}

	// deletion redirects
	@RequestMapping(path = "deleteBrewery.do", method = RequestMethod.POST)
	public String deleteFilm(Brewery brew, RedirectAttributes redir) {
		redir.addFlashAttribute("status", dao.destroy(brew.getId()));
		return "redirect:breweryDeleted.do";

	}

	// redirects to index
	@RequestMapping(path = "breweryDeleted.do", method = RequestMethod.GET)
	public ModelAndView filmDeleted(@ModelAttribute("status") String status) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("deletedStatus", status);
		mv.setViewName("index");
		return mv;

	}
}
