package com.sb.service;

import org.springframework.stereotype.Service;

import com.sb.exception.DuplicateEmailException;
import com.sb.model.UserLogin;

@Service
public class UserLoginService {
    
    // Private ko Public kiya taaki Controller use kar sake
    public void validateBusinessRules(UserLogin user) {
        if ("existing@technofern.in".equalsIgnoreCase(user.getEmail())) {
            throw new DuplicateEmailException("This email is already registered.");
        }
    }
}
