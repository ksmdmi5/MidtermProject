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

@Controller
public class DejaBrewLoggedInController {
	@Autowired
	private DejaBrewDAO dao;

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
		Address address = new Address(breweryForm.getStreet(), breweryForm.getCity(),
				breweryForm.getState(), breweryForm.getZip());
		dao.addAddress(address);
		dao.addBrewery(new Brewery(breweryForm.getName(), breweryForm.getDescription(), breweryForm.getUrl(), 
				true, breweryForm.getMenu(), address, dao.findUserById(breweryForm.getUserId())));
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

	// goes to form to update Brewery
	@RequestMapping(path = "editBrewery.do", method = RequestMethod.GET)
	public ModelAndView editBrewery(Brewery brew) {
		ModelAndView mv = new ModelAndView();
		mv.addObject("editBrew", dao.findById(brew.getId()));
		mv.setViewName("brewCRUD");
		return mv;
	}

	// after editing it goes to details page
	@RequestMapping(path = "breweryEdited.do", method = RequestMethod.POST)
	public ModelAndView editedBrewery(Brewery brew) {
		System.out.println("before update " + brew);
		dao.updateBrew(brew.getId(), brew);
		System.out.println("after update " + brew);
		ModelAndView mv = new ModelAndView();
		mv.addObject("brew", brew);
		mv.setViewName("details");
		return mv;
	}

	// deletion redirects
	@RequestMapping(path = "deleteBrewery.do", method = RequestMethod.POST)
	public String deleteBrewery(Brewery brew, RedirectAttributes redir) {
		boolean status = false;
		brew = dao.findById(brew.getId());
		System.out.println(brew);
		int addrId = brew.getAddress().getId();
		int brewId = brew.getId();
		if (dao.deleteBrewery(brewId) && dao.deleteAddress(addrId)) {
			status = true;
		}
		redir.addFlashAttribute("status", status);
		
		return "redirect:/DejaBrew";

	}

}
