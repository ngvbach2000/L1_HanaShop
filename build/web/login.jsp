<%-- 
    Document   : login
    Created on : Jan 20, 2021, 9:42:23 AM
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
    <body>
        <c:if test="${not empty sessionScope.USERFULLNAME}">
            <c:redirect url="shopping.jsp"/>
        </c:if>
        <a href="/L1_HanaShop"><h1>HanaShop</h1></a>
        <h2>Login</h2>
        <form action="DispatchServlet" method="POST">
            Username: <input type="text" name="txtUsername" value="" maxlength="30" required="required"/><br/>
            Password: <input type="password" name="txtPassword" value="" maxlength="50" required="required"/><br/>
            <input type="reset" value="Reset" />
            <input type="submit" value="Login" name="btAction" />
        </form>
        <a href="shopping.jsp">Go to shopping</a></br>
        <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8084/L1_HanaShop/DispatchServlet?btAction=LoginWithGoogle&response_type=code&client_id=409426200163-kank5f8nv0ris7ubc3pagpj9bbkfmcff.apps.googleusercontent.com">
            Login with Google</a>
    </body>
</html>
