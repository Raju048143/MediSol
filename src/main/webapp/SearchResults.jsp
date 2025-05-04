<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.raju.dao.DAO"%>
<%@page import="java.util.ArrayList"%>

<%
    String adminname = (String) session.getAttribute("adminname");
    if (adminname == null) {
        session.setAttribute("msg", "Please Login first!");
        response.sendRedirect("index.jsp");
        return;
    }

    DAO db = new DAO();
    ArrayList<HashMap> prescriptions = db.getPrescriptions();
    db.closeDBConnection();
%>

<!DOCTYPE html>
<html>
<head>
<title>MediSol</title>
<%@include file="component/ResourceHeader.jsp"%>
</head>
<body>
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
				<li><a class="nav-link" href="AllItems.jsp">Items</a></li>
				<li><a class="nav-link" href="AdminOrders.jsp">Orders</a></li>
				<li><a class="nav-link" href="Users.jsp">Users</a></li>
				<li><a class="nav-link" href="Prescriptions.jsp">Prescriptions</a></li>
			</ul>
			<p>
				Welcome: <b><%= adminname %></b> <a class="btn btn-sm btn-danger"
					href="Logout">Logout</a>
			</p>
		</div>
	</nav>

	<header class="container mt-4 p-5"
		style="background-color: lightblue; border-radius: 30px;">
		<div class="row">
			<div class="col-sm m-2">

				<!-- Display Items -->
				<%
                String name = request.getParameter("query");
                boolean flag=true;
                if (name != null && !name.trim().isEmpty()) {
                    db = new DAO();
                    ArrayList<HashMap> items = db.getItemsLike(name);
                    db.closeDBConnection();
                    for (HashMap item : items) {
            %>
				<div class="row bg-light p-4 my-2">
					<div class="col-3">
						<img height="100px" src="GetImage?name=<%= item.get("name") %>"
							alt="Product Image">
					</div>
					<div class="col-9">
						<p>
							Name: <b><%= item.get("name") %></b> | Company: <b><%= item.get("cname") %></b>
							| Salt: <b><%= item.get("salt") %></b>
						</p>
						<p>
							Price: <b><%= item.get("price") %></b> Quantity: <b><%= item.get("qty") %></b>
						</p>
						<%
                        int q = (int) item.get("qty");
                    
                        if(name.equals( item.get("name")))
                 	   flag=false;
                        if (q <= 0) {
                    %>
						<label class="bg-danger text-white p-2">Out of stock</label>
						<%
                        }
                    %>
						<form action="EditItem.jsp" method="post">
							<input type="hidden" name="name" value="<%=item.get("name")%>" />
							<button class="btn btn-sm btn-primary">Edit Item</button>
						</form>
					</div>
				</div>
				<%
                    }
                    
                    if(flag==true)
                    {
                    	 %>
				<h1 class="bg-danger text-white text-center p-2">Currently Not
					Available</h1>
				<%
                    }
                }
            %>
			</div>
		</div>
	</header>

	<footer class="container m-5">
		<div class="row">
			<div class="col-sm m-2 text-left">
				<img src="resources/medisol.png" height="20px" alt="" /> <span
					class="text-danger"><b>Medi</b></span>Sol
				<p>Lorem ipsum dolor sit amet consectetur.</p>
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

	<script>
    // Scroll to Top
    $("#btnTop").click(function () {
        $("html, body").animate({ scrollTop: 0 }, 1000);
    });
</script>
</body>
</html>
