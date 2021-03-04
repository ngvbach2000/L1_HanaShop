/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bachnv.servlet;

import bachnv.bill.BillDAO;
import bachnv.bill.BillDTO;
import bachnv.billdetail.BillDetailDAO;
import bachnv.billdetail.BillDetailDTO;
import bachnv.cart.CartCheckOutError;
import bachnv.cart.CartItemDTO;
import bachnv.cart.CartObject;
import bachnv.food.FoodDAO;
import bachnv.user.UserDAO;
import bachnv.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ngvba
 */
public class CheckOutServlet extends HttpServlet {

    private final String LOAD_FOOD_SERVLET = "LoadFoodServlet";
    private final String CHECK_OUT_PAGE = "checkOut.jsp";

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

        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");

        String url = CHECK_OUT_PAGE;

        String fullname = request.getParameter("txtFullName");
        String address = request.getParameter("txtAddress");
        String email = request.getParameter("txtEmail");
        String phone = request.getParameter("txtPhone");
        String paymentOption = request.getParameter("paymentOption");
        
        if (fullname == null) {
            fullname = "";
        }
        if (address == null) {
            address = "";
        }
        if (email == null) {
            email = "";
        }
        if (phone == null) {
            phone = "";
        }
        if (paymentOption == null) {
            paymentOption = "";
        }

        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                CartObject cart = (CartObject) session.getAttribute("CUSTCART");
                if (cart != null) {
                    List<CartItemDTO> foods = cart.getFoods();
                    if (!foods.isEmpty()) {
                        UserDTO user = (UserDTO) session.getAttribute("USER");
                        if (user != null) {
                            user.setFullname(fullname);
                            user.setAddress(address);
                            user.setEmail(email);
                            user.setPhone(phone);
                            UserDAO userDAO = new UserDAO();
                            boolean resultInsertUser = userDAO.updateInfoUser(user);
                            if (resultInsertUser) {
                                boolean outOfStock = false;
                                String foodOutOfStock = "";
                                FoodDAO foodDAO = new FoodDAO();
                                for (int i = 0; i < foods.size(); i++) {
                                    if (!foodDAO.checkQuantityFood(foods.get(i).getFoodID(), foods.get(i).getAmount())) {
                                        outOfStock = true;
                                        foodOutOfStock = foodOutOfStock + " - " + foods.get(i).getName();
                                    }
                                }
                                if (outOfStock) {
                                    CartCheckOutError error = new CartCheckOutError();
                                    error.setOutOfStock(foodOutOfStock + " out of stock...");
                                    request.setAttribute("OUTOFSTOCK", error);
                                }
                                if (!outOfStock) {
                                    BillDTO billDTO = new BillDTO(user.getUsername() + "_" + df.format(Calendar.getInstance().getTime()),
                                            cart.getTotalPrice(), sdf.parse(sdf.format(Calendar.getInstance().getTime())), user, paymentOption);
                                    BillDAO billDAO = new BillDAO();
                                    boolean resultBill = billDAO.insertBill(billDTO);
                                    if (resultBill) {
                                        BillDetailDAO billDetailDAO = new BillDetailDAO();
                                        Boolean resultBillDetai = false;
                                        for (int i = 0; i < foods.size(); i++) {
                                            BillDetailDTO billDetailDTO
                                                    = new BillDetailDTO(df.format(Calendar.getInstance().getTime()) + i, billDTO, foods.get(i).getFoodID(),
                                                            foods.get(i).getName(), foods.get(i).getAmount(),
                                                            foods.get(i).getPrice(), foods.get(i).getTotal());
                                            int foodQuantity = foodDAO.getQuantityFood(foods.get(i).getFoodID());
                                            boolean updateQuantity = foodDAO.updateQuantityFood(foods.get(i).getFoodID(), 
                                                    foodQuantity - foods.get(i).getAmount());
                                            if (updateQuantity) {
                                                resultBillDetai = billDetailDAO.InsertBillDetail(billDetailDTO);
                                            }
                                            
                                        }
                                        if (resultBillDetai) {
                                            url = LOAD_FOOD_SERVLET;
                                            session.removeAttribute("CUSTCART");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (ParseException ex) {
            log("CheckOut _ Parse " + ex.getMessage());
        } catch (SQLException ex) {
            log("CheckOut _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("CheckOut _ Naming " + ex.getMessage());
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
