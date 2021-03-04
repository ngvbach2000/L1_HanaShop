/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bachnv.servlet;

import bachnv.food.FoodCreateError;
import bachnv.food.FoodDAO;
import bachnv.food.FoodDTO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author ngvba
 */
public class CreateFoodServlet extends HttpServlet {

    private final String CREATE_FOOD_PAGE = "createFood.jsp";
    private final String LOAD_FOOD_SERVLET = "LoadFoodServlet";

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

        String url = CREATE_FOOD_PAGE;

        boolean isMutilPart = ServletFileUpload.isMultipartContent(request);

        if (isMutilPart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List items = null;
            try {
                items = upload.parseRequest(request);
            } catch (Exception e) {
                log("CreateFood _ Exception " + e.getMessage());
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
                        log("CreateFood _ Exception " + ex.getMessage());
                    }
                }
            }

            FoodCreateError errors = new FoodCreateError();
            String foodID = (String) params.get("txtFoodID");
            String foodName = (String) params.get("txtFoodName");
            String image = "image/" + filename;
            String description = (String) params.get("txtDescription");
            String stringPrice = (String) params.get("txtPrice");
            float price = Float.parseFloat(stringPrice);
            String category = (String) params.get("txtCategory");
            String stringQuantity = (String) params.get("txtQuantity");
            int quantity = Integer.parseInt(stringQuantity);
            boolean status = true;
            Date createDate = Calendar.getInstance().getTime();
            FoodDTO newFood = new FoodDTO(foodID, foodName, image, description, price, createDate, category, status, quantity);
            request.setAttribute("NEWFOOD", newFood);

            try {
                String format = "";
                int index = filename.lastIndexOf(".");
                if (index > 0) {
                    format = filename.substring(index + 1);
                }
                if (format.equalsIgnoreCase("jpeg")
                        || format.equalsIgnoreCase("png")
                        || format.equalsIgnoreCase("jpg")) {

                    FoodDAO dao = new FoodDAO();
                    boolean result = dao.createFood(newFood);
                    if (result) {
                        url = LOAD_FOOD_SERVLET;
                    }
                    
                } else {
                    errors.setFoodImageIsNotAPicture("Please input file image with extension file (.png, .jpeg, .jpg)");
                    request.setAttribute("ERRORS", errors);
                }
            } catch (SQLException ex) {
                String errMsg = ex.getMessage();
                log("CreateFood _ Sql" + errMsg);
                if (errMsg.contains("duplicate")) {
                    errors.setFoodIDIsExited(foodID + " is existed!!!");
                    request.setAttribute("ERRORS", errors);
                }
            } catch (NamingException ex) {
                log("CreateFood _ Naming " + ex.getMessage());
            } finally {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
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
