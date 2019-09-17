package com.skilldistillery.dejabrew;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired
	UserDetailsService userDetailsService;
	
	@Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        super.configure(auth);
        auth.userDetailsService(userDetailsService);
        }


	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		http.csrf().disable();
		
		http.authorizeRequests()
		.antMatchers("/", "/DejaBrew","/DejaBrew/details.do")
			.permitAll()
		.and()
			.formLogin()
			.permitAll()
		.and()
			.logout()
				.invalidateHttpSession(true)
				.logoutSuccessUrl("/DejaBrew")
			.permitAll();
		
		// /userInfo page requires login as ROLE_USER or ROLE_ADMIN.
		// If no login, it will redirect to /login page.
		http.authorizeRequests().antMatchers("/createBrewery.do","/editBrewery.do*", "/creationFormBrewery.do").access("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')");
		http.authorizeRequests().antMatchers("/deleteBrewery.do*").access("hasRole('ROLE_ADMIN')");
	} 

	
	@SuppressWarnings("deprecation")
	@Bean
    public PasswordEncoder getPasswordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }
	
//	@Bean
//    public PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder();
//    }
}
