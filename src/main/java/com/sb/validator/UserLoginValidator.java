package com.sb.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.sb.model.UserLogin;

@Component
public class UserLoginValidator implements Validator{
	
	@Override
	public boolean supports(Class<?> clazz) {
		return UserLogin.class.equals(clazz);
	}
	
	@Override
	public void validate(Object target, Errors errors) {
		UserLogin user = (UserLogin) target;
		
		if(user.getFirstName() != null &&
				   user.getFirstName().trim().toLowerCase().contains("admin")) {
				    errors.rejectValue("userName", "userName.invalid", 
				            "User name cannot contain the word 'admin'");
				}

			
	}
}