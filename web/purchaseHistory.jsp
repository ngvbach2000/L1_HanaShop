<%-- 
    Document   : purchaseHistory
    Created on : Jan 11, 2021, 8:23:42 AM
    Author     : ngvba
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <c:if test="${empty sessionScope.USERFULLNAME}">
            <c:redirect url="login.jsp"/>
        </c:if>
        </font>
        
        <a href="/L1_HanaShop"><h1>HanaShop</h1></a>

        <h1>My Purchases</h1>

        <form action="DispatchServlet" method="POST">
            Search: <input type="date" name="txtSearchDate" value="${param.txtSearchDate}" /></br>
            <input type="submit" value="Search Bill" name="btAction" /></br>
        </form>

        <c:set var="searchDateValue" value="${param.txtSearchDate}"/>
        <c:if test="${empty searchDateValue}">
            <c:set var="listBill" value="${sessionScope.LISTBILL}"/>
            <c:if test="${not empty listBill}">
                <c:set var="listMapBillDetail" value="${sessionScope.LISTMAPBILLDETAIL}"/>
                <c:if test="${not empty listMapBillDetail}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Code orders</th>
                                <th>Date of purchase</th>
                                <th>Product</th>
                                <th>Total money</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bill" items="${listBill}">
                                <tr>
                                    <td>${bill.billID}</td>
                                    <td>${bill.dayOfPurchase}</td>
                                    <td>
                                        <c:forEach var="detailBill" items="${listMapBillDetail[bill.billID]}">
                                            ${detailBill}</br>
                                        </c:forEach>
                                    </td>
                                    <td>${bill.total}$</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </c:if>
            <c:if test="${empty listBill}">
                <h3>No result...</h3>
            </c:if>
        </c:if>

        <c:if test="${not empty searchDateValue}">
            <c:set var="listSearchBill" value="${requestScope.LISTSEARCHBILL}"/>
            <c:if test="${not empty listSearchBill}">
                <c:set var="listMapBillDetail" value="${requestScope.LISTMAPBILLDETAIL}"/>
                <c:if test="${not empty listMapBillDetail}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Code orders</th>
                                <th>Date of purchase</th>
                                <th>Product</th>
                                <th>Total money</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bill" items="${listSearchBill}">
                                <tr>
                                    <td>${bill.billID}</td>
                                    <td>${bill.dayOfPurchase}</td>
                                    <td>
                                        <c:forEach var="detailBill" items="${listMapBillDetail[bill.billID]}">
                                            ${detailBill}</br>
                                        </c:forEach>
                                    </td>
                                    <td>${bill.total}$</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </c:if>
            <c:if test="${empty listSearchBill}">
                <h3>No result...</h3>
            </c:if>
        </c:if>

        <a href="cart.jsp">Return to cart</a></br>
        <a href="shopping.jsp">Go to shopping</a>

    </body>
</html>
