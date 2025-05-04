<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
<%@page import="com.raju.dao.DAO"%>
<html>
<head>
<title>MediSol</title>
<%@include file="component/ResourceHeader.jsp"%>
</head>
<body>
	<p class="text-center bg-light p-2">
		For any emergency contact <a href="tel:9811XXXXXX">9811XXXXXX</a> or
		email at <a href="mailto:info@plusdemic.com">info@medisol.com</a>
	</p>

	<nav class="navbar navbar-expand-sm container">
		<a class="navbar-brand" href="index.jsp"> <img
			src="resources/medisol.png" alt="" /> <span>Medi</span>Sol
		</a>

	</nav>
	<header class="container mt-4">
		<h3 class="jumbotron bg-warning text-dark text-center">Something
			went wrong. Please try after some time.</h3>
	</header>

	<footer class="container m-5">
		<div class="row">
			<div class="col-sm m-2 text-left">
				<img src="resources/medisol.png" height="20px" alt="" /> <span
					class="text-danger"><b>Medi</b></span>Sol
				<p>
					Lorem ipsum dolor sit amet consectetur. <br> Lorem ipsum dolor
					sit amet consectetur adipisicing elit.
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