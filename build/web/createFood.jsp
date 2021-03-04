<%-- 
    Document   : createFood
    Created on : Jan 8, 2021, 7:58:50 PM
    Author     : ngvba
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HanaShop</title>
    </head>
    <body>
        <c:set var="role" value="${sessionScope.USERROLE}"/>
        <c:if test="${role != 'admin'}">
            <c:redirect url="shopping.jsp"/>
        </c:if>


        <!-- Welcome -->
        <font color ="red">
        <c:if test="${not empty sessionScope.USERFULLNAME}">
            Welcome, ${sessionScope.USERFULLNAME}<br/>
            <form action="DispatchServlet">
                <input type="submit" value="Logout" name="btAction"/>
            </form>
        </c:if>
        </font>
        <c:if test="${empty sessionScope.USERFULLNAME}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <a href="/L1_HanaShop"><h1>HanaShop</h1></a>
        <h3>Create new food</h3>
        <c:set var="newFood" value="${requestScope.NEWFOOD}"/>
        <form action="DispatchServlet?btAction=Create Food" method="POST" enctype="multipart/form-data">
            Food ID: <input type="text" name="txtFoodID" value="${newFood.foodID}" size="20" maxlength="20" required="required"/></br>
            Food Name: <input type="text" name="txtFoodName" value="${newFood.foodName}" size="30" maxlength="30" required="required"/></br>
            Image: <input type="file" name="file" value="" accept=".jpg, .png, .jpeg" required="required"/></br>
            Description: <input type="text" name="txtDescription" value="${newFood.description}" size="50" maxlength="250" required="required"/></br>
            Price: <input type="number" name="txtPrice" value="${newFood.price}" min="0.01" step="0.01" max="1000" required="required"/></br>
            Category: <input type="text" name="txtCategory" value="${newFood.category}" size="20" maxlength="30" required="required"/></br>
            Quantity: <input type="number" name="txtQuantity" value="${newFood.quantity}" max="10000" min ="0" required="required"/></br>
            <input type="submit" value="Create Food" name="btAction" />
        </form>

        <c:set var="err" value="${requestScope.ERRORS}"/>
        <c:if test="${not empty err.foodIDIsExited}">
            <font color="red">
            ${err.foodIDIsExited}
            </font>
        </c:if></br>
        <c:if test="${not empty err.foodImageIsNotAPicture}">
            <font color="red">
            ${err.foodImageIsNotAPicture}
            </font>
        </c:if></br>

        <a href="manager.jsp">Go back to manager page</a>
    </body>
</html>
