<%@page import="java.util.List" %>
<%@page import="dao.impl.GoodDaoImpl" %>
<%@page import="dao.GoodDao" %>
<%@page import="bean.Good" %>
<%@page import="bean.GoodList" %>
<%@page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link type="text/css" rel="stylesheet" href="./CSS/main.css">
</head>

<body>
<%
// GoodDao gd = new GoodDaoImpl();
// GoodList gl = (GoodList) session.getAttribute("goodsList");
GoodDao gd = new GoodDaoImpl();
// GoodList gl = new GoodList();
GoodList gl = gd.findForSaleGoods();
%>
<div class="head">
    <div class="header">
        <a href="main.jsp">首页</a>
        <c:if test="${curUser.user_group eq 'seller' }">
	        <a href="back_stage.jsp">进入后台</a>
        </c:if>
        <c:if test="${curUser.user_group eq 'user' }">
	        <a href="ShowBuyerDeal?method=userCheck">查看下单详情</a>
        </c:if>
        <c:choose>
            <c:when test="${empty sessionScope.curUser}">
                <a href="login.jsp">登录</a>
                <a href="register.jsp">注册</a>
            </c:when>
            <c:otherwise>
                <a href="QuitServlet">退出登录</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div class="main">
    <div class="navbar">
        <img src="./img/Xbro.jpg">
    </div>
    <div class="search-container">
		<div class="search-box">
			<input type="text" placeholder="请输入商品名搜索" id="words">
			<button type="submit" onclick="loadSearchContent()">查找</button>
		</div>
	</div>
    <div class="menu">
   	    <ul>
	        <li class="menu-item">
	            <a href="#" onclick="toggleMenu('prescription')">处方药</a>
	            <ul id="prescription" class="submenu" style="display:none;">
	                <li><a href="#" onclick="loadCategoryContent('1')">心血管药物</a></li>
	                <li><a href="#" onclick="loadCategoryContent('2')">抗生素</a></li>
	                <li><a href="#" onclick="loadCategoryContent('3')">抗抑郁药</a></li>
	                <li><a href="#" onclick="loadCategoryContent('4')">镇痛药</a></li>
	                <li><a href="#" onclick="loadCategoryContent('5')">其它</a></li>
	            </ul>
	        </li>
	        <li class="menu-item">
	            <a href="#" onclick="toggleMenu('otc')">非处方药（OTC）</a>
	            <ul id="otc" class="submenu" style="display:none;">
	                <li><a href="#" onclick="loadCategoryContent('6')">感冒和流感</a></li>
	                <li><a href="#" onclick="loadCategoryContent('7')">止痛药</a></li>
	                <li><a href="#" onclick="loadCategoryContent('8')">消化系统药物</a></li>
	                <li><a href="#" onclick="loadCategoryContent('9')">皮肤护理药膏</a></li>
	                <li><a href="#" onclick="loadCategoryContent('10')">其它</a></li>
	            </ul>
	        </li>
	    </ul>
    </div>
    <div class="content">
            <%
                for (Good g : gl.getGoodsList()) {
                    List<String> pictures = gd.findAllPictures(g.getId());
            %>
	            	<div class="yp">
	                    <a href="ShowGoodsDetail?product_id=<%=Integer.toString(g.getId())%>">
	                    	<%if(pictures.size()>0){ %>
	                        <img src=<%=pictures.get(0)%>>
	                        <%} %>
	                    </a>
	                    <a href="ShowGoodsDetail?product_id=<%=Integer.toString(g.getId())%>">
	                        <p><%=g.getItemName()%></p>
	                    </a>
	            	</div>
            <%
                }
            %>
        
    </div>
    <div class="footer">
        <a href="#">关于我们</a>
        <a href="#">联系我们</a>
        <a href="#">隐私政策</a>
        <a href="#">公益活动</a>
    </div>
</div>
<script type="text/javascript">
function toggleMenu(menuId) {
    var menu = document.getElementById(menuId);
    if (menu.style.display === 'none') {
        menu.style.display = 'block';
    } else {
        menu.style.display = 'none';
    }
}

function loadCategoryContent(psid) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'GetCategoryGoods?psid=' + psid, true);
    xhr.onload = function () {
        if (this.status === 200) {
            document.querySelector('.content').innerHTML = this.responseText;
        }
    };
    xhr.send();
}

function loadSearchContent() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'SearchForGoodsServlet?words=' + document.getElementById('words').value, true);
    xhr.onload = function () {
        if (this.status === 200) {
            document.querySelector('.content').innerHTML = this.responseText;
        }
    };
    xhr.send();
}
</script>
</body>
</html>
