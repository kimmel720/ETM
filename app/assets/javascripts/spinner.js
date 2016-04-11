$( document ).ready(function() {

  // hide spinner
  $(".loading-icon").hide();


});
$(document).on("page:fetch", function(){
  $(".loading-icon").show();
});

$(document).on("page:receive", function(){
  $(".loading-icon").hide(0);
});
