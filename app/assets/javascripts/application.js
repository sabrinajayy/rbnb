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

  // datepicker and timepicker functions:
  init_datepick();

  // profile tabs:
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

  // address autocomplete:
  var flatAddress = document.getElementById('flat_address');

  if (flatAddress) {
    var autocomplete = new google.maps.places.Autocomplete(flatAddress, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    google.maps.event.addDomListener(flatAddress, 'keydown', function(e) {
      if (e.key === "Enter") {
         $('#searchlat').val() = lat;
          $('#searchlon').val() = lon;
           // document.getElementById('searchlat').get(0).value = lat;
          // document.getElementById('searchlon').get(0).value = lon;
        e.preventDefault(); // Do not submit the form on Enter.

      }
    });
  }


// end document ready function here
});
