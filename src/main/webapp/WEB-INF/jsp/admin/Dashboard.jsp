<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="styles/manage.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            /* Khi include sidebar, phần main-content sẽ tự khớp */
            .main-content {
                margin-left: 250px; /* chừa khoảng cho sidebar */
                transition: margin-left 0.3s;
            }

            /* Chừa chỗ cho header */
            .dashboard-header {
                height: 80px;
                margin-bottom: 20px;
            }

            /* Vùng dashboard chính */
            .ttr-wrapper {
                background: #f8f9fa;
                padding: 20px 30px;
                min-height: 100vh;
            }

            /* Card thống kê */
            .widget-card {
                border-radius: 12px;
                box-shadow: 0 3px 6px rgba(0,0,0,0.1);
                padding: 20px;
                color: #fff;
                margin-bottom: 20px;
            }

            .widget-bg1 {
                background: linear-gradient(135deg, #007bff, #00c6ff);
            }
            .widget-bg2 {
                background: linear-gradient(135deg, #28a745, #6ddf6d);
            }
            .widget-bg3 {
                background: linear-gradient(135deg, #ffc107, #ffde7d);
                color: #212529;
            }
            .widget-bg4 {
                background: linear-gradient(135deg, #dc3545, #ff7f7f);
            }

            .wc-title {
                font-size: 1.1rem;
                font-weight: 600;
            }

            .wc-stats {
                font-size: 1.8rem;
                font-weight: bold;
            }

            .widget-box {
                background: #fff;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 3px 8px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/components/common/sidebar.jsp" />
        <div class="main-content" id="content-area">
            <main class="ttr-wrapper">
                <div class="container-fluid">

                    <!-- ===== CARD THỐNG KÊ ===== -->
                    <div class="row text-center">
                        <div class="col-md-6 col-lg-3">
                            <div class="widget-card widget-bg1">
                                <div class="wc-item">
                                    <h4 class="wc-title">Total Revenue</h4>
                                    <span class="wc-des">All Customs Value<br/>${currentMonth}</span>
                                    <span class="wc-stats"><fmt:formatNumber value="${totalProfit}" pattern="###,##0.00"/>₫</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="widget-card widget-bg2">
                                <div class="wc-item">
                                    <h4 class="wc-title">New Feedbacks</h4>
                                    <span class="wc-des">Customer Review<br/>${currentMonth}</span>
                                    <span class="wc-stats">${totalFeedbacksInMonth}</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="widget-card widget-bg3">
                                <div class="wc-item">
                                    <h4 class="wc-title">New Orders</h4>
                                    <span class="wc-des">Fresh Orders<br/>${currentMonth}</span>
                                    <span class="wc-stats">${totalOrdersInMonth}</span>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="widget-card widget-bg4">
                                <div class="wc-item">
                                    <h4 class="wc-title">Total Users</h4>
                                    <span class="wc-des">Accounts<br/>${currentMonth}</span>
                                    <span class="wc-stats">${totalCustomers}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ===== BIỂU ĐỒ ===== -->
                    <div class="row">
                        <div class="col-lg-8 mb-4">
                            <div class="widget-box">
                                <div class="wc-title d-flex align-items-center">
                                    <h4 class="me-3">Revenue ${yearSelect}</h4>
                                    <select class="form-select w-auto" id="yearSelect" onchange="changeYear(this)">
                                        <c:forEach items="${years}" var="o">
                                            <option value="${o}" ${yearSelect == o ? 'selected' : ''}>${o}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="widget-inner mt-3">
                                    <canvas id="lineChart" height="90"></canvas>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 mb-4">
                            <div class="widget-box">
                                <div class="wc-title">
                                    <h4>Number of Orders Sold ${yearSelect}</h4>
                                </div>
                                <div class="widget-inner mt-3">
                                    <canvas id="myPieChart" height="200"></canvas>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12 mb-4">
                            <div class="widget-box">
                                <div class="wc-title">
                                    <h4>Top 10 Staffs with Most Sales ${yearSelect}</h4>
                                </div>
                                <div class="widget-inner mt-3">
                                    <canvas id="myBarChart" height="100"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
                                        // ===== Line chart: Doanh thu theo tháng =====
                                        const lineCtx = document.getElementById('lineChart').getContext('2d');
                                        const revenueData = [
            <c:forEach var="r" items="${revenue}" varStatus="loop">
                ${r != null ? r : 0}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
                                        ];
                                        new Chart(lineCtx, {
                                            type: 'line',
                                            data: {
                                                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                                datasets: [{
                                                        label: 'Monthly Revenue (₫)',
                                                        data: revenueData,
                                                        borderColor: '#007bff',
                                                        backgroundColor: 'rgba(0,123,255,0.2)',
                                                        fill: true,
                                                        tension: 0.4
                                                    }]
                                            },
                                            options: {
                                                plugins: {legend: {display: true}},
                                                scales: {
                                                    y: {beginAtZero: true, title: {display: true, text: 'Revenue (₫)'}}
                                                }
                                            }
                                        });

                                        // ===== Pie chart: Số đơn hàng theo tháng =====
                                        const pieCtx = document.getElementById('myPieChart').getContext('2d');
                                        const ordersData = [
            <c:choose>
                <c:when test="${not empty numberOfOrdersList}">
                    <c:forEach var="n" items="${numberOfOrdersList}" varStatus="loop">
                        ${n != null ? n : 0}<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
                </c:otherwise>
            </c:choose>
                                        ];
                                        new Chart(pieCtx, {
                                            type: 'pie',
                                            data: {
                                                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                                                datasets: [{
                                                        data: ordersData,
                                                        backgroundColor: [
                                                            '#007bff', '#28a745', '#ffc107', '#dc3545', '#6610f2',
                                                            '#20c997', '#fd7e14', '#6c757d', '#17a2b8', '#343a40', '#e83e8c', '#198754'
                                                        ]
                                                    }]
                                            },
                                            options: {
                                                plugins: {
                                                    legend: {position: 'right'},
                                                    title: {display: true, text: 'Number of Orders per Month'}
                                                }
                                            }
                                        });

                                        const barCtx = document.getElementById('myBarChart').getContext('2d');

                                        // Lấy dữ liệu staff từ List<Map<String, Object>>
                                        var staffNames = [];
                                        var orderCounts = [];

            <c:forEach items="${topStaffs}" var="staff">
                                        staffNames.push("${staff['StaffID']} - ${staff['StaffName']}");
                                            orderCounts.push(${staff['OrderCount']});
            </c:forEach>;
                                            new Chart(barCtx, {
                                                type: 'bar',
                                                data: {
                                                    labels: staffNames,
                                                    datasets: [{
                                                            label: 'Orders per Staff',
                                                            data: orderCounts,
                                                    backgroundColor: [
                                                        "rgba(255, 99, 132, 0.5)",
                                                        "rgba(54, 162, 235, 0.5)",
                                                        "rgba(255, 206, 86, 0.5)",
                                                        "rgba(75, 192, 192, 0.5)",
                                                        "rgba(153, 102, 255, 0.5)",
                                                        "rgba(255, 159, 64, 0.5)",
                                                        "rgba(231, 76, 60, 0.5)",
                                                        "rgba(46, 204, 113, 0.5)",
                                                        "rgba(241, 196, 15, 0.5)",
                                                        "rgba(52, 152, 219, 0.5)",
                                                        "rgba(155, 89, 182, 0.5)",
                                                        "rgba(243, 156, 18, 0.5)"
                                                    ],
                                                    borderColor: [
                                                        "rgba(255, 99, 132, 0.5)",
                                                        "rgba(54, 162, 235, 0.5)",
                                                        "rgba(255, 206, 86, 0.5)",
                                                        "rgba(75, 192, 192, 0.5)",
                                                        "rgba(153, 102, 255, 0.5)",
                                                        "rgba(255, 159, 64, 0.5)",
                                                        "rgba(231, 76, 60, 0.5)",
                                                        "rgba(46, 204, 113, 0.5)",
                                                        "rgba(241, 196, 15, 0.5)",
                                                        "rgba(52, 152, 219, 0.5)",
                                                        "rgba(155, 89, 182, 0.5)",
                                                        "rgba(243, 156, 18, 0.5)"
                                                    ],
                                                    borderWidth: 1,
                                                    fill: true // 3: no fill
                                                        }]
                                                },
                                                options: {
                                                    plugins: {
                                                        legend: {display: false},
                                                        title: {
                                                            display: true,
                                                            text: 'Top 10 Staffs by Orders'
                                                        }
                                                    },
                                                    scales: {
                                                        y: {
                                                            beginAtZero: true,
                                                            title: {display: true, text: 'Orders'}
                                                        },
                                                        x: {
                                                            ticks: {autoSkip: false}
                                                        }
                                                    }
                                                }
                                            });
                                            // ===== Đổi năm =====
                                            function changeYear(select) {
                                                const selectedYear = select.value;
                                                window.location.href = 'dashboard?year=' + selectedYear;
                                            }
        </script>


    </body>
</html>
