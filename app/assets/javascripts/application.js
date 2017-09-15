//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require bootstrap-datepicker
//= require datepicker
//= require bootstrap-timepicker
//= require jquery.timepicker.js
//= require google_maps_autocomplete.js
//= require jquery.validate
//= require_tree .

$(function(){
  init_datepick();

  $(".tab").on("click", function(e){
    // Change active tab
    $('.tab').removeClass("active");
    $(this).addClass("active");
    // Hide all tab-content (use class="hidden")
    $('.tab-content').addClass("hidden");
    // Show target tab-content (use class="hidden")
    var tabToShow = $(this).data("target");
    // var tabToShow = $(this).attr("data-target");
    $(tabToShow).removeClass("hidden");
  });

});



$(document).ready(function(){
  $('#req-button').on('click', function(event){
    if ($('#consumer_name').val().length < 2) {
      event.preventDefault();
      $('#consumer_name').addClass('warning')
    }
  });

});
