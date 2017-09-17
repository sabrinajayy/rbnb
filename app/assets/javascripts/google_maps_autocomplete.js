function onPlaceChanged() {
  var place = this.getPlace();
  // console.log(place);
  var components = getAddressComponents(place);

// console.log(components);
  var flatAddress = document.getElementById('flat_address');
  flatAddress.blur();

  // flatAddress.value = components.address;
  flatAddress.value = place.formatted_address;
  // document.getElementById('flat_zip_code').value = components.zip_code;
  // document.getElementById('flat_city').value = components.city;

  if (components.country_code) {
    // var selector = '#flat_country option[value="' + components.country_code + '"]';
    // document.querySelector(selector).selected = true;
  }
}

function getAddressComponents(place) {
  // If you want lat/lng, you can look at:
  // - place.geometry.location.lat()
  // - place.geometry.location.lng()

  if (window.console && typeof console.log === "function") {
    console.log(place);
  }

  var lat = place.geometry.location.lat();
  var lon = place.geometry.location.lng();
  console.log(lat);
  console.log(lon);
  $('#searchlat').val(lat);
  $('#searchlon').val(lon);

  var street_number = null;
  var route = null;
  var zip_code = null;
  var city = null;
  var country_code = null;
  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {
      var type = component.types[j];
      if (type === 'street_number') {
        street_number = component.long_name;
      } else if (type === 'route') {
        route = component.long_name;
      } else if (type === 'postal_code') {
        zip_code = component.long_name;
      } else if (type === 'locality') {
        city = component.long_name;
      } else if (type === 'postal_town' && city === null) {
        city = component.long_name;
      } else if (type === 'country') {
        country_code = component.short_name;
      }
    }
  }

  return {
    address: street_number === null ? route : (street_number + ' ' + route),
    zip_code: zip_code,
    city: city,
    country_code: country_code
  };
}

