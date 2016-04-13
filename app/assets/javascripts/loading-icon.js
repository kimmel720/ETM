function fadeInIcon(){
  $(".loading-container").show();
  $(".loading-container").removeClass('animated fadeOut');
  $(".loading-container").addClass('animated fadeIn');
}


$( document ).ready(function() {

  // hide spinner
  $(".loading-container").addClass('animated fadeOut');
  $(".loading-container").delay(900).hide(0);
  $('a').on('click', fadeInIcon);
  $('form').on('submit', fadeInIcon);

});
// $(document).on("page:fetch", function(){
//   // $(".loading-container").show();
//   $(".loading-container").className += 'animated fadeIn';
// });

// $(document).on("page:receive", function(){
//   $(".loading-container").addClass('animated fadeOut');
  // $(".loading-container").hide();

// });
document.addEventListener('page:change', function() {
  $(".loading-container").removeClass('animated fadeIn');
  $(".loading-container").addClass('animated fadeOut');
});
document.addEventListener('page:fetch', fadeInIcon);
