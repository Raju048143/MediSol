<%@page import="java.util.HashMap"%>
<%@page import="com.raju.dao.DAO"%>
<%@page import="java.util.ArrayList"%>
<%
	String adminname=(String)session.getAttribute("adminname");
	if(adminname==null) {
		session.setAttribute("msg", "Please Login first!");
		response.sendRedirect("index.jsp");
	}else {
		DAO db=new DAO();
		ArrayList<HashMap> users=db.getUsers();
		db.closeDBConnection();
%>
<!DOCTYPE html>
<html>
<head>
<title>MediSol</title>
<%@include file="component/ResourceHeader.jsp"%>

</head>
<body>
	<%
		String m=(String)session.getAttribute("msg");
		if(m!=null){
			if(m.contains("success")){
			%>
	<h6 class="bg-success text-white text-center p-3"><%=m %></h6>
	<% 
				session.setAttribute("msg", null);
			}else if(m.contains("failed") || m.contains("Already")){
			%>
	<h6 class="bg-danger text-white text-center p-3"><%=m %></h6>
	<% 
				session.setAttribute("msg", null);
			}else {
			%>
	<h6 class="bg-warning text-center p-3"><%=m %></h6>
	<% 
				session.setAttribute("msg", null);
			}
		}
	%>
	<nav class="navbar navbar-expand-sm container">
		<a class="navbar-brand" href="AdminHome.jsp"> <img
			src="resources/medisol.png" alt="" /> <span>Medi</span>Sol
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#my-navbar">
			<i class="fa-solid fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="my-navbar">
			<ul class="navbar-nav  mx-auto">
				<li><a class="nav-link" href="AdminHome.jsp">Home</a></li>
				<li><a class="nav-link" href="AllItems.jsp">Items</a></li>
				<li><a class="nav-link" href="AdminOrders.jsp">Orders</a></li>
				<li><a class="nav-link" href="Users.jsp">Users</a></li>
				<li><a class="nav-link" href="Prescriptions.jsp">Prescriptions</a>
				</li>
			</ul>
			<p>
				Welcome: <b><%=adminname %></b> <a class="btn btn-sm btn-danger"
					href="Logout">Logout</a>
			</p>
		</div>
	</nav>

	<header class="container  mt-4 p-5"
		style="background-color: lightblue; border-radius: 30px;">
		<h4>All Users:</h4>
		<div class=" row m-1 my-1">
			<table class="container table table-bordered ">
				<thead class="text-center  bg-light">
					<tr>
						<th scope="col">Sr.No</th>
						<th scope="col">Name</th>
						<th scope="col">Email</th>
						<th scope="col">Phone</th>
						<th scope="col">Status</th>
						<th scope="col">Change Status</th>
					</tr>
				</thead>
				<tbody class=" bg-light text-center">
					<%
					int i=1;
					for (HashMap user : users) {
					%>
					<tr>
						<td><%=i++%></td>
						<td><%=user.get("name")%></td>
						<td><%=user.get("email")%></td>
						<td><%=user.get("phone")%></td>
						<td><%=user.get("status")%></td>
						<td>
							<%
							String status = (String) user.get("status");
							if (status.equalsIgnoreCase("active")) {
							%> <a class="btn btn-sm btn-danger"
							href="ChangeUserStatus?email=<%=user.get("email")%>&status=Deactive">Deactive</a>
							<%
							} else {
							%> <a class="btn btn-sm btn-success"
							href="ChangeUserStatus?email=<%=user.get("email")%>&status=Active">Active</a>
							<%
							}
							%>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</header>
	<footer class="container m-5">
		<div class="row">
			<div class="col-sm m-2 text-left">
				<img src="resources/medisol.png" height="20px" alt="" /> <span
					class="text-danger"><b>Medi</b></span>Sol
				<p>
					Medisol reliable testing and expert care directly to you, <br>ensuring
					convenience and accuracy for your health.
				</p>
			</div>
			<div class="col-sm m-2 text-right">
				<p>
					<a class="m-2" href="" target="_blank"><i
						class="fa-brands fa-facebook-f fa-2x"></i></a> <a class="m-2" href=""
						target="_blank"><i class="fa-brands fa-instagram fa-2x"></i></a> <a
						class="m-2" href="" target="_blank"><i
						class="fa-brands fa-youtube fa-2x"></i></a>
				</p>
			</div>
		</div>
	</footer>
	<a id="btnTop"><i class="fa-solid fa-circle-up fa-2x"></i></a>

</body>
<script>
  //AOS
  AOS.init();

  //script for scroll to top
  $("#btnTop").click(function () {
        $("html, body").animate({scrollTop: 0}, 1000);
    });
  //script for scroll to Service Section
  $("#service-menu").click(function () {
      document.getElementById("service").scrollIntoView({behavior: 'smooth'});
    });
  //script for light box
  $(document).on('click', '[data-toggle="lightbox"]', function(event) {
      event.preventDefault();
      $(this).ekkoLightbox();
  });

</script>
</html>
<%
}
%>