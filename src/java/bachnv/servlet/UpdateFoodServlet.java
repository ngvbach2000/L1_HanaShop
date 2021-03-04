/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bachnv.servlet;

import bachnv.food.FoodDAO;
import bachnv.food.FoodDTO;
import bachnv.user.UserDTO;
import bachnv.userhistory.UserHistoryDAO;
import bachnv.userhistory.UserHistoryDTO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author ngvba
 */
public class UpdateFoodServlet extends HttpServlet {

    private final String MANAGER_PAGE = "manager.jsp";

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

        String url = MANAGER_PAGE;
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");

        boolean isMutilPart = ServletFileUpload.isMultipartContent(request);

        if (isMutilPart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List items = null;
            try {
                items = upload.parseRequest(request);
            } catch (Exception ex) {
                log("Updatefood _ Exception " + ex.getMessage());
            }
            Iterator iter = items.iterator();
            Hashtable params = new Hashtable();
            String filename = null;
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                if (item.isFormField()) {
                    params.put(item.getFieldName(), item.getString());
                } else {
                    try {
                        String itemName = item.getName();
                        filename = itemName.substring(itemName.lastIndexOf("\\") + 1);
                        String realPath = getServletContext().getRealPath("/") + "image\\" + filename;
                        File saveFile = new File(realPath);
                        item.write(saveFile);
                    } catch (Exception ex) {
                        log("Updatefood _ Exception " + ex.getMessage());
                    }
                }
            }
            String foodID = (String) params.get("txtFoodID");
            String foodName = (String) params.get("txtFoodName");
            String image = "image/" + filename;
            if (image.equals("image/")) {
                image = (String) params.get("txtImage");
            }
            String description = (String) params.get("txtDescription");
            String stringPrice = (String) params.get("txtPrice");
            float price = Float.parseFloat(stringPrice);
            String category = (String) params.get("txtCategory");
            String stringQuantity = (String) params.get("txtQuantity");
            int quantity = Integer.parseInt(stringQuantity);
            Boolean status = true;
            String stringStatus = (String) params.get("ddlStatus");
            if (stringStatus.equals("inactive")) {
                status = false;
            }

            String searchFood = (String) params.get("searchFood");
            String searchCategory = (String) params.get("searchCategory");
            String searchPriceFrom = (String) params.get("searchPriceFrom");
            String searchPriceTo = (String) params.get("searchPriceTo");
            String currentPage = (String) params.get("currentPage");
            String isSearch = (String) params.get("isSearch");
            String btAction = "";
            if (("true").equals(isSearch)) {
                btAction = "Search Food";
            }
            if (currentPage == null) {
                currentPage = "1";
            }
            if (searchFood == null) {
                searchFood = "";
            }
            if (searchCategory == null) {
                searchCategory = "";
            }
            if (searchPriceFrom == null) {
                searchPriceFrom = "";
            }
            if (searchPriceTo == null) {
                searchPriceTo = "";
            }

            try {
                FoodDTO dto = new FoodDTO(foodID, foodName, image, description, price, null, category, status, quantity);
                FoodDAO dao = new FoodDAO();

                String format = "";
                int index = filename.lastIndexOf(".");
                if (index > 0) {
                    format = filename.substring(index + 1);
                }
                if (format.equalsIgnoreCase("jpeg")
                        || format.equalsIgnoreCase("png")
                        || format.equalsIgnoreCase("jpg")
                        || "".equals(format)) {
                    boolean result = dao.updateFood(dto);
                    if (result) {
                        HttpSession session = request.getSession(false);
                        UserDTO user = (UserDTO) session.getAttribute("USER");
                        String history = "UPDATE food which foodID: " + foodID;
                        UserHistoryDTO userHistoryDTO = new UserHistoryDTO(df.format(Calendar.getInstance().getTime()),
                                user, history, sdf.parse(sdf.format(Calendar.getInstance().getTime())));
                        UserHistoryDAO userHistoryDAO = new UserHistoryDAO();
                        userHistoryDAO.insertUserHistory(userHistoryDTO);

                    }
                }
                url = "DispatchServlet"
                        + "?btAction=" + btAction
                        + "&txtSearchFood=" + searchFood
                        + "&DDLCategory=" + searchCategory
                        + "&txtPriceFrom=" + searchPriceFrom
                        + "&txtPriceTo=" + searchPriceTo
                        + "&page=" + currentPage;
            } catch (SQLException ex) {
                log("Updatefood _ SQL " + ex.getMessage());
            } catch (NamingException ex) {
                log("Updatefood _ Naming " + ex.getMessage());
            } catch (ParseException ex) {
                log("Updatefood _ Parse " + ex.getMessage());
            } finally {
                response.sendRedirect(url);
                out.close();
            }
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
