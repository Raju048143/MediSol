<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.raju.dao.DAO"%>
<%
	String uemail=(String)session.getAttribute("uemail");
	if(uemail==null) {
		session.setAttribute("msg", "Please Login first!");
		response.sendRedirect("UserLogin.jsp");
	}else {
		DAO db=new DAO();
		HashMap user=db.getUserByEmail(uemail);
		int cartQty=db.getCartQty(uemail);
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
		<a class="navbar-brand" href="UserHome.jsp"> <img
			src="resources/medisol.png" alt="" /> <span>Medi</span>Sol
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#my-navbar">
			<i class="fa-solid fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="my-navbar">
			<ul class="navbar-nav mx-auto">
				<li><a class="nav-link" href="UserHome.jsp">Home</a></li>
				<li><a class="nav-link" href="UserOrders.jsp">Orders</a></li>
			</ul>
			<div class="d-flex align-items-center">
				<!-- Profile Icon and Name -->
				<a href="#" id="toggleProfile"
					class="text-primary d-flex align-items-center mx-2"> <i
					class="fa-solid fa-user-circle fa-lg"></i> <span class="ml-1"><%= user.get("name") %></span>
				</a>
				<!-- Cart Icon -->
				<a href="Cart.jsp"
					class="btn btn-sm btn-warning mx-2 d-flex align-items-center">
					<i class="fa-solid fa-cart-shopping"></i> <span class="ml-1">[<%= cartQty %>]
				</span>
				</a>
				<!-- Logout Button -->
				<a class="btn btn-sm btn-danger mx-2" href="Logout">Logout</a>
			</div>
		</div>
	</nav>

	<!-- Profile Details Section (Initially Hidden) -->
	<div id="profileDetails"
		class="container mt-3 bg-light p-3 rounded d-none">
		<h5>User Profile</h5>
		<div class="row">
			<div class="col-md-6">
				<p>
					<strong>Name:</strong>
					<%= user.get("name") %></p>
				<p>
					<strong>Email:</strong>
					<%= user.get("email") %></p>
			</div>
			<div class="col-md-6">
				<p>
					<strong>Phone:</strong>
					<%= user.get("phone") %></p>
				<p>
					<strong>Status:</strong> <span
						class="<%= user.get("status").equals("Active") ? "text-success" : "text-danger" %>">
						<%= user.get("status") %>
					</span>
				</p>
			</div>
		</div>
	</div>

	<header class="container mt-4 p-4"
		style="background-color: lightblue; border-radius: 30px;">
		<div class="bg-light m-3 p-5">

			<%
        db = new DAO();
        HashMap<Integer, String> items = db.getCartItemsByEmail(uemail);
        double total = 0;

        if (items.isEmpty()) {
    %>
			<div class="text-center">
				<p class="p-2 text-muted">Your cart is currently empty.</p>
				<a href="UserHome.jsp" class="btn btn-primary">Continue Shopping</a>
			</div>
			<%
        } else {
            Set set = items.keySet();
            Iterator iterator = set.iterator();
            while (iterator.hasNext()) {
                int id = (int) iterator.next();
                String item_name = (String) items.get(id);
    %>
			<div
				class="d-flex align-items-center justify-content-between p-3 bg-light border-bottom">
				<div class="d-flex align-items-center">
					<img height="50px" class="rounded mr-3"
						src="GetImage?name=<%= item_name %>" alt="<%= item_name %>">
					<div>
						<p class="m-0 font-weight-bold"><%= item_name %></p>
						<%
                        HashMap item = db.getItemByName(item_name);
                        int qty = (int) item.get("qty");
                        double price = (double) item.get("price");
                        total += price;
                        
                        if (qty <= 0) {
                    %>
						<small class="text-danger">Out of Stock</small>
						<%
                        } else {
                    %>
						<small>Price: &#8377;<%= price %></small>
						<%
                        }
                    %>
					</div>
				</div>
				<a class="btn btn-sm btn-danger" href="RemoveFromCart?id=<%= id %>">Remove</a>
			</div>
			<%
            }
        }
        db.closeDBConnection();
    %>
			<%
        if (!items.isEmpty()) {
    %>
			<div class="text-right mt-4 bg-light p-3">
				<h6>
					Total Amount: <span class="text-primary">&#8377;<%= total %></span>
				</h6>
				<a class="btn btn-success" href="UserAddress.jsp">Place Order</a>
			</div>
			<%
        }
    %>
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

      document.getElementById('toggleProfile').addEventListener('click', function(e) {
          e.preventDefault(); 
          const profileSection = document.getElementById('profileDetails');
          profileSection.classList.toggle('d-none'); 
      });
</script>
</html>
<%
}
%>