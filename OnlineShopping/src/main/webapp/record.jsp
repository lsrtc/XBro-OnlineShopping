<%@page import="bean.User"%>
<%@ page import="dao.impl.TransactionDaoImpl" %>
<%@ page import="dao.TransactionDao" %>
<%@ page import="dao.impl.UserDaoImpl" %>
<%@ page import="dao.UserDao" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="bean.Deal" %>
<%@ page import="bean.DealList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link type="text/css" rel="stylesheet" href="./CSS/record.css">
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
        <% if (request.getSession().getAttribute("curUser") == null) { %>
            <a href="login.jsp">登录</a><a href="register.jsp">注册</a>
        <% } else { %>
            <a href="QuitServlet">退出登录</a>
        <% } %>
    </div>
</div>
<div class="main">
    <div class="navbar">
        <img src="./img/Xbro.png">
    </div>
    <div class="menu"></div>
    <div class="content">
        <p>商品ID</p>
        <p>交易时间</p>
        <p>交易状态</p>
        <p>交易金额</p>
        <p>详情</p>
        <%
            UserDao ud = new UserDaoImpl();
            TransactionDao td = new TransactionDaoImpl();
            Integer productId = Integer.parseInt(request.getParameter("product_id"));
            DealList dl = td.findDealsByProduct_id(productId);
            for (Deal d : dl.getDeals()) {
        %>
        <p><%=d.getProduct_id() %></p>
        <p><%=d.getTime() %></p>
        <p><%=d.getStatus() %></p>
        <p><%=d.getAmount() %></p>
        <%
            int product_id = d.getProduct_id();
            String status = d.getStatus();
            String time = d.getTime();
            int trans_id = td.findTrans_ID(product_id, time);
        %>
        <p><a href="detail.jsp?transaction_id=<%=trans_id%>&status=<%=status%>&product_id=<%=product_id %>">查看详情</a></p>
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
