package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.User;
import dao.UserDao;
import dao.impl.UserDaoImpl;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String method = request.getParameter("method");
		if ("business".equals(method)) {
			businessRegister(request, response);
		} else if ("user".equals(method)) {
			userRegister(request, response);
		}
	}

	private void businessRegister(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		try {
	    	request.setCharacterEncoding("utf-8");
	        response.setCharacterEncoding("utf-8");
			UserDao ud = new UserDaoImpl();

			String oou = ud.onlyOneUser();
			if (oou.equals("")) {
				String username = request.getParameter("UserName");
				String password = request.getParameter("Password");
				String name = request.getParameter("Name");
				String id_card = request.getParameter("Id");
				String sex = request.getParameter("sex");
				String tele = request.getParameter("tel");
				String e_mail = request.getParameter("email");
				String birth = request.getParameter("birthday");

                User user = new User();
                user.setUserName(username);
                user.setPassword(password);
                user.setName(name);
                user.setId_card(id_card);
                user.setSex(sex);
                user.setTele(tele);
                user.setE_mail(e_mail);
                user.setBirth(birth);

				ud.businessRegister(user);
				response.sendRedirect("login.jsp");
			} else {
				String pbm = "hasOneUser";
				request.setAttribute("pbm", pbm);
				request.getRequestDispatcher("register.jsp").forward(request, response);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	private void userRegister(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		try {
			UserDao ud = new UserDaoImpl();

			String username = request.getParameter("UserName");
			String password = request.getParameter("Password");
			String name = request.getParameter("Name");
			String id_card = request.getParameter("Id");
			String sex = request.getParameter("sex");
			String tele = request.getParameter("tel");
			String defaultAddress = request.getParameter("defaultAddress");
			if(ud.hasSameUsername(username)) {
				String pbm = "hasSameUsername";
				request.setAttribute("pbm", pbm);
				request.getRequestDispatcher("register.jsp").forward(request, response);
			}else {
				User user = new User();
				user.setUserName(username);
				user.setPassword(password);
				user.setName(name);
				user.setId_card(id_card);
				user.setSex(sex);
				user.setTele(tele);
				user.setAddress(defaultAddress);
				
				ud.userRegister(user);
				response.sendRedirect("login.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
