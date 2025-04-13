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
		ArrayList<HashMap> orders=db.getPlacedOrdersByEmail(uemail);
		int cartQty=db.getCartQty(uemail);
		db.closeDBConnection();
%>
<!DOCTYPE html>
<html>
<head>
  <title>MediSol</title>
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
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar">
        <i class="fa-solid fa-bars"></i>
    </button>
    <div class="collapse navbar-collapse" id="my-navbar">
        <ul class="navbar-nav mx-auto">
            <li>
                <a class="nav-link" href="UserHome.jsp">Home</a>
            </li>
            <li>
                <a class="nav-link" href="UserOrders.jsp">Orders</a>
            </li>
        </ul>
        <div class="d-flex align-items-center">
            <!-- Profile Icon and Name -->
            <a href="#" id="toggleProfile" class="text-primary d-flex align-items-center mx-2">
                <i class="fa-solid fa-user-circle fa-lg"></i>
                <span class="ml-1"><%= user.get("name") %></span>
            </a>
            <!-- Cart Icon -->
            <a href="Cart.jsp" class="btn btn-sm btn-warning mx-2 d-flex align-items-center">
                <i class="fa-solid fa-cart-shopping"></i>
                <span class="ml-1">[<%= cartQty %>]</span>
            </a>
            <!-- Logout Button -->
            <a class="btn btn-sm btn-danger mx-2" href="Logout">Logout</a>
        </div>
    </div>
</nav>

<!-- Search Section with Creative bg-info -->
<header class="container mt-4 py-4"  style="background-color: lightblue; border-radius: 30px;">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-12">
            <h4 class=" mb-3">Search for Medicines or Products</h4>
            <form action="SearchItems.jsp" method="post">
                <div class="form-row">
                    <div class="col-12 col-md-10">
                        <input class="form-control border-light rounded-pill" type="text" name="name" maxlength="100" placeholder="Medicine name/Product name" required />
                    </div>
                    <div class="col-12 col-md-2 mt-2 mt-md-0">
                        <button type="submit" class="btn btn-light btn-block rounded-pill shadow-sm hover-shadow">Search</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</header>

<!-- Upload Prescription Section with Creative bg-info -->
<header class="container mt-4 py-4" style="background-color: lightblue; border-radius: 30px;">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10 col-12">
            <h4 class="mb-3">Upload Your Prescription</h4>
            <form action="UploadPrescription" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="col-12 col-md-10">
                        <input class="form-control border-light rounded-pill" type="file" accept=".jpg,.jpeg,.png" name="image" required />
                    </div>
                    <div class="col-12 col-md-2 mt-2 mt-md-0">
                        <button type="submit" class="btn btn-light btn-block rounded-pill shadow-sm hover-shadow">Submit</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</header>

<!-- Custom CSS -->
<style>
    .hover-shadow:hover {
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }
</style>   
  <section class="container-fluid bg-warning mt-4 p-4">
  	<h4 class="text-center">Your Recent Orders:</h4>
  	<%
  	for(HashMap order:orders) {
  	%>
  		<div class="bg-light p-4 m-3">
  			<h6>
  				Order ID: <big><%=order.get("id") %></big> &nbsp;&nbsp;&nbsp;&nbsp;
  				Date: <big><%=order.get("odate") %></big> &nbsp;&nbsp;&nbsp;&nbsp;
  				Amount: <big><%=order.get("amount") %></big> &nbsp;&nbsp;&nbsp;&nbsp;
  				Status: <big class="bg-info text-white p-2"><%=order.get("status") %></big> 
  			</h6>
  			<hr>
  			<%
				String items=(String)order.get("items");
				items=items.substring(0, items.length()-1);
				String i[]=items.split(",");
				for(String item:i){
					String ii[]=item.split(":");
			%>
				<p>
	  				<img height="30px" src="GetImage?name=<%=ii[0]%>"> &nbsp;&nbsp;
	  				<%=ii[0] %> &nbsp;&nbsp; Price: <b><%=ii[1] %></b>
	  			</p>
			<%		
				}
			%>
  			
  		</div>	
  	<%
  	}
  	%>
  </section>
  <footer class="container m-5">
    <div class="row">
      <div class="col-sm m-2 text-left">
        <img src="resources/medisol.png" height="20px" alt=""/> <span class="text-danger"><b>Medi</b></span>Sol
        <p>
       Medisol reliable testing and expert care directly to you,<br>
ensuring convenience and accuracy for your health
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
      
      document.getElementById('toggleProfile').addEventListener('click', function(e) {
          e.preventDefault(); // Prevent page reload
          const profileSection = document.getElementById('profileDetails');
          profileSection.classList.toggle('d-none'); // Toggle visibility
      });
</script>
</html>
<%
}
%>