if(window.location.hash) {
  // Fragment exists
  var hash = decodeURIComponent(window.location.hash.substring(1)),
      selectOptions = $('#adopter_desired_listing_id option');

  for (var i = 0; i < selectOptions.length; i++) {
    if ( selectOptions[i].label === hash ) {
        selectOptions[i].selected = true
    }
  };
}