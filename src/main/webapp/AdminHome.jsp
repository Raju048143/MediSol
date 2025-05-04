
<%
	String adminname=(String)session.getAttribute("adminname");
	if(adminname==null) {
		session.setAttribute("msg", "Please Login first!");
		response.sendRedirect("index.jsp");
	}else {
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
			<ul class="navbar-nav mx-auto">
				<li><a class="nav-link" href="AdminHome.jsp">Home</a></li>
				<!-- Search box -->
				<li>
					<form class="form-inline my-2 my-lg-0 mr-3"
						action="SearchResults.jsp" method="get">
						<input class="form-control form-control-sm mr-sm-2" type="search"
							name="query" placeholder="Search" aria-label="Search"
							style="height: calc(1.5em + .75rem + 2px);" />
						<button class="btn btn-sm  btn-outline-success my-2 my-sm-0"
							type="submit">Search</button>
					</form>
				</li>
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

	<header class="container mt-4 pt-5 p-5"
		style="background-color: lightblue; border-radius: 30px;">
		<h4 class="pt-3">Add New Item:</h4>
		<form action="AddItem" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<input type="text" name="name" maxlength="100" class="form-control"
					placeholder="Name" required />
			</div>
			<div class="form-group">
				<input type="text" name="cname" maxlength="100" class="form-control"
					placeholder="Company Name" required />
			</div>
			<div class="form-group">
				<input type="text" name="salt" maxlength="100" class="form-control"
					placeholder="Salt(if applicable)" />
			</div>
			<div class="form-group">
				<input type="text" name="price" pattern="[0-9.]+" maxlength="10"
					class="form-control" placeholder="Price" required />
			</div>
			<div class="form-group">
				<input type="number" name="qty" min="1" class="form-control"
					placeholder="Quantity" required />
			</div>
			<div class="form-group">
				<input type="file" name="image" accept="image/*"
					class="form-control" required />
			</div>
			<button type="submit" class="btn btn-primary">Add Item</button>
		</form>
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