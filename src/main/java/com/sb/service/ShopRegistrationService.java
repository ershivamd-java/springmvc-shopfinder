package com.sb.service;

import org.springframework.stereotype.Service;

import com.sb.exception.DuplicateEmailException;
import com.sb.model.UsershopRegistration;

@Service
public class ShopRegistrationService {
	public void saveShopDetails(UsershopRegistration shopeDatils) {
        if ("existing@shivam.in".equalsIgnoreCase(shopeDatils.getEmail())) {
            throw new DuplicateEmailException("This email is already registered.");
        }
    }
	
}
