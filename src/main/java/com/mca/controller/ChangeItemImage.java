package com.mca.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

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
 * Servlet implementation class ChangeItemImage
 */
@WebServlet("/ChangeItemImage")
@MultipartConfig
public class ChangeItemImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String name=request.getParameter("name");
			Part p=request.getPart("image");
			InputStream image=p.getInputStream();
			
			DAO db=new DAO();
			String result=db.changeItemImage(name,image);
			db.closeDBConnection();
			
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			response.sendRedirect("EditItem.jsp?name="+name);
			
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
