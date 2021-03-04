/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bachnv.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ngvba
 */

//bugs ...

public class DispatchServlet extends HttpServlet {
    private final String LOGIN_SERVLET = "LoginServlet";
    private final String LOGOUT_SERVLET = "LogoutServlet";
    private final String LOAD_FOOD_SERVLET = "LoadFoodServlet";
    private final String DELETE_FOOD_SERVLET = "DeleteFoodServlet";
    private final String UPDATE_FOOD_SERVLET = "UpdateFoodServlet";
    private final String SEARCH_FOOD_SERVLET = "SearchFoodServlet";
    private final String CREATE_FOOD_SERVLET = "CreateFoodServlet";
    private final String ADD_FOOD_TO_CART_SERVLET = "AddFoodToCartServlet";
    private final String REMOVE_FOOD_FROM_CART_SERVLET = "RemoveFoodFromCartServlet";
    private final String UPDATE_AMOUNT_FOOD_IN_CART_SERVLET = "UpdateAmountFoodInCartServlet";
    private final String CHECK_OUT_SERVLET = "CheckOutServlet";
    private final String CHECK_OUT_PAGE = "checkOut.jsp";
    private final String VIEW_PURCHASE_HISTORY_SERVLET = "ViewPurchaseHistoryServlet";
    private final String UPDATE_VALUES_SERVLET = "UpdateValuesServlet";
    private final String SEARCH_FULL_FOOD_SERVLET = "SearchFullFoodServlet";
    private final String LOGIN_WITH_GOOGLE_SERVLET = "LoginWithGoogleServlet";
    private final String SEARCH_BILL_BY_DATE_SERVLET = "SearchBillByDateServlet";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String button = request.getParameter("btAction");
        String url = LOAD_FOOD_SERVLET;
        
        try {
            if (button == null) {
                url = LOAD_FOOD_SERVLET;
            } else if (button.equals("Login")) {
                url = LOGIN_SERVLET;
            } else if (button.equals("Delete")) {
                url = DELETE_FOOD_SERVLET;
            } else if (button.equals("Logout")) {
                url = LOGOUT_SERVLET;
            } else if (button.equals("Update")) {
                url = UPDATE_FOOD_SERVLET;
            } else if (button.equals("Search")) {
                url = SEARCH_FOOD_SERVLET;
            } else if (button.equals("Create Food")) {
                url = CREATE_FOOD_SERVLET;
            } else if (button.equals("Add to cart")) {
                url = ADD_FOOD_TO_CART_SERVLET;
            } else if (button.equals("Delete Food")) {
                url = REMOVE_FOOD_FROM_CART_SERVLET;
            } else if (button.equals("Update Amount")) {
                url = UPDATE_AMOUNT_FOOD_IN_CART_SERVLET;
            } else if (button.equals("Confirm")) {
                url = CHECK_OUT_SERVLET;
            } else if (button.equals("Check out")) {
                url = CHECK_OUT_PAGE;
            } else if (button.equals("View Purchase History")) {
                url = VIEW_PURCHASE_HISTORY_SERVLET;
            } else if (button.equals("UpdatePage")) {
                url = UPDATE_VALUES_SERVLET;
            } else if (button.equals("Search Food")) {
                url = SEARCH_FULL_FOOD_SERVLET;
            } else if (button.equals("LoginWithGoogle")) {
                url = LOGIN_WITH_GOOGLE_SERVLET;
            } else if (button.equals("Search Bill")) {
                url =  SEARCH_BILL_BY_DATE_SERVLET;
            }
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
