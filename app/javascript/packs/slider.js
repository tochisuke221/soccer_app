


  
  // $('.slider').not('.slick-initialized').slick({
  //   adaptiveHeight: true,
  //   dots: true,
  //   infinite: false,
  //   lazyLoad: 'progressive',
  // });
  
  
    $(document).ready(function(){
      $('.slick-images').slick({
        dots: true,
        infinite: true,
        speed: 300,
        slidesToShow: 1,
        prevArrow: '<button class="slide-arrow prev-arrow"></button>',
        nextArrow: '<button class="slide-arrow next-arrow"></button>'
      });
    });


      