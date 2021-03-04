/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bachnv.food;

import java.io.Serializable;

/**
 *
 * @author ngvba
 */
public class FoodCreateError implements Serializable{
    private String foodIDIsExited;
    private String foodImageIsNotAPicture;

    public FoodCreateError(String foodIDIsExited, String foodImageIsNotAPicture) {
        this.foodIDIsExited = foodIDIsExited;
        this.foodImageIsNotAPicture = foodImageIsNotAPicture;
    }

    public FoodCreateError() {
    }    

    public String getFoodIDIsExited() {
        return foodIDIsExited;
    }

    public void setFoodIDIsExited(String foodIDIsExited) {
        this.foodIDIsExited = foodIDIsExited;
    }

    public String getFoodImageIsNotAPicture() {
        return foodImageIsNotAPicture;
    }

    public void setFoodImageIsNotAPicture(String foodImageIsNotAPicture) {
        this.foodImageIsNotAPicture = foodImageIsNotAPicture;
    }
    
}
