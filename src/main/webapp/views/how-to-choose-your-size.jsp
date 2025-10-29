<%-- 
    Document   : viewProducts
    Created on : Oct 9, 2025
    Author     : Dang Thanh Liem - CE190697
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/components/header/header.jsp"%>

<style>
    body {
        background: #f8f9fa;
        font-family: 'Poppins', sans-serif;
    }
    h2, h3 {
        color: #0d6efd;
        margin-top: 40px;
        margin-bottom: 20px;
        font-weight: 600;
        text-align: center;
    }
    table {
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
    }
    th {
        background-color: #0d6efd;
        color: white;
        text-align: center;
    }
    td {
        text-align: center;
        vertical-align: middle;
    }
    tr:hover {
        background-color: #e9f3ff;
    }
    form {
        background-color: white;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
    }
    .btn-primary, .btn-success {
        border-radius: 8px;
        padding: 10px 18px;
        font-weight: 500;
    }
    #result, #shoeResult {
        font-size: 1.1em;
        font-weight: 600;
        color: #198754;
        text-align: center;
    }
    .guide {
        text-align: center;
        margin-top: 20px;
    }
    .guide img {
        max-width: 300px;
        width: 100%;
        border-radius: 10px;
        border: 2px solid #dee2e6;
    }
    .guide p {
        font-size: 0.95em;
        color: #6c757d;
        margin-top: 10px;
    }
</style>

<div class="container w-75 py-5">
    <h2>Men's Clothing Size Chart</h2>
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Height (cm)</th>
                <th>Weight (kg)</th>
                <th>Size</th>
            </tr>
        </thead>
        <tbody>
            <tr><td>160-165</td><td>50-60</td><td>S</td></tr>
            <tr><td>165-170</td><td>60-70</td><td>M</td></tr>
            <tr><td>170-175</td><td>70-80</td><td>L</td></tr>
            <tr><td>175-180</td><td>80-90</td><td>XL</td></tr>
            <tr><td>180-185</td><td>90-100</td><td>XXL</td></tr>
        </tbody>
    </table>

    <h2>Women's Clothing Size Chart</h2>
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Height (cm)</th>
                <th>Weight (kg)</th>
                <th>Size</th>
            </tr>
        </thead>
        <tbody>
            <tr><td>150-155</td><td>40-50</td><td>S</td></tr>
            <tr><td>155-160</td><td>50-55</td><td>M</td></tr>
            <tr><td>160-165</td><td>55-60</td><td>L</td></tr>
            <tr><td>165-170</td><td>60-65</td><td>XL</td></tr>
        </tbody>
    </table>

    <form id="sizeForm" class="mt-4">
        <h3>Automatic Clothing Size Calculator</h3>
        <div class="mb-3">
            <label for="height" class="form-label">Height (cm)</label>
            <input type="number" id="height" name="height" class="form-control" placeholder="Enter your height" required>
        </div>
        <div class="mb-3">
            <label for="weight" class="form-label">Weight (kg)</label>
            <input type="number" id="weight" name="weight" class="form-control" placeholder="Enter your weight" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Calculate Size</button>
    </form>
    <div id="result" class="mt-3"></div>

    <hr class="my-5">

    <h2>Men's Shoe Size Chart</h2>
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Foot Length (cm)</th>
                <th>VN Size</th>
                <th>US Size</th>
                <th>EU Size</th>
            </tr>
        </thead>
        <tbody>
            <tr><td>24.0</td><td>38</td><td>6</td><td>39</td></tr>
            <tr><td>24.5</td><td>39</td><td>6.5</td><td>40</td></tr>
            <tr><td>25.0</td><td>40</td><td>7</td><td>41</td></tr>
            <tr><td>26.0</td><td>41</td><td>8</td><td>42</td></tr>
            <tr><td>27.0</td><td>42</td><td>9</td><td>43</td></tr>
            <tr><td>28.0</td><td>43</td><td>10</td><td>44</td></tr>
        </tbody>
    </table>

    <h2>Women's Shoe Size Chart</h2>
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Foot Length (cm)</th>
                <th>VN Size</th>
                <th>US Size</th>
                <th>EU Size</th>
            </tr>
        </thead>
        <tbody>
            <tr><td>22.0</td><td>35</td><td>5</td><td>36</td></tr>
            <tr><td>22.5</td><td>36</td><td>5.5</td><td>36.5</td></tr>
            <tr><td>23.0</td><td>37</td><td>6</td><td>37.5</td></tr>
            <tr><td>23.5</td><td>38</td><td>6.5</td><td>38</td></tr>
            <tr><td>24.0</td><td>39</td><td>7</td><td>39</td></tr>
        </tbody>
    </table>

    <form id="shoeForm" class="mt-4">
        <h3>Automatic Shoe Size Calculator</h3>
        <div class="mb-3">
            <label for="footLength" class="form-label">Foot Length (cm)</label>
            <input type="number" id="footLength" name="footLength" class="form-control" step="0.1" placeholder="Enter your foot length" required>
        </div>
        <button type="submit" class="btn btn-success w-100">Calculate Shoe Size</button>
    </form>
    <div id="shoeResult" class="mt-3"></div>

    <div class="guide">
        <img src="${pageContext.request.contextPath}/assets/img/FootLength.jpg" alt="Foot measurement guide">
        <p><strong>How to measure your foot length:</strong><br>
        Place your foot on a sheet of paper, mark the tip of your longest toe and your heel, then measure the distance between them.</p>
    </div>
</div>

<script>
    // Clothing Size
    function calculateSize(height, weight) {
        if (height < 165 && weight < 55) return 'S';
        if (height < 175 && weight < 70) return 'M';
        if (height < 185 && weight < 85) return 'L';
        if (height < 195 && weight < 100) return 'XL';
        return 'XXL';
    }

    document.getElementById('sizeForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const h = parseInt(document.getElementById('height').value, 10);
        const w = parseInt(document.getElementById('weight').value, 10);
        const size = calculateSize(h, w);
        document.getElementById('result').textContent = 'Your estimated clothing size: ' + size;
    });

    // Shoe Size
    function calculateShoeSize(length) {
        if (length < 22.5) return '35 (US 5, EU 36)';
        if (length < 23.0) return '36 (US 5.5, EU 36.5)';
        if (length < 23.5) return '37 (US 6, EU 37.5)';
        if (length < 24.0) return '38 (US 6.5, EU 38)';
        if (length < 25.0) return '39 (US 7, EU 39)';
        if (length < 26.0) return '40 (US 7.5, EU 40)';
        if (length < 27.0) return '41 (US 8, EU 41)';
        if (length < 28.0) return '42 (US 9, EU 42)';
        return '43+ (US 10+, EU 43+)';
    }

    document.getElementById('shoeForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const length = parseFloat(document.getElementById('footLength').value);
        const shoeSize = calculateShoeSize(length);
        document.getElementById('shoeResult').textContent = 'Your estimated shoe size: ' + shoeSize;
    });
</script>

<%@include file="/components/footer/footer.jsp"%>
