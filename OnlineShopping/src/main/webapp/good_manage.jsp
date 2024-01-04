<%@page import="bean.GoodList"%>
<%@page import="dao.impl.GoodDaoImpl"%>
<%@page import="dao.GoodDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDao"%>
<%@page import="bean.Good"%>
<%@page import="dao.impl.UserDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
<link type="text/css" rel="stylesheet" href="./CSS/good_manage.css">
</head>

<body>

	<%
		Good good = new Good();
		UserDao ud = new UserDaoImpl();
		
		List<Good> goods = new ArrayList<Good>();
		if(session.getAttribute("loginStatus") == null || session.getAttribute("loginStatus").equals("failed")){
			response.sendRedirect("login.jsp");
		}
	%>

    <div class="head">
        <div class="header">
          <a href="ShowGoodsList">首页</a>
          <a href="back_stage.jsp">进入后台</a>
	  <a href="change_password.jsp">修改密码</a>	
          <%
	          	if(request.getSession().getAttribute("curUser")==null){
	          %>
          <a href="login.jsp">登录</a><a href="register.jsp">注册</a><%
          	}
          %><%
          	else{
          %>
          <a href="QuitServlet">退出登录</a><%
          	}
          %>
        </div>
    </div>   
    <div class="main">
	    <div class="navbar">
	        <img src="./img/Xbro.png">
	    </div>
	    <div class="menu"></div>
	    <div class="content">
	        <div class="shop" >
	            <span>店名</span>
	        </div>
	        <div class="yp">
	        <%
	        	int product_id = Integer.parseInt(request.getParameter("product_id"));
	        	GoodDao gd = new GoodDaoImpl();
	        	Good g = gd.findGoods(product_id);
	        	int inventory =g.getInventory();
	            List<String> pictures = gd.findAllPictures(product_id);
	        %>
	        
	        	<form action="UpdateGoodServlet" method="post" enctype="multipart/form-data">
                上传图片: <input type="file" name="picture"/>
                <div class="discribe">
                    <p>
                        商品名称:<input type="text" name="name" value=<%=g.getItemName() %>>
                    </p>
                    <p>
                        商品描述:<input type="text" name="detail" value=<%=g.getItemDescription() %>>
                    </p>
                    <p>
                        商品生产批次:<input type="text" name="batch" value=<%=g.getNumber() %>>
                    </p>
                    <p>
                        商品有效期:<input type="date" name="date" value=<%=g.getDate() %>>
                    </p>
                    <p>
                        商品是否为处方药：
                        <%if (g.getIsPres()) { %>
                        <input type="radio" name="option3" value="yes" checked>是
                        <input type="radio" name="option3" value="no">否
                        <%} else { %>
                        <input type="radio" name="option3" value="yes">是 
                        <input type="radio" name="option3" value="no" checked>否
                        <%} %>
                    </p>
                    <p>
                        商品价格:<input type="text" name="price" value=<%=g.getPrice() %>>
                    </p>
                    <p>
                        商品是否被冻结：
                        <%if (g.getIsFrozen()) { %>
                        <input type="radio" name="option4" value="yes" checked>是
                        <input type="radio" name="option4" value="no">否
                        <%} else { %>
                        <input type="radio" name="option4" value="yes">是 
                        <input type="radio" name="option4" value="no" checked>否
                        <%} %>
                    </p>
                    <p>
                    	商品数量：<input type="text" name="inventory" value=<%=g.getInventory() %>>
                    </p>
                    
                    <%if(g.getInventory() != 0){ %>
                    <input type="submit" value="修改">
                    <input type="submit" formaction="DeleteGoodServlet?product_name=<%=g.getItemName() %>" value="下架">
                    <%}else{ %>
                    <input type="submit" value="重新上架">
		        	<%} %>
	        </div>
	        <div>
	        	<!-- 图片全部显示，之后改成切换 -->  
                <%
                	for(String i : pictures){
                		%>
                		<a href="DeletePictureServlet?product_id=<%=product_id %>&url=<%=i %>">
                			<img src=<%=i %>>
                		</a>
                		<%
                	}
                %>
	        </div>
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