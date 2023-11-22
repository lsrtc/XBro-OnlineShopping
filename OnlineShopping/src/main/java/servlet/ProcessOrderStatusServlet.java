package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GoodsDao;
import dao.UserDao;
import dao.impl.GoodsDaoImpl;
import dao.impl.UserDaoImpl;


@WebServlet("/ProcessOrderStatusServlet")
public class ProcessOrderStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProcessOrderStatusServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void success(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int product_id = Integer.parseInt(request.getParameter("product_id"));
		UserDao ud = new UserDaoImpl();
		ud.closedeal(product_id);
		response.sendRedirect("back_stage.jsp");
	}
    
    protected void fail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int transaction_id = Integer.parseInt(request.getParameter("transaction_id"));
    	UserDao ud = new UserDaoImpl();
    	int product_id = ud.unfreezeGood(transaction_id);
    	GoodsDao gd = new GoodsDaoImpl();
		gd.takeOnGood(product_id);
		response.sendRedirect("back_stage.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String method = request.getParameter("method");
		if("success".equals(method)) {
			success(request, response);
		}else if("fail".equals(method)) {
			fail(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
