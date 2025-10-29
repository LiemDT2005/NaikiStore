<%-- 
    Document   : Footer
    Created on : Sep 21, 2025, 11:39:07 PM
    Author     : Apollous - CE190744
--%>
<!-- Footer -->
<footer class="bg-light text-dark pt-4 mt-5 border-top">
    <div class="container">
        <div class="row">

            <!-- Follow Us -->
            <div class="col-md-3 mb-3 d-flex align-items-center">
                <div class="d-flex flex-column">
                    <h6 class="fw-bold" style="font-size: 1.5rem;">Follow Us On</h6>
                    <div>
                        <a href="https://www.facebook.com/profile.php?id=61577826335654"><img src="${pageContext.request.contextPath}/assets/img/footerimg/facebook-icon.png" width="24"></a>
                        <a href="https://www.youtube.com/@naikivietnam"><img src="${pageContext.request.contextPath}/assets/img/footerimg/youtube-icon.png" width="24"></a>
                        <a href="https://www.instagram.com/naikivietnam"><img src="${pageContext.request.contextPath}/assets/img/footerimg/instagram-icon.png" width="24"></a>
                    </div>
                </div>
            </div>

            <!-- Footer Links -->
            <div class="col-md-9 mb-3">
                <div class="row">
                    <div class="col-md-3">
                        <h6>Customer Support</h6>
                        <ul class="list-unstyled">
                            <li><a href="${pageContext.request.contextPath}/FooterLink/contact.jsp" class="text-decoration-none text-dark">Contact</a></li>
                            <li><a href="${pageContext.request.contextPath}/FooterLink/Returns.jsp" class="text-decoration-none text-dark">Returns</a></li>
                            <li><a href="${pageContext.request.contextPath}/FooterLink/Payments.jsp" class="text-decoration-none text-dark">Payments</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h6>About Naiki</h6>
                        <ul class="list-unstyled">
                            <li><a href="${pageContext.request.contextPath}/FooterLink/AboutUs.jsp" class="text-decoration-none text-dark">What is Naiki?</a></li>
                            <li><a href="${pageContext.request.contextPath}/FooterLink/Sustainability.jsp" class="text-decoration-none text-dark">Sustainability</a></li>
                            <li><a href="${pageContext.request.contextPath}/FooterLink/Careers.jsp" class="text-decoration-none text-dark">Careers</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h6>Shopping at Naiki</h6>
                        <ul class="list-unstyled">
                            <li><a href="${pageContext.request.contextPath}/FooterLink/store-list.jsp" class="text-decoration-none text-dark">Store List</a></li>
                            <li><a href="${pageContext.request.contextPath}/FooterLink/click-collect.jsp" class="text-decoration-none text-dark">Click & Collect</a></li>
                            <li><a href="${pageContext.request.contextPath}/FooterLink/business-orders.jsp" class="text-decoration-none text-dark">Business Orders</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <h6>Legal</h6>
                        <ul class="list-unstyled">
                            <li><a href="${pageContext.request.contextPath}/home?view=purchase" class="text-decoration-none text-dark">Purchase Policy</a></li>
                            <li><a href="${pageContext.request.contextPath}/home?view=privacy" class="text-decoration-none text-dark">Privacy Policy</a></li>
                            <li><a href="${pageContext.request.contextPath}/home?view=productrecall" class="text-decoration-none text-dark">Product Recall</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <hr>

        <div class="row text-center small">
            <div class="col-md-10 mx-auto">
                &copy; 2025 NAIKI VIETNAM Co., Ltd. All rights reserved. | Head Office: Alpha Tower, Can Tho | Hotline: 1800 0000 | Email: naikivietnam@gmail.com
            </div>
        </div>
    </div>
</footer>

<!-- JS -->
<script src="${pageContext.request.contextPath}/scripts/validateForm.js"></script>
<script src="${pageContext.request.contextPath}/scripts/bootstrap.bundle.min.js"></script>
</body>
</html>
