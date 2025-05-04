<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.raju.dao.DAO"%>
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
			}else {
			%>
	<h6 class="bg-danger text-white text-center p-3"><%=m %></h6>
	<% 
			}
			session.setAttribute("msg", null);
		}
	%>
	<%
		String uemail=(String)session.getAttribute("uemail");
		if(uemail==null){
	%>
	<nav class="navbar navbar-expand-sm container">
		<a class="navbar-brand" href="index.jsp"> <img
			src="resources/medisol.png" alt="" /> <span>Medi</span>Sol
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#my-navbar">
			<i class="fa-solid fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="my-navbar">
			<ul class="navbar-nav  mx-auto">
				<li><a class="nav-link" href="index.jsp">Home</a></li>
				<li><a class="nav-link" href="UserLogin.jsp">User
						Sign-In/Sign-Up</a></li>
			</ul>
			<button class="btn btn-light" data-toggle="modal"
				data-target="#myModal">Admin Login</button>
		</div>
	</nav>
	<%		
		}else{
			DAO db=new DAO();
			HashMap user=db.getUserByEmail(uemail);
			int cartQty=db.getCartQty(uemail);
			db.closeDBConnection();
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
			<ul class="navbar-nav  mx-auto">
				<li><a class="nav-link" href="UserHome.jsp">Home</a></li>
				<li><a class="nav-link" href="UserOrders.jsp">Orders</a></li>
			</ul>
			<p>
				Welcome: <b><%=user.get("name")%></b> <a
					class="btn btn-sm btn-warning m-2" href="Cart.jsp">Cart[<%=cartQty %>]
				</a> <a class="btn btn-sm btn-danger m-2" href="Logout">Logout</a>
			</p>

		</div>
	</nav>
	<%		
		}
	%>
	<header class="container mt-4 p-5"
		style="background-color: lightblue; border-radius: 30px;">
		<div class="p-2">
			<form action="SearchItems.jsp" method="post">
				<div class="form-row">
					<div class="col-10">
						<input class="form-control" type="text" name="name"
							maxlength="100" placeholder="Medicine name/Product name" required />
					</div>
					<div class="col-2">
						<button type="submit" class="btn btn-success">Search</button>
					</div>
				</div>
			</form>
		</div>
		<h4>Items:</h4>
		<%
      	String name=request.getParameter("name");
      	DAO db=new DAO();
		ArrayList<HashMap> items=db.getItemsLike(name);
		db.closeDBConnection();
		if(items.isEmpty()){
			%>
		<h6 class="bg-danger text-white text-center p-3">NO Item Found!</h6>
		<%
		}
		for(HashMap item:items) {
			%>
		<div class="row bg-light p-4 my-2">
			<div class="col-3">
				<img height="100px" src="GetImage?name=<%=item.get("name")%>">
			</div>
			<div class="col-9">
				<p>
					Name: <b> <%= item.get("name") %>
					</b> Company Name: <b> <%= item.get("cname") %>
					</b> Salt: <b> <%= item.get("salt") %>
					</b>
				</p>
				<p>
					Price: <b> <%= item.get("price") %>
					</b>
					<%
					int q=(int)item.get("qty");
					if(q>0){
					%>
				
				<form action="AddToCart" method="post">
					<input type="hidden" name="name" value="<%=item.get("name")%>" />
					<input type="hidden" name="itemSearchName" value="<%=name%>" />
					<button class="btn btn-sm btn-warning">Add to Cart</button>
				</form>
				<%	
					}else{
					%>
				<br /> <br /> <label class='bg-danger text-white p-2'>Currently
					Not Available</label>
				<%	
					}
					%>
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
					<a class="m-2" href="http://www.facebook.com/incapp"
						target="_blank"><i class="fa-brands fa-facebook-f fa-2x"></i></a>
					<a class="m-2" href="http://www.instagram.com/incapp.in"
						target="_blank"><i class="fa-brands fa-instagram fa-2x"></i></a> <a
						class="m-2" href="http://www.youtube.com/incapp" target="_blank"><i
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
