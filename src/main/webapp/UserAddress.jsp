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
		ArrayList<String> addresses=db.getAddress(uemail);
		db.closeDBConnection();
%>
<!DOCTYPE html>
<html>
<head>
   <%@include file="component/abc.jsp"%>

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
      <a class="navbar-brand" href="UserHome.jsp">
        <img src="resources/medisol.png" alt=""/> <span>Medi</span>Sol
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
      <div class="collapse navbar-collapse" id="my-navbar">
          <ul class="navbar-nav  mx-auto">
            <li>
              <a class="nav-link" href="UserHome.jsp">Home</a>
            </li>
            <li>
              <a class="nav-link" href="UserOrders.jsp">Orders</a>
            </li>
          </ul>
          <p>
          Welcome: <b><%=user.get("name")%></b>  
          <a class="btn btn-sm btn-warning m-2" href="Cart.jsp">Cart[<%=cartQty %>]</a>
          <a class="btn btn-sm btn-danger m-2" href="Logout">Logout</a>
          </p>
          
      </div>
  </nav>
  
  <header class="container mt-4"  style="background-color: lightblue; border-radius: 30px;">
	     <h5 class="p-2 m-0">Address: </h5>
	     <form action="AddAddress" method="post" >
          <div class="form-row mb-5">
		    <div class="col-10 mb-5">
		    	<textarea name="address" maxlength="300" rows="2" class="form-control" placeholder="your address" required></textarea>
		    </div>
		    <div class="col-2">
		      <button type="submit" class="btn btn-success">Add New Address</button>
		    </div>
		  </div>
        </form>
  </header>
  <%
  	if(!addresses.isEmpty()){
  %>
  	<section class="container bg-light mt-4 p-4" >
  		<h6>Select Address:</h6><br/>
  		<form action="PlaceOrder" method="post"  >
  			<%
			for(String address:addresses){
			%>
				<input type="radio" name="address" value="<%=address %>" required /> <%=address %> <br/><br/>
			<%	
			}
  			%>
		    <button type="submit" class="btn btn-success">Place Order</button>
        </form>
   </section>
  <%		
  	}
  %>
  <footer class="container m-5">
    <div class="row">
      <div class="col-sm m-2 text-left">
        <img src="resources/medisol.png" height="20px" alt=""/> <span class="text-danger"><b>Medi</b></span>Sol
          <p>
        Medisol reliable testing and expert care directly to you, <br>ensuring convenience and accuracy for your health.
        </p>
      </div>
      <div class="col-sm m-2 text-right">
        <p>
          <a class="m-2" href="" target="_blank"><i class="fa-brands fa-facebook-f fa-2x"></i></a>
          <a class="m-2" href="" target="_blank"><i class="fa-brands fa-instagram fa-2x"></i></a>
          <a class="m-2" href="" target="_blank"><i class="fa-brands fa-youtube fa-2x"></i></a>
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