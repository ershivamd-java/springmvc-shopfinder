package com.sb.controller;

import java.io.File;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sb.dao.ProductDao;
import com.sb.model.Product;

@Controller
public class ProductController {

    @Autowired
    private ProductDao productDao;

    // 1. Shop Owner is URL par form post karke product image aur details add karega
    @PostMapping("/saveProduct")
    public String saveProductDetails(@RequestParam("productName") String name,
                                     @RequestParam("productPrice") Double price,
                                     @RequestParam("productPhoto") MultipartFile file,
                                     @RequestParam("shopId") int shopId,
                                     HttpServletRequest request) {
        try {
            Product product = new Product();
            product.setProductName(name);
            product.setProductPrice(price);
            product.setShopId(shopId);

            if (!file.isEmpty()) {
                String originalFilename = file.getOriginalFilename();
                String uniqueFileName = System.currentTimeMillis() + "_" + originalFilename;
                
                // 🎯 Path ko securely handle karne ke liye
                String rootPath = request.getServletContext().getRealPath("/");
                String savePath = rootPath + "resources" + File.separator + "images";
                
                File folder = new File(savePath);
                if (!folder.exists()) {
                    folder.mkdirs(); // 🔥 Agar folder nahi hai to ye khud bana dega
                }
                
                File destinationFile = new File(savePath + File.separator + uniqueFileName);
                file.transferTo(destinationFile);
                product.setProductImage(uniqueFileName);
            } else {
                product.setProductImage("default_product.jpg");
            }

            // Hibernate se save karna
            this.productDao.saveProduct(product);
            
        } catch (Exception e) {
            System.out.println("❌ PRODUCT SAVE ERROR: " + e.getMessage());
            e.printStackTrace(); // 🔥 Yeh line aapko Eclipse Console me exact galti batayegi
        }
        // Upload hone ke baad user ko vapas usi ke profile page par bhejna behtar hai
        return "redirect:/yourProfile"; 
    }
    // 2. AJAX REQUEST HANDLER: Jab search results me koi shop ki pic par click karega tab ye run hoga
    @GetMapping("/getShopProducts")
    @ResponseBody
    public List<Product> getShopProductsJson(@RequestParam("shopId") int shopId) {
        System.out.println("====== AJAX REQUEST RECEIVED FOR SHOP ID: " + shopId + " ======");
        
        List<Product> list = this.productDao.getProductsByShopId(shopId);
        
        if(list != null) {
            System.out.println("====== HIBERNATE FOUND " + list.size() + " PRODUCTS ======");
            for(Product p : list) {
                System.out.println("Product Name: " + p.getProductName() + " | Price: " + p.getProductPrice());
            }
        } else {
            System.out.println("====== NO PRODUCTS FOUND IN DATABASE ======");
        }
        
        return list; // Yeh direct browser ke JavaScript ko bhej dega
    }
    @GetMapping("/deleteProduct")
    public String deleteProduct(@RequestParam("productId") int productId) {
        try {
            // 🎯 Purana getHibernateTemplate() hata kar direct naye method ko call kijiye
            this.productDao.deleteProductById(productId);
        } catch (Exception e) {
            System.out.println("Product Delete Error: " + e.getMessage());
            e.printStackTrace();
        }
        return "redirect:/yourProfile";
    }
    }