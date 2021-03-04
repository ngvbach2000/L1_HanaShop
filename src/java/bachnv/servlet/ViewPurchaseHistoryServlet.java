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
import bachnv.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ngvba
 */
public class ViewPurchaseHistoryServlet extends HttpServlet {

    private final String PURCHASE_HISTORY_PAGE = "purchaseHistory.jsp";
    private final String LOGIN_PAGE = "login.jsp";

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

        String url = LOGIN_PAGE;

        try {
            HttpSession session = request.getSession();
            if (session != null) {
                UserDTO user = (UserDTO) session.getAttribute("USER");
                if (user != null) {
                    BillDAO billDAO = new BillDAO();
                    billDAO.getAllBillByUser(user);
                    List<BillDTO> listBill = billDAO.getListBill();
                    if (listBill != null) {
                        Map<String, List<String>> purchase = new HashMap();
                        BillDetailDAO billDetailDAO = new BillDetailDAO();
                        for (int i = 0; i < listBill.size(); i++) {
                            billDetailDAO.getBillDetailByBill(listBill.get(i));
                            List<BillDetailDTO> listBillDetail = billDetailDAO.getListBillDetail();
                            List<String> listFoodName = new ArrayList<>();
                            if (listBillDetail != null) {
                                for (int j = 0; j < listBillDetail.size(); j++) {
                                    listFoodName.add(listBillDetail.get(j).getFoodName() + " x" + listBillDetail.get(j).getAmount()
                                            + " - " + listBillDetail.get(j).getTotal() + "$");
                                }
                                purchase.put(listBill.get(i).getBillID(), listFoodName);
                            }
                        }
                        session.setAttribute("LISTBILL", listBill);
                        session.setAttribute("LISTMAPBILLDETAIL", purchase);
                    }
                    url = PURCHASE_HISTORY_PAGE;
                }
            }
        } catch (SQLException ex) {
            log("ViewPurchaseHistory _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("ViewPurchaseHistory _ Naming " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
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
