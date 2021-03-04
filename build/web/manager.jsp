<%-- 
    Document   : manager
    Created on : Jan 4, 2021, 6:56:14 PM
    Author     : ngvba
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>HanaShop</title>
    </head>
    </font>
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

        <!-- search -->
        <form action="DispatchServlet">
            <!-- search name text field -->
            Search: <input type="text" name="txtSearchFood" value="${param.txtSearchFood}" maxlength="30"/></br>

            <!-- category search drop down list -->
            Category: <select name="DDLCategory">
                <option value="">--chose category</option>
                <c:set var="ListCategory" value="${sessionScope.LISTFULLCATEGORY}"/>
                <c:if test="${not empty ListCategory}">
                    <c:forEach var="category" items="${ListCategory}" varStatus="counter"> 
                        <option ${category == param.DDLCategory ? 'selected':''}>${category}</option>
                    </c:forEach>
                </c:if>
            </select></br>

            <!-- search by range of price -->
            Price: <input type="number" min ="0" step="0.01" max="100" name="txtPriceFrom" value="${param.txtPriceFrom}" size="1"/>
            - <input type="number" min="0" max="100" step="0.01" name="txtPriceTo" value="${param.txtPriceTo}" size="1"/></br>
            <input type="submit" value="Search Food" name="btAction" />
        </form></br>

        <a href="createFood.jsp">Create new Food</a></br>

        <!-- Show list 20 full food -->
        <c:set var="SearchFoodValue" value="${param.txtSearchFood}" />
        <c:if test="${empty SearchFoodValue}">
            <c:set var="LCategory" value="${param.DDLCategory}"/>
            <c:if test="${empty LCategory}">
                <c:set var="PriceFrom" value="${param.txtPriceFrom}"/>
                <c:set var="PriceTo" value="${param.txtPriceTo}"/>
                <c:if test="${empty PriceFrom && empty PriceTo}">
                    <c:set var="ListFull20Food" value="${sessionScope.LISTFULL20FOOD}"/>
                    <c:if test="${not empty ListFull20Food}">
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Name</th>
                                    <th>Image</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Category</th>
                                    <th>Create Date</th>
                                    <th>Status</th>
                                    <th>Quantity</th>
                                    <th>Delete</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                            <tbody>
                            <form action="DispatchServlet" method="POST">
                                <c:forEach var="food" items="${ListFull20Food}" varStatus="counter">
                                    <tr>
                                        <td>
                                            ${counter.count}
                                        </td>
                                        <td>
                                            ${food.foodName}
                                        </td>
                                        <td>
                                            <img src="${food.image}" width="100" height="100"/>
                                        </td>
                                        <td>
                                            ${food.description}
                                        </td>
                                        <td>
                                            ${food.price}$
                                        </td>
                                        <td>
                                            ${food.category}
                                        </td>
                                        <td>${food.createDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${food.status}">
                                                    active
                                                </c:when>
                                                <c:otherwise>
                                                    inactive
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            ${food.quantity}
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${food.status}">
                                                    <input type="checkbox" name="ckbDeleteFood" value="${food.foodID}" />
                                                </c:when>
                                                <c:otherwise>
                                                    Deleted
                                                </c:otherwise>
                                            </c:choose>

                                        </td>
                                        <td>
                                            <c:url var="updateValues" value="DispatchServlet">
                                                <c:param name="foodID" value="${food.foodID}"/>
                                                <c:param name="currentPage" value="${sessionScope.CURRENTPAGE}" />
                                                <c:param name="btAction" value="UpdatePage"/>
                                            </c:url>
                                            <a href="${updateValues}">Update</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <td colspan="9"></td>
                                <td>
                                    <input type="submit" value="Delete" name="btAction" onclick="return confirm('Are you sure you want to delete?')"/>
                                    <input type="hidden" name="currentPage" value="${sessionScope.CURRENTPAGE}" />
                                </td>
                                <td></td>
                            </form>
                        </tbody>
                    </table>
                </c:if>
            </c:if>
        </c:if>
    </c:if>

    <c:set var="ListFullFood" value="${requestScope.LISTFULLFOOD}"/>
    <c:if test="${not empty ListFullFood}">
        <table border="1">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Name</th>
                    <th>Image</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Category</th>
                    <th>Status</th>
                    <th>Quantity</th>
                    <th>Create Date</th>
                    <th>Delete</th>
                    <th>Update</th>
                </tr>
            </thead>
            <tbody>
            <form action="DispatchServlet" method="POST">
                <c:forEach var="food" items="${ListFullFood}" varStatus="counter">
                    <tr>
                        <td>
                            ${counter.count}
                        </td>
                        <td>
                            ${food.foodName}
                        </td>
                        <td>
                            <img src="${food.image}" width="100" height="100"/>
                        </td>
                        <td>
                            ${food.description}
                        </td>
                        <td>
                            ${food.price}$
                        </td>
                        <td>
                            ${food.category}
                        </td>
                        <td>${food.createDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${food.status}">
                                    active
                                </c:when>
                                <c:otherwise>
                                    inactive
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            ${food.quantity}
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${food.status}">
                                    <input type="checkbox" name="ckbDeleteFood" value="${food.foodID}" />
                                </c:when>
                                <c:otherwise>
                                    Deleted
                                </c:otherwise>
                            </c:choose>

                        </td>
                        <td>
                            <c:url var="updateValues" value="DispatchServlet">
                                <c:param name="foodID" value="${food.foodID}"/>
                                <c:param name="currentPage" value="${requestScope.CURRENTPAGE}" />
                                <c:param name="searchFood" value="${param.txtSearchFood}" />
                                <c:param name="searchCategory" value="${param.DDLCategory}" />
                                <c:param name="searchPriceFrom" value="${param.txtPriceFrom}" />
                                <c:param name="searchPriceTo" value="${param.txtPriceTo}" />
                                <c:param name="isSearch" value="true" />
                                <c:param name="btAction" value="UpdatePage"/>
                            </c:url>
                            <a href="${updateValues}">Update</a>
                        </td>
                    </tr>
                </c:forEach>
                <td colspan="9"></td>
                <td>
                    <input type="submit" value="Delete" name="btAction" onclick="return confirm('Are you sure you want to delete?')"/>
                    <input type="hidden" name="currentPage" value="${requestScope.CURRENTPAGE}" />
                    <input type="hidden" name="searchFood" value="${param.txtSearchFood}" />
                    <input type="hidden" name="searchCategory" value="${param.DDLCategory}" />
                    <input type="hidden" name="searchPriceFrom" value="${param.txtPriceFrom}" />
                    <input type="hidden" name="searchPriceTo" value="${param.txtPriceTo}" />
                    <input type="hidden" name="isSearch" value="true" />
                </td>
                <td></td>
            </form>
        </tbody>
    </table>
</c:if>

<!-- no result text -->
<c:if test="${empty ListFullFood}">
    <c:if test="${empty ListFull20Food}">
        <h2>No result...</h2>
    </c:if>
</c:if>

<!-- paging search food -->
<c:set var="SearchNoOfPage" value="${requestScope.NOOFPAGE}"/>
<c:set var="searchCurrentPage" value="${requestScope.CURRENTPAGE}"/>
<c:if test="${not empty SearchNoOfPage}">
    <c:url var="previousPage" value="DispatchServlet" >
        <c:param name="btAction" value="Search Food"/>
        <c:param name="txtSearchFood" value="${param.txtSearchFood}"/>
        <c:param name="DDLCategory" value="${param.DDLCategory}" />
        <c:param name="txtPriceFrom" value="${param.txtPriceFrom}" />
        <c:param name="txtPriceTo" value="${param.txtPriceTo}" />
        <c:param name="page" value="${searchCurrentPage - 1}"/>
    </c:url>
    <c:if test="${searchCurrentPage != 1}">
        <a href="${previousPage}">Previous</a>
    </c:if>

    <c:url var="nextPage" value="DispatchServlet" >
        <c:param name="btAction" value="Search Food"/>
        <c:param name="txtSearchFood" value="${param.txtSearchFood}"/>
        <c:param name="DDLCategory" value="${param.DDLCategory}" />
        <c:param name="txtPriceFrom" value="${param.txtPriceFrom}" />
        <c:param name="txtPriceTo" value="${param.txtPriceTo}" />
        <c:param name="page" value="${searchCurrentPage + 1}"/>
    </c:url>
    <c:if test="${searchCurrentPage < SearchNoOfPage}">
        <a href="${nextPage}">Next</a>
    </c:if>

    <table border="0">
        <tr>
            <c:forEach begin="1" end="${SearchNoOfPage}" var="i">
                <c:choose>
                    <c:when test="${searchCurrentPage == i}">
                        <td>${i}</td>
                    </c:when>
                    <c:otherwise>
                        <c:url var="choosePage" value="DispatchServlet" >
                            <c:param name="btAction" value="Search Food"/>
                            <c:param name="txtSearchFood" value="${param.txtSearchFood}"/>
                            <c:param name="DDLCategory" value="${param.DDLCategory}" />
                            <c:param name="txtPriceFrom" value="${param.txtPriceFrom}" />
                            <c:param name="txtPriceTo" value="${param.txtPriceTo}" />
                            <c:param name="page" value="${i}"/>
                        </c:url>
                        <td> <a href="${choosePage}">${i}</a> </td>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </tr>
    </table>
</c:if>

<!-- paging -->
<c:if test="${empty SearchNoOfPage}">
    <c:set var="currentPage" value="${sessionScope.CURRENTPAGE}"/>
    <c:set var="noOfFullPage" value="${sessionScope.NOOFFULLPAGE}"/>

    <c:url var="previousPage" value="DispatchServlet" >
        <c:param name="btAction"/>
        <c:param name="page" value="${currentPage - 1}"/>
    </c:url>
    <c:if test="${currentPage != 1}">
        <a href="${previousPage}">Previous</a>
    </c:if>

    <c:url var="nextPage" value="DispatchServlet" >
        <c:param name="btAction"/>
        <c:param name="page" value="${currentPage + 1}"/>
    </c:url>
    <c:if test="${currentPage < noOfFullPage}">
        <a href="${nextPage}">Next</a>
    </c:if>

    <table border="0">
        <tr>
            <c:forEach begin="1" end="${noOfFullPage}" var="i">
                <c:choose>
                    <c:when test="${currentPage == i}">
                        <td>${i}</td>
                    </c:when>
                    <c:otherwise>
                        <c:url var="choosePage" value="DispatchServlet" >
                            <c:param name="btAction"/>
                            <c:param name="page" value="${i}"/>
                        </c:url>
                        <td> <a href="${choosePage}">${i}</a> </td>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </tr>
    </table>
</c:if>

</body>
</html>
