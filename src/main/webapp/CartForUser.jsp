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
    <%@include file="component/abc.jsp"%>
</head>
<body>
<%
    // Display messages
    String m = (String) session.getAttribute("msg");
    if (m != null) {
        if (m.contains("success")) {
%>
            <h6 class="bg-success text-white text-center p-3"><%= m %></h6>
<% 
        } else {
%>
            <h6 class="bg-warning text-center p-3"><%= m %></h6>
<%
        }
        session.setAttribute("msg", null);
    }
%>

<nav class="navbar navbar-expand-sm container">
    <a class="navbar-brand" href="AdminHome.jsp">
        <img src="resources/medisol.png" alt=""/> <span>Medi</span>Sol
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
    <div class="collapse navbar-collapse" id="my-navbar">
        <ul class="navbar-nav mx-auto">
            <li><a class="nav-link" href="AdminHome.jsp">Home</a></li>
            <li><a class="nav-link" href="AllItems.jsp">Items</a></li>
            <li><a class="nav-link" href="AdminOrders.jsp">Orders</a></li>
            <li><a class="nav-link" href="Users.jsp">Users</a></li>
            <li><a class="nav-link" href="Prescriptions.jsp">Prescriptions</a></li>
        </ul>
        <p>Welcome: <b><%= adminname %></b> <a class="btn btn-sm btn-danger" href="Logout">Logout</a></p>
    </div>
</nav>

<%
    String uemail = request.getParameter("uemail");
    int pid = -1;

    try {
        pid = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        pid = -1; // Invalid PID fallback
    }

    if (uemail != null) {
        session.setAttribute("uemail", uemail);
    } else {
        uemail = (String) session.getAttribute("uemail");
    }
%>

<header class="container mt-4 p-5"  style="background-color: lightblue; border-radius: 30px;">
    <div class="row">
        <div class="col-sm m-2">
        <div class="">
            <a target="_blank" href="GetPrescriptionImage?id=<%=pid %>">
                <img class="img-fluid" 
                     src="GetPrescriptionImage?id=<%= pid %>" 
                     alt="Prescription Image" >
            </a>
                   <!-- Done Button
                    <a class="btn btn-sm btn-danger px-3 py-1" 
                       href="ChangePrescriptionStatus?id=<%= pid%>&status=Done" 
                       style="font-size: 12px;">
                       Mark as Done
                    </a> -->
        </div>
        </div>
        <div  class="col-sm m-2">
        <div>
            <!-- Search Form -->
            <form action="CartForUser.jsp" method="post">
                <div class="form-row">
                    <div class="col-10">
                        <input type="hidden" name="uemail" value="<%= uemail %>" />
                        <input type="hidden" name="id" value="<%= pid %>" />
                        <input class="form-control" type="text" name="name" maxlength="100" placeholder="Medicine/Product Name" required />
                    </div>
                    <div class="col-2">
                        <button type="submit" class="btn btn-success">Search</button>
                    </div>
                </div>
            </form>

            <!-- Display Items -->
            <%
                String name = request.getParameter("name");
                if (name != null && !name.trim().isEmpty()) {
                    db = new DAO();
                    ArrayList<HashMap> items = db.getItemsLike(name);
                    db.closeDBConnection();
                    for (HashMap item : items) {
            %>
            <div class="row bg-light p-4 my-2">
                <div class="col-3">
                    <img height="100px" src="GetImage?name=<%= item.get("name") %>" alt="Product Image">
                    
                </div>
                <div class="col-9">
                    <p>Name: <b><%= item.get("name") %></b> | Company: <b><%= item.get("cname") %></b> | Salt: <b><%= item.get("salt") %></b></p>
                    <p>Price: <b><%= item.get("price") %></b></p>
                    <%
                        int q = (int) item.get("qty");
                        if (q > 0) {
                    %>
                    <form action="AddToCartByAdmin" method="post">
                        <input type="hidden" name="name" value="<%= item.get("name") %>" />
                        <input type="hidden" name="uemail" value="<%= uemail %>" />
                        <input type="hidden" name="id" value="<%= pid %>" />
                        <button class="btn btn-sm btn-warning">Add to Cart</button>
                    </form>
                    <%
                        } else {
                    %>
                    <label class="bg-danger text-white p-2">Currently Not Available</label>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>

        <!-- Cart Section -->
        <div class="bg-light m-2">
            <h6 class="text-center p-2">Cart for <big><%= uemail %></big></h6>
            <hr />
            <%
                db = new DAO();
                HashMap<Integer, String> i = db.getCartItemsByEmail(uemail);
                double total = 0;
                if (i.isEmpty()) {
            %>
                <p class="p-2 bg-danger text-center">Cart is Empty</p>
            <%
                } else {
                    Set set = i.keySet();
                    Iterator iterator = set.iterator();
                    while (iterator.hasNext()) {
                        int id = (int) iterator.next();
                        String item_name = i.get(id);
            %>
            <p class="p-2">
                <img height="50px" src="GetImage?name=<%= item_name %>" alt="Product Image">
                <b><%= item_name %></b>
                <%
                    HashMap item = db.getItemByName(item_name);
                    int qty = (int) item.get("qty");
                    double price = (double) item.get("price");
                    if (qty <= 0) {
                %>
                <label class="bg-warning p-2">Item Out of Stock</label>
                <%
                    }
                    total += price;
                %>
                Price: <b><%= price %></b>
                <a class="btn btn-danger btn-sm" href='RemoveFromCartByAdmin?id=<%= id %>'>Remove</a>
            </p>
            <hr />
            <%
                    }
                }
                db.closeDBConnection();
            %>
        </div>
        </div>
    </div>
</header>

<footer class="container m-5">
    <div class="row">
        <div class="col-sm m-2 text-left">
            <img src="resources/medisol.png" height="20px" alt="" /> <span class="text-danger"><b>Medi</b></span>Sol
            <p>Lorem ipsum dolor sit amet consectetur.</p>
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

<script>
    // Scroll to Top
    $("#btnTop").click(function () {
        $("html, body").animate({ scrollTop: 0 }, 1000);
    });
</script>
</body>
</html>
