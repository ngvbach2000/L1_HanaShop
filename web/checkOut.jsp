<%-- 
    Document   : checkOut
    Created on : Jan 10, 2021, 8:44:27 PM
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
        <c:if test="${role == 'admin'}">
            <c:redirect url="manager.jsp"/>
        </c:if>

        <!-- Welcome -->
        <font color ="red">
        <c:if test="${not empty sessionScope.USERFULLNAME}">
            Welcome, ${sessionScope.USERFULLNAME}<br/>
            <form action="DispatchServlet">
                <input type="submit" value="Logout" name="btAction" />
            </form>
        </c:if>
        </font>
        <c:if test="${empty sessionScope.USERFULLNAME}">
            <c:redirect url="login.jsp"/>
        </c:if>
        
        <a href="/L1_HanaShop"><h1>HanaShop</h1></a>

        <h1>Check Out</h1>

        <form action="DispatchServlet" method="POST">
            <h3>Shipping Info</h3>
            <c:set var="user" value="${sessionScope.USER}"/>
            Full name: <input type="text" name="txtFullName" value="${user.fullname}" maxlength="255" minlength="5" required="required"/></br>
            Phone number: <input type="tel" name="txtPhone" value="${user.phone}" pattern="[0]{1}[0-9]{9}" placeholder="0123456789" required="required"/></br>
            Email: <input type="email" name="txtEmail" value="${user.email}" minlength="5" maxlength="50" required="required"/></br>
            Address: <input type="text" name="txtAddress" value="${user.address}" minlength="7" maxlength="250" required="required"/></br>

            <h3>Product</h3>
            <c:set var="cart" value="${sessionScope.CUSTCART}"/>
            <c:if test="${not empty cart}">
                <c:set var="foods" value="${cart.foods}"/>
                <c:if test="${not empty foods}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Food Name</th>
                                <th>Amount</th>
                                <th>Price</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="food" items="${foods}" varStatus="counter">
                                <tr>
                                    <td>
                                        ${counter.count}
                                    </td>
                                    <td>
                                        ${food.name}
                                    </td>
                                    <td>
                                        ${food.amount}
                                    </td>
                                    <td>
                                        ${food.price}
                                    </td>
                                    <td>
                                        ${food.total}
                                    </td>
                                </tr>
                                </form>
                            </c:forEach>
                            <tr>
                                <td colspan="3"></td>
                                <td colspan="2">
                                    Total: ${cart.totalPrice}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </c:if>
            </c:if>
            
            <c:set var="outOfStock" value="${requestScope.OUTOFSTOCK}"/>
            <c:if test="${not empty outOfStock.outOfStock}">
                <font color="red">
                ${outOfStock.outOfStock}
                </font>
            </c:if>

            <h3>Payment</h3>
            Payment Option: <select name="paymentOption">
                <option>Cash on delivery (COD)</option>
            </select></br>

            <h3>Confirm to buy</h3>
            <input type="submit" value="Confirm" name="btAction" /></br>
            <a href="cart.jsp">Return to cart</a>
        </form>
    </body>
</html>
