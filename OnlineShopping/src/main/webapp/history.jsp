<%@page import="bean.User"%>
<%@page import="dao.impl.GoodDaoImpl" %>
<%@page import="dao.GoodDao" %>
<%@page import="bean.GoodList" %>
<%@page import="bean.Good" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link type="text/css" rel="stylesheet" href="./CSS/history.css">
</head>

<body>
<div class="head">
    <div class="header">
        <a href="main.jsp">首页</a>
        <a href="back_stage.jsp">进入后台</a>
        <%
	        User curUser = (User)request.getSession().getAttribute("curUser");
	        if (curUser==null || !"seller".equals(curUser.getUser_group())) {
	        	response.sendRedirect("login.jsp");
	        }
        %>
        <c:if test="${empty sessionScope.curUser}">
            <a href="login.jsp">登录</a>
            <a href="register.jsp">注册</a>
        </c:if>
        <c:if test="${not empty sessionScope.curUser}">
            <a href="QuitServlet">退出登录</a>
        </c:if>
    </div>
</div>
<div class="main">
        <div class="navbar">
            <img src="./img/Xbro.png">
        </div>
        <div class="menu"></div>
        <div class="content">
       		<p>商品名称</p>
            <!-- <p>商品描述</p> -->
            <p>商品生产批次</p>
            <p>商品有效期</p>
            <p>商品是否为处方药</p>
            <p>商品价格</p>
            <p>详情</p>
            <br>
         <%
         	GoodDao gd = new GoodDaoImpl();
         	GoodList goodsList = gd.findAllGoods(curUser.getId());
         	List<Good> gl = goodsList.getGoodsList();
         	for(Good g:gl){
         	int product_id = g.getId();
         %>
         		<p><a href="good_manage.jsp?method=1&product_id=<%=product_id %>"><%=g.getItemName()%></a></p>
         		<!-- <p><%=g.getItemDescription() %></p> -->
         		<p><%=g.getNumber() %></p>
         		<p><%=g.getDate() %></p>
         		<p><%=g.getIsPres() %></p>
         		<p><%=g.getPrice() %></p>
         		<p><a href="ShowDealList?product_id=<%=product_id %>">查看订单</a></p>
         		<br>
         		<%
         	}
          %>
        </div>
        <div class="sidebar"></div>
        <div class="footer">
            <a href="#">关于我们</a>
            <a href="#">联系我们</a>
            <a href="#">隐私政策</a>
            <a href="#">公益活动</a>
        </div>
</div>
</body>
</html>
