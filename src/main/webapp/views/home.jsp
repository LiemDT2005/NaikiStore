<%-- 
    Document   : home
    Created on : Oct 8, 2025, 9:35:29 PM
    Author     : Dang Thanh Liem - CE190697
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/components/header/header.jsp" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="vi_VN" />
<style>
    /* Overlay when hover */
    .overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0,0,0,0.45);
        opacity: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
        transition: opacity 0.4s ease;
    }

    .product-card:hover .overlay {
        opacity: 1;
    }

    .product-card:hover .product-img {
        transform: scale(1.1);
    }

    .product-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }

    /* Buttons inside overlay */
    .overlay .btn {
        font-size: 0.85rem;
        border-radius: 20px;
        transition: all 0.3s ease;
    }

    .overlay .btn:hover {
        transform: translateY(-2px);
    }
</style>

<!-- Promotion -->
<div class="slideshow-container">
    <div class="slides-track">
        <div class="mySlides active">
            <a href="#">
                <img src="${pageContext.request.contextPath}/assets/home-slide/slide1.png" alt="Slide 1">
            </a>
        </div>
        <div class="mySlides">
            <a href="#">
                <img src="${pageContext.request.contextPath}/assets/home-slide/slide2.png" alt="Slide 2">
            </a>
        </div>
        <div class="mySlides">
            <a href="#">
                <img src="${pageContext.request.contextPath}/assets/home-slide/slide3.png" alt="Slide 3">
            </a>
        </div>
    </div>

    <!-- Nút chuyển trái/phải bằng icon -->
    <span class="custom-arrow left" onclick="plusSlides(-1)">
        <i class="bi bi-arrow-left"></i>
    </span>

    <!-- Nút chuyển phải -->
    <span class="custom-arrow right" onclick="plusSlides(1)">
        <i class="bi bi-arrow-right"></i>
    </span>

    <!-- Dots chuyển slide -->
    <div class="dots">
        <span class="dot active" onclick="currentSlide(0)"></span>
        <span class="dot" onclick="currentSlide(1)"></span>
        <span class="dot" onclick="currentSlide(2)"></span>
    </div>
</div>

<script src="assets/js/slide-script.js"></script>


<!-- NEW ARRIVAL / SẢN PHẨM MỚI -->
<div class="container my-5">
    <div class="position-relative text-center" style="max-height: 400px;">
        <img src="${pageContext.request.contextPath}/assets/img/warehouse-bg.jpg"
             alt="New Arrival Banner"
             class="img-fluid w-100 rounded"
             style="max-height: 400px; object-fit: cover;">

        <div class="d-flex justify-content-center align-items-center position-absolute top-0 start-0 w-100 h-100 text-white bg-dark bg-opacity-50 rounded">
            <div>
                <h2 class="fw-bold">NEW ARRIVALS</h2>
                <p class="lead">Discover the latest products from <strong>Naiki</strong></p>
                <a href="viewProducts?keyword=naiki" class="btn btn-warning fw-bold mt-2">Visit now</a>
            </div>
        </div>
    </div>
</div>   

<!-- BEST SELLER -->        
<jsp:include page="/views/bestseller.jsp" />

<!-- TRENDING SPORT -->
<div class="container my-5">
    <h4><strong>TRENDING SPORT</strong></h4>
    <div id="trendingSportCarousel" class="carousel slide" data-bs-ride="false">
        <div class="carousel-inner">
            <!-- Slide 1 -->
            <div class="carousel-item active">
                <div class="d-flex justify-content-center" style="gap: 60px;">
                    <div class="text-center">
                        <a href="viewProducts?keyword=gym">
                            <img src="${pageContext.request.contextPath}/assets/img/sport_gym.jpg" alt="Gym & Yoga" class="img-fluid rounded-2" style="width: 200px; height: 200px;">
                        </a>
                        <br><small>Gym & Yoga</small>
                    </div>
                    <div class="text-center">
                        <a href="viewProducts?keyword=run">
                            <img src="${pageContext.request.contextPath}/assets/img/sport_running.png" alt="Running" class="img-fluid rounded-3" style="width: 200px; height: 200px;">
                        </a>
                        <br><small>Running</small>
                    </div>
                    <div class="text-center">
                        <a href="viewProducts?keyword=badminton">
                            <img src="${pageContext.request.contextPath}/assets/img/sport_badminton.png" alt="Badminton" class="img-fluid rounded-3" style="width: 200px; height: 200px;">
                        </a>
                        <br><small>Badminton</small>
                    </div>
                    <div class="text-center">
                        <a href="viewProducts?keyword=swimming">
                            <img src="${pageContext.request.contextPath}/assets/img/sport_swimming.png" alt="Swimming" class="img-fluid rounded-3" style="width: 200px; height: 200px;">
                        </a>
                        <br><small>Swimming</small>
                    </div>
                </div>
            </div>

            <!-- Slide 2 -->
            <div class="carousel-item">
                <div class="d-flex justify-content-center" style="gap: 60px;">
                    <div class="text-center">
                        <a href="viewProducts?keyword=cycling">
                            <img src="${pageContext.request.contextPath}/assets/img/sport_cycling.jpg" alt="Cycling" class="img-fluid rounded-3" style="width: 200px; height: 200px;">
                        </a>
                        <br><small>Cycling</small>
                    </div>
                    <div class="text-center">
                        <a href="viewProducts?keyword=football">
                            <img src="${pageContext.request.contextPath}/assets/img/sport_football.jpg" alt="Football" class="img-fluid rounded-3" style="width: 200px; height: 200px;">
                        </a>
                        <br><small>Football</small>
                    </div>
                    <div class="text-center">
                        <a href="viewProducts?keyword=tennis">
                            <img src="${pageContext.request.contextPath}/assets/img/sport_tennis.jpg" alt="Tennis" class="img-fluid rounded-3" style="width: 200px; height: 200px;">
                        </a>
                        <br><small>Tennis</small>
                    </div>
                    <div class="text-center">
                        <a href="viewProducts?keyword=volleyball">
                            <img src="${pageContext.request.contextPath}/assets/img/sport_volleyball.jpg" alt="Volleyball" class="img-fluid rounded-3" style="width: 200px; height: 200px;">
                        </a>
                        <br><small>Volleyball</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Arrows -->
        <span class="custom-arrow left" data-bs-target="#trendingSportCarousel" data-bs-slide="prev">
            <i class="bi bi-arrow-left"></i>
        </span>
        <span class="custom-arrow right" data-bs-target="#trendingSportCarousel" data-bs-slide="next">
            <i class="bi bi-arrow-right"></i>
        </span>
    </div>
</div>

<script>
// Remove Facebook's #_=_ hash if it exists
if (window.location.hash && window.location.hash === '#_=_') {
    if (history.replaceState) {
        history.replaceState(null, null, window.location.href.split('#')[0]);
    } else {
        window.location.hash = '';
    }
}
</script>
<%@include file="/components/message/toastMessage.jsp" %>
<%@include file="/components/footer/footer.jsp" %>