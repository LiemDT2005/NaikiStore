let slideIndex = 0;
let timer = null;

const slidesTrack = document.querySelector('.slides-track');
const slides = document.getElementsByClassName("mySlides");
const dots = document.getElementsByClassName("dot");
const totalSlides = slides.length;

function showSlide(n) {
    // Đảm bảo chỉ số nằm trong khoảng hợp lệ
    if (n < 0)
        slideIndex = totalSlides - 1;
    else if (n >= totalSlides)
        slideIndex = 0;
    else
        slideIndex = n;

    // Di chuyển slides-track bằng transform
    slidesTrack.style.transform = `translateX(-${slideIndex * 100}%)`;

    // Cập nhật dots
    for (let i = 0; i < dots.length; i++) {
        dots[i].classList.remove('active');
    }
    dots[slideIndex].classList.add('active');
}

function nextSlide() {
    showSlide(slideIndex + 1);
}

function plusSlides(n) {
    showSlide(slideIndex + n);
    resetTimer();
}

function currentSlide(n) {
    showSlide(n);
    resetTimer();
}

function resetTimer() {
    clearInterval(timer);
    timer = setInterval(nextSlide, 3000);
}

// Khởi động slideshow tự động
timer = setInterval(nextSlide, 3000);

// Đảm bảo slide đầu tiên được hiển thị đúng vị trí khi tải trang
showSlide(slideIndex);
