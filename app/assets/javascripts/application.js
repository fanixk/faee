// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require orders
//= require twitter-bootstrap-hover-dropdown.min
//= require chosen-jquery
//= require chosen-scaffold
// require_self .

$(window).scroll (function() {
  // what is the y position of the scroll?
  var y = $(window).scrollTop();
  // whether that's below the start of article?
  if (y >= 400) {
    // if so, add the fixed class
    $('.fixed-category').show();
  } else  {
    // otherwise, remove it
    $('.fixed-category').hide();
  }
});

$(document).ready(function(){
  $(".search-button").click(function(){
    $(".search-form").fadeToggle('slow');
  });

  $(".product .btn-add").click(function(){
    $(this).prevAll('.spinner:first').fadeIn(500).delay(500).fadeOut(500);
  });

  $('.img-container img').tooltip({  html:true, delay:{ show: 266, hide: 333 }, placement:'right' })
});
