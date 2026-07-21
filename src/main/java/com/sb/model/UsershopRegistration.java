package com.sb.model;



import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

@Entity 
@Table(name = "shop_details") 
public class UsershopRegistration {
	
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private Integer shopId;

	@NotEmpty(message = "Shop Name is Required")
	private String shopName;
	
	@NotEmpty(message = "Owner Name is Required")
	private String ownerName;
	
	@NotEmpty(message = "Shop Category is Required")
	private String category;
	
	@NotEmpty(message = "Mobile number is required")
    @Pattern(regexp="^[0-9+]{10,15}$", message="Enter a valid mobile number")
    private String contactNumber;
	
	@NotEmpty(message ="Email is Required")
	@Email(message = "Enter a Valid Email")
	private String email;
	
	@NotEmpty(message = "Gender is Required")
	private String gender;
	
	@NotEmpty(message = "Address is Required")
	private String address;

	private Double latitude;
	private Double longitude;
     
	private int userId;
	
	// 📸 INSTAGRAM FEATURE: Variable ka naam badal kar shopImage kiya
	private String shopImage;
	
	@Transient // Isse Hibernate is column ko database me search nahi karega
	private double averageRating;

	@Transient
	private int totalReviews;

	

	// Getters and Setters
	public Integer getShopId() { return shopId; }
	public void setShopId(Integer shopId) { this.shopId = shopId; }
	
	public String getShopName() { return shopName; }
	public void setShopName(String shopName) { this.shopName = shopName; }
	
	public String getOwnerName() { return ownerName; }
	public void setOwnerName(String ownerName) { this.ownerName = ownerName; }
	
	public String getCategory() { return category; }
	public void setCategory(String category) { this.category = category; }
	
	public String getContactNumber() { return contactNumber; }
	public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
	
	public String getEmail() { return email; }
	public void setEmail(String email) { this.email = email; }
	
	public String getGender() { return gender; }
	public void setGender(String gender) { this.gender = gender; }

	public String getAddress() { return address; }
	public void setAddress(String address) { this.address = address; }

	public Double getLatitude() { return latitude; }
	public void setLatitude(Double latitude) { this.latitude = latitude; }

	public Double getLongitude() { return longitude; }
	public void setLongitude(Double longitude) { this.longitude = longitude; }
	
	public Integer getUserId() { return userId; }
	public void setUserId(int userId) { this.userId = userId; }

	public String getShopImage() { return shopImage; }
	public void setShopImage(String shopImage) { this.shopImage = shopImage; }
	
	
		public double getAverageRating() { return averageRating; }
		public void setAverageRating(double averageRating) { this.averageRating = averageRating; }
		public int getTotalReviews() { return totalReviews; }
		public void setTotalReviews(int totalReviews) { this.totalReviews = totalReviews; }
		public UsershopRegistration(){
		}
}