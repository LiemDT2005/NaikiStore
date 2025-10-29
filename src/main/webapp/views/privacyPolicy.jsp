<%-- 
    Document   : privacyPolicy
    Created on : 18 Jul 2025, 16:34:30
    Author     : Do Ho Gia Huy - CE191293
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/header.jsp" %>


<div class="container my-5">
    <h2 class="text-center mb-4 fw-bold">🔒 Privacy Policy</h2>

    <div class="accordion" id="privacyPolicyAccordion">

        <!-- 1. Information Collection -->
        <div class="accordion-item">
            <h2 class="accordion-header" id="headingOne">
                <button class="accordion-button collapsed fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                    📥 1. Information Collection
                </button>
            </h2>
            <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#privacyPolicyAccordion">
                <div class="accordion-body">
                    - We collect customer data including name, email, phone number, and shipping address.<br>
                    - Additional data may be gathered during promotions or surveys.<br>
                    - All data collection is conducted with user consent.
                </div>
            </div>
        </div>

        <!-- 2. Use of Information -->
        <div class="accordion-item mt-3">
            <h2 class="accordion-header" id="headingTwo">
                <button class="accordion-button collapsed fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                    🛠️ 2. Use of Information
                </button>
            </h2>
            <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#privacyPolicyAccordion">
                <div class="accordion-body">
                    - Information is used for order processing, customer support, and promotional communications.<br>
                    - Data may be used for service improvements and statistical analysis.<br>
                    - Users can unsubscribe from marketing emails anytime.
                </div>
            </div>
        </div>

        <!-- 3. Data Protection -->
        <div class="accordion-item mt-3">
            <h2 class="accordion-header" id="headingThree">
                <button class="accordion-button collapsed fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree">
                    🛡️ 3. Data Protection
                </button>
            </h2>
            <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#privacyPolicyAccordion">
                <div class="accordion-body">
                    - All personal data is stored securely and protected against unauthorized access.<br>
                    - We implement encryption and firewalls to safeguard customer information.<br>
                    - Payment data is processed via certified third-party platforms.
                </div>
            </div>
        </div>

        <!-- 4. Sharing of Information -->
        <div class="accordion-item mt-3">
            <h2 class="accordion-header" id="headingFour">
                <button class="accordion-button collapsed fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour">
                    🤝 4. Sharing of Information
                </button>
            </h2>
            <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#privacyPolicyAccordion">
                <div class="accordion-body">
                    - We do not sell or trade personal information.<br>
                    - Data may be shared with logistics or service providers only to fulfill customer orders.<br>
                    - Legal disclosures are made only when required by law.
                </div>
            </div>
        </div>

        <!-- 5. User Rights -->
        <div class="accordion-item mt-3">
            <h2 class="accordion-header" id="headingFive">
                <button class="accordion-button collapsed fw-semibold" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive">
                    📝 5. User Rights
                </button>
            </h2>
            <div id="collapseFive" class="accordion-collapse collapse" data-bs-parent="#privacyPolicyAccordion">
                <div class="accordion-body">
                    - Users have the right to access, edit, or delete their data.<br>
                    - Requests can be sent to <a href="mailto:support@naiki.vn">support@naiki.vn</a>.<br>
                    - We respond to requests within 7 working days.
                </div>
            </div>
        </div>

    </div>
</div>

<%@ include file="/WEB-INF/include/footer.jsp" %>
