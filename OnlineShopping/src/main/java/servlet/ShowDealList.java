package servlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.DealList;
import dao.UserDao;
import dao.impl.UserDaoImpl;
@WebServlet("/ShowDealList")
public class ShowDealList extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public ShowDealList() {
		super();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		show(request,response);
	}
	private void show(HttpServletRequest request, HttpServletResponse response) {
		try {
			
			UserDao ud = new UserDaoImpl();
			DealList dl = new DealList();
			int product_id = Integer.parseInt(request.getParameter("product_id"));
			dl = ud.findDealsByProduct_id(product_id);
			request.getSession().setAttribute("dealList",dl);
		    response.sendRedirect("record.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		doGet(request, response);
	}
	
}