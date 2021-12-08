<!DOCTYPE html>
<%@ page import="Student_Services.User.Account" %>
<%@ page import="Student_Services.Listing.listing" %>
<%@ page import="java.util.List" %>
<%@ page import="Student_Services.Listing.listingController" %>
<jsp:include page="/sidebar/sidebar.jsp"></jsp:include>
<%Account acc =  (Account) session.getAttribute("account");
    List<listing> listings;
if (request.getParameter("sorted") != null) {
    listings = (List<listing>) session.getAttribute("sortedList");
}
else {
     listings = listingController.getAllListings();
}
%>

<html lang="en" dir="ltr">
<head>
    <title> Welcome Page </title>
    <meta charset="UTF-8">
    <!--<title> Responsive Sidebar Menu  | CodingLab </title>-->
    <link rel="stylesheet" href="welcome.css">
    <link rel="stylesheet" href="tester.css">
    <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<section class="home-section">
    <div class="text">Listings
        <% if (request.getParameter("sorted") != null) { %>
        | <%=request.getParameter("sorted")%>
        <% }%>
    </div>
    <form action="SortAction.jsp" method="post">
    <select name="sorting" id="sorting" onclick="this.form.submit()">
        <option value="Date: Oldest to Newest">Date: Oldest to Newest</option>
        <option value="Date: Newest to Oldest">Date: Newest to Oldest</option>
        <option value="Price: Low to High">Price: Low to High</option>
        <option value="Price: High to Low">Price: High to Low</option>
        <option value="Most Liked">Most Liked</option>
    </select>
    </form>
    <% for (listing post: listings) { %>
    <div class="container">
        <div class="product">
            <div class="product-card">
                <h2 class="name"> <%= post.getTitle()%></h2>
                <span class="price"> $<%= String.format("%.2f", post.getPrice())%></span>
                <a class="popup-btn">View Listing</a>
                <img src="/CSB_SJU_Student_Services_war_exploded/getImage/<%=post.getImageID()%>" class="product-img" alt="" style="object-fit: cover;height: 225px; width: 380px">
                <span class="date"><i class='bx bxs-calendar'></i> Posted on: <%= post.getPost_date()%></span>
            </div>
            <div class="popup-view">
                <div class="popup-card">
                    <a><i class='bx bx-x close-btn'></i></a>
                    <div class="product-img">
                        <img src="/CSB_SJU_Student_Services_war_exploded/getImage/<%=post.getImageID()%>" alt="" style="object-fit: cover;height: auto; width: 100%">
                    </div>
                    <div class="info">
                        <h2><%= post.getTitle()%><br><span>User: <%= post.getAuthorName() %><br><%=post.getCatName()%></span></h2>
                        <p><%= post.getDescription()%></p>
                        <span class="price"> $<%= String.format("%.2f",post.getPrice())%></span>
                        <a href="#"> <i class='bx bxs-heart'></i> </a>
                    </div>
                </div>
            </div>
        </div> <% } %>
    </div>
</section>
<script>
    var popupViews = document.querySelectorAll('.popup-view');
    var popupBtns = document.querySelectorAll('.popup-btn');
    var closeBtns = document.querySelectorAll('.close-btn');

    //javascript for quick view button
    var popup = function(popupClick){
        popupViews[popupClick].classList.add('active');
    }

    popupBtns.forEach((popupBtn, i) => {
        popupBtn.addEventListener("click", () => {
            popup(i);
        });
    });

    //javascript for close button
    closeBtns.forEach((closeBtn) => {
        closeBtn.addEventListener("click", () => {
            popupViews.forEach((popupView) => {
                popupView.classList.remove('active');
            });
        });
    });
</script>
</body>
</html>
