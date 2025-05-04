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
		ArrayList<HashMap> prescriptions=db.getPrescriptions();
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
		String m=(String)session.getAttribute("result");
		if(m!=null){
			if(m.contains("success")){
			%>
	<h6 class="bg-success text-white text-center p-3"><%=m %></h6>
	<% 
				session.setAttribute("msg", null);
			}else if(m.contains("failed")){
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
	<header class="container mt-4 p-5"
		style="background-color: lightblue; border-radius: 30px;">
		<h4 class="">Prescriptions:</h4>

		<%
    for (HashMap prescription : prescriptions) {
        String status = (String) prescription.get("status");
    %>

		<div class="row bg-light m-1 p-3 my-2"
			style="border-radius: 10px; overflow: hidden; height: 150px;">
			<!-- Prescription Image -->
			<div class="col-3 d-flex justify-content-center align-items-center">
				<a target="_blank"
					href="GetPrescriptionImage?id=<%= prescription.get("id") %>"> <img
					class="img-fluid"
					src="GetPrescriptionImage?id=<%= prescription.get("id") %>"
					alt="Prescription Image"
					style="height: 120px; object-fit: contain; max-width: 100%; border-radius: 5px;">
				</a>
			</div>

			<!-- Prescription Details -->
			<div class="col-9 d-flex flex-column justify-content-center">
				<p class="mb-1" style="font-size: 14px;">
					Email: <b><%= prescription.get("email") %></b>
				</p>
				<!--   <p class="mb-1" style="font-size: 14px;">Status: <b><%= status %></b></p>-->

				<!-- Conditional Buttons -->
				<div class="d-flex justify-content-start gap-2 mt-2">
					<% if (status.equalsIgnoreCase("pending")) { %>
					<!-- Add to Cart Button -->
					<form action="CartForUser.jsp" method="post" class="d-inline">
						<input type="hidden" name="uemail"
							value="<%= prescription.get("email") %>" /> <input type="hidden"
							name="id" value="<%= prescription.get("id") %>" />
						<button class="btn btn-sm btn-success px-3 py-1"
							style="font-size: 12px;">Add to Cart</button>
					</form>

					<% } else { %>
					<!-- Already Done Message -->
					<span class="btn btn-sm btn-secondary px-3 py-1"
						style="font-size: 12px; cursor: default;">Completed</span>
					<% } %>
				</div>
			</div>
		</div>

		<% 
    }
    %>
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