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
public class CartCheckOutError implements Serializable{
    private String outOfStock;

    public CartCheckOutError() {
    }

    public CartCheckOutError(String outOfStock) {
        this.outOfStock = outOfStock;
    }

    public String getOutOfStock() {
        return outOfStock;
    }

    public void setOutOfStock(String outOfStock) {
        this.outOfStock = outOfStock;
    }
    
}
