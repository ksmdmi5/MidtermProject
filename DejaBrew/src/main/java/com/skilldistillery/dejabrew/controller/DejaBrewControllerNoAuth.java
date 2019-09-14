package com.skilldistillery.dejabrew.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.skilldistillery.dejabrew.data.DejaBrewDAO;
import com.skilldistillery.dejabrew.entities.Brewery;
import com.skilldistillery.dejabrew.entities.User;

@Controller
public class DejaBrewControllerNoAuth {
	@Autowired
	private DejaBrewDAO dao;

	// home page
	@RequestMapping(path = {"/", "/DejaBrew"})
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView();
		mv.addObject("brews", dao.showAll());
		mv.setViewName("index");
		return mv;
	}

	// handles going to details of specific brewery
	@RequestMapping(path = "details.do", method = RequestMethod.GET)
	public ModelAndView viewBrewery(Brewery brew, @RequestParam("id") int id) {
		brew = dao.findById(brew.getId());
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", brew);
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
	public ModelAndView filmAdded(@ModelAttribute("newUser") User user) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", user);
		mv.setViewName("index");
		return mv;
	}

	// handles logging in then goes to Authed Controller
	@RequestMapping(path = "login.do", method = RequestMethod.GET)
	public ModelAndView login(User user) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("user", user);
		mv.setViewName("");
		return mv;
	}

}
