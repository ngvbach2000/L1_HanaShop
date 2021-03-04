/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bachnv.cart;

import java.io.Serializable;

/**
 *
 * @author ngvba
 */
public class CartItemDTO implements Serializable {

    private String foodID;
    private String name;
    private int amount;
    private float price;
    private float total;

    public CartItemDTO() {
    }

    public CartItemDTO(String foodID, String name, int amount, float price, float total) {
        this.foodID = foodID;
        this.name = name;
        this.amount = amount;
        this.price = price;
        this.total = total;
    }

    public String getFoodID() {
        return foodID;
    }

    public void setFoodID(String foodID) {
        this.foodID = foodID;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public float getPrice() {
        return (float) Math.round(price * 100) / 100;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public float getTotal() {
        return (float) Math.round(total * 100) / 100;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
