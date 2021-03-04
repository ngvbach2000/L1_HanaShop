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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
public class SearchBillByDateServlet extends HttpServlet {

    public final String PURCHASE_HISTORY_PAGE = "purchaseHistory.jsp";

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

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String searchDateValue = request.getParameter("txtSearchDate");
        
        String url = PURCHASE_HISTORY_PAGE;

        try {
            if (searchDateValue != null) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    UserDTO userDTO = (UserDTO) session.getAttribute("USER");
                    if (userDTO != null) {
                        BillDAO billDAO = new BillDAO();
                        billDAO.searchBillByDate(userDTO, sdf.parse(searchDateValue));
                        List<BillDTO> listSearchBill = billDAO.getListBill();
                        if (listSearchBill != null) {
                            Map<String, List<String>> purchase = new HashMap();
                            BillDetailDAO billDetailDAO = new BillDetailDAO();
                            for (int i = 0; i < listSearchBill.size(); i++) {
                                billDetailDAO.getBillDetailByBill(listSearchBill.get(i));
                                List<BillDetailDTO> listBillDetail = billDetailDAO.getListBillDetail();
                                List<String> listFoodName = new ArrayList<>();
                                for (int j = 0; j < listBillDetail.size(); j++) {
                                    listFoodName.add(listBillDetail.get(j).getFoodName() + " x" + listBillDetail.get(j).getAmount());
                                }
                                purchase.put(listSearchBill.get(i).getBillID(), listFoodName);
                            }
                            request.setAttribute("LISTSEARCHBILL", listSearchBill);
                            request.setAttribute("LISTMAPBILLDETAIL", purchase);
                        }
                    }
                }
            }
        } catch (ParseException ex) {
            log("SearchBillByDate _ Parse " + ex.getMessage());
        } catch (SQLException ex) {
            log("SearchBillByDate _ SQL " + ex.getMessage());
        } catch (NamingException ex) {
            log("SearchBillByDate _ Naming " + ex.getMessage());
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
