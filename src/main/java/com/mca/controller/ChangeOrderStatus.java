package com.mca.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.raju.dao.DAO;

/**
 * Servlet implementation class ChangeOrderStatus
 */
@WebServlet("/ChangeOrderStatus")
public class ChangeOrderStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int id=Integer.parseInt(request.getParameter("id"));
			String status=request.getParameter("status");
			String page=request.getParameter("page");
			DAO db=new DAO();
			if(status.equalsIgnoreCase("cancel")) {
				String items=db.getPlacedOrdersById(id);
				items=items.substring(0, items.length()-1);
				String i[]=items.split(",");
				for(String item:i){
					String ii[]=item.split(":");
					db.itemQtyIncDesc(ii[0],-1);
				}
			}
			String result=db.changeOrderStatus(id, status);
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			db.closeDBConnection();
			response.sendRedirect(page+".jsp");
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
