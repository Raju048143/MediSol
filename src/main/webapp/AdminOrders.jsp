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
		ArrayList<HashMap> orders=db.getOrders();
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


	<header class="container-fluid mt-4 p-5"
		style="background-color: lightblue; border-radius: 30px;">
		<h4>All Orders:</h4>
		<div class=" p-1 my-1">
			<table class="container-fluid table ">
				<thead class="text-center  bg-light">
					<tr>

						<th scope="col">Order ID:</th>
						<th scope="col">Name</th>
						<th scope="col">Date</th>

						<th scope="col">Amount</th>
						<th scope="col">Status</th>
						<th scope="col">Action</th>
						<th scope="col">Address</th>
					</tr>
				</thead>
				<tbody class=" bg-light text-center">
					<%
					for (HashMap order:orders) {
					%>
					<tr>

						<td><%=order.get("id") %></td>
						<td>
							<%
				String items=(String)order.get("items");
				items=items.substring(0, items.length());
				String i[]=items.split(",");
				for(String item:i){
					String ii[]=item.split(":");
			%> <img height="30px" src="GetImage?name=<%=ii[0]%>">
							&nbsp;&nbsp;<%=ii[0] %> <%		
				}
			%>
						</td>
						<td><%=order.get("odate") %></td>

						<td><%=order.get("amount") %></td>
						<td><%=order.get("status") %>
						<td>
							<%
  				String status=(String)order.get("status");
  				if(status.equalsIgnoreCase("Placed")){
  					%> <a class="btn btn-sm btn-danger"
							href="ChangeOrderStatus?id=<%=order.get("id") %>&status=Cancel&page=AdminOrders">Cancel</a>
							<a class="btn btn-sm btn-success"
							href="ChangeOrderStatus?id=<%=order.get("id") %>&status=Confirmed&page=AdminOrders">Confirm</a>
							<%
  				}else if(status.equalsIgnoreCase("Confirmed")){
  					%> <a class="btn btn-sm btn-primary"
							href="ChangeOrderStatus?id=<%=order.get("id") %>&status=Delivered&page=AdminOrders">Delivered</a>
							<%
				}else{
					%> NA <%
				}
  				%>
						</td>
						</td>
						<td><%=order.get("address") %></td>

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
					Medisol reliable testing and expert care directly to you,<br>
					ensuring convenience and accuracy for your health
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