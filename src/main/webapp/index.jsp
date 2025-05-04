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
	<p class="text-center bg-light p-2">
		For any emergency contact <a href="tel:9811XXXXXX">9811XXXXXX</a> or
		email at <a href="mailto:info@plusdemic.com">info@medisol.com</a>
	</p>
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
	<header class="container mt-3 pt-4"
		style="background-color: lightblue; border-radius: 30px;">
		<div class="pl-5 pr-3 pt-4">
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
		<div class="row p-5">
			<div class="col-sm" data-aos="zoom-in" data-aos-duration="2000">
				<h2>Covid-19 Risk Assessment</h2>
				<p>At MediSol, your safety is our priority during the COVID-19
					pandemic. We offer secure, contactless deliveries with sanitized
					packaging and regular health checks for delivery personnel. Those
					above 65 years, with pre-existing conditions like diabetes or heart
					disease, or weakened immunity, are at greater risk. To protect
					yourself, avoid unnecessary trips by ordering medicines online,
					consult healthcare providers via telemedicine, and follow
					preventive measures like washing hands, wearing masks, and
					practicing social distancing. Together, we can safeguard our
					communities—explore our services today for safe and reliable
					healthcare solutions.</p>
			</div>
			<div class="col-sm" data-aos="fade-left" data-aos-duration="2000">
				<img src="resources/img1.jpg" alt=""> <img
					src="resources/img2.jpg" alt=""> <img
					src="resources/img3.jpg" alt=""> <img
					src="resources/img4.jpg" alt=""> <img
					src="resources/img5.jpg" alt=""> <img
					src="resources/img6.jpg" alt="">
			</div>
		</div>
	</header>
	<section class="container mt-4 p-4">
		<div class="row">
			<div class="col-sm-8">
				<div class="row">
					<div class="col-sm my-2">
						<div class="mycard">
							<div class="image-circle">
								<img src="resources/icon1.png" alt="">
							</div>
							<h5>Triage</h5>
							<p>Triage prioritizes patients or tasks by urgency to
								allocate resources effectively, especially in emergencies or
								high-demand settings</p>
						</div>
					</div>
					<div class="col-sm my-2">
						<div class="mycard">
							<div class="image-circle">
								<img src="resources/icon2.png" alt="">
							</div>
							<h5>Laboratory</h5>
							<p>At Medisol, our laboratory delivers accurate, controlled
								testing and research to ensure reliable health results and
								insights.</p>
						</div>
					</div>
					<div class="col-sm my-2">
						<div class="mycard">
							<div class="image-circle">
								<img src="resources/icon3.png" alt="">
							</div>
							<h5>Medicine</h5>
							<p>Medisol brings quality medicines and expert care to your
								doorstep, ensuring convenience and peace of mind for your
								health.</p>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div>
					<h3>How it helps people</h3>
					<p>Online medicine delivery systems offer a safe and convenient
						way to access essential healthcare, reducing the need for trips to
						pharmacies and minimizing infection risks. With contactless
						delivery, sanitized packaging, and telemedicine support, they
						ensure timely and secure delivery of medicines to your doorstep.
						Whether for routine prescriptions or urgent needs, these services
						prioritize your health and convenience, making healthcare more
						accessible and reliable, especially during challenging times like
						the COVID-19 pandemic.</p>
					<!-- 	<button class="btn btn-light" data-toggle="modal" data-target="#my-Modal">Get
						in touch</button> -->
				</div>
			</div>
		</div>
	</section>
	<section>
		<div id="carouselExampleControls" class="carousel slide"
			data-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="resources/slide1.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="resources/slide2.jpg" class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img src="resources/slide3.jpg" class="d-block w-100" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-target="#carouselExampleControls" data-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-target="#carouselExampleControls" data-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</button>
		</div>
	</section>
	<hr>
	<section class="container" id="service">
		<div class="row">
			<div class="col-sm m-2" data-aos="fade-up" data-aos-duration="1000"
				data-aos-delay="100">
				<h2>How to use it</h2>
				<p>Using an online medicine delivery system is simple. Visit the
					platform, search for your required medicines, upload prescriptions
					if needed, and place your order. Choose contactless delivery for
					added safety. Payments can be made online, and your medicines will
					be delivered securely to your doorstep. Enjoy safe, convenient, and
					hassle-free service!</p>
				<!--  	<button class="btn btn-light" data-toggle="modal" data-target="#my-Modal">Get
					in touch</button>-->
			</div>
			<div class="col-sm m-2 text-center" data-aos="fade-up"
				data-aos-duration="1000" data-aos-delay="400">
				<img src="resources/image1.jpg" class="rounded-lg img-fluid" alt="">
				<h6 class="p-2 text-muted">Coronavirus</h6>
			</div>
			<div class="col-sm m-2 text-center" data-aos="fade-up"
				data-aos-duration="1000" data-aos-delay="700">
				<img src="resources/image2.jpg" class="rounded-lg img-fluid"
					height="250px" alt="">
				<h6 class="p-2 text-muted">Diagnostic</h6>
			</div>
			<div class="col-sm m-2 text-center" data-aos="fade-up"
				data-aos-duration="1000" data-aos-delay="1000">
				<img src="resources/image3.jpg" class="rounded-lg img-fluid"
					height="250px" alt="">
				<h6 class="p-2 text-muted">Test</h6>
			</div>
		</div>
	</section>
	<section class="container-fluid bg-info p-5 text-center">
		<div class="container gallery">
			<a href="resources/img1.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="resources/img1.jpg" alt="" /></a>
			<a href="resources/img2.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="resources/img2.jpg" alt="" /></a>
			<a href="resources/img3.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="resources/img3.jpg" alt="" /></a>
			<a href="resources/img4.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="resources/img4.jpg" alt="" /></a>
			<a href="resources/img5.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="resources/img5.jpg" alt="" /></a>
			<a href="resources/img6.jpg" data-toggle="lightbox"
				data-gallery="my-gallery"><img src="resources/img6.jpg" alt="" /></a>
		</div>
	</section>
	<section class="container bg-light my-4 p-5 text-center">
		<h3 data-aos="zoom-out" data-aos-duration="1000" data-aos-delay="100">Why
			you can trust this tool</h3>
		<div class="row container m-5" data-aos="zoom-out"
			data-aos-duration="1000" data-aos-delay="500">
			<div class="col-sm">
				<div class="row">
					<div class="col-2 text-right">
						<img src="resources/icon1.png" height="50px" alt="">
					</div>
					<div class="col-10 text-left">
						<h5>You can trust Medisol for its commitment to quality,
							reliability, and convenience.</h5>
						<p>We provide accurate, timely delivery of medicines, expert
							care through telemedicine, and a focus on your health and safety.
							Our processes are designed to meet the highest standards.</p>
					</div>
				</div>
			</div>
			<div class="col-sm">
				<div class="row">
					<div class="col-2 text-right">
						<img src="resources/icon2.png" height="50px" alt="">
					</div>
					<div class="col-10 text-left">
						<h5>You can trust Medisol laboratory for its commitment to
							accuracy and reliability.</h5>
						<p>We use advanced technology and adhere to the highest
							standards to provide precise test results, ensuring your health
							is in safe hands</p>
					</div>
				</div>
			</div>
		</div>
	</section>
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
	<!-- Modal Get In Touch! -->
	<div class="modal fade" id="my-Modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Get In Touch!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="AddEnquiry">
						<input name="name" class="form-control p-4 my-2" type="text"
							maxlength="20" pattern="[a-zA-Z ]+" placeholder="Your Name"
							required /> <input name="phone" class="form-control p-4 my-2"
							type="tel" maxlength="10" minlength="10" pattern="[0-9]+"
							placeholder="Your Phone" required />
						<button class="btn btn-success my-2">Submit</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-info">
					<h5 class="modal-title text-white" id="exampleModalLabel">Admin
						Login Form</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="AdminLogin" method="post">
						<div class="form-group">
							<input type="text" name="id" maxlength="100" class="form-control"
								placeholder="Admin ID" required />
						</div>
						<div class="form-group">
							<input type="password" name="password"
								pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
								maxlength="20" class="form-control" placeholder="Admin Password"
								required />
						</div>
						<button type="submit" class="btn btn-primary">Login</button>
					</form>
				</div>
			</div>
		</div>
	</div>
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