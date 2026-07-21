package com.sb.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

@Entity // Hibernate ko batata hai ki ye ek database table hai
@Table(name = "user_login") // Database mein table ka naam
public class UserLogin {
    
    @Id // Primary Key banane ke liye
    @GeneratedValue(strategy = GenerationType.IDENTITY) // Auto Increment ke liye
    private Integer userId; 
    
    @NotEmpty(message = "first Name Is Required")
    private String firstName;
    
    private String lastName;
    
    @NotEmpty(message = "Mobile number is required")
    @Pattern(regexp="^[0-9+]{10,15}$", message="Enter a valid mobile number")
    private String contactNumber;
	
    @NotEmpty(message = "Password Is Required")
    private String password; 
    
    @NotEmpty(message = "Email is Required ")
    @Email(message = "Enter A Valid Email")
    private String email;      

    // Default Constructor
    public UserLogin() {}

    // Getters and Setters
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}