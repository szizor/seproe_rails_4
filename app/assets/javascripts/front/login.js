$(function() {

  $('form#sign_in_user').bind('ajax:success', function(e, data, status, xhr) {
    if(data.success || typeof data == "string") {
      window.location.reload();
    } else {
      $('form#sign_in_user .alert').empty().prepend(data.errors.join('<br />')).show();
    }
  });
  $('form#sign_in_user').bind('ajax:error', function(e, data, status, xhr) {
    $('form#sign_in_user .alert').empty().prepend(data.responseText).show();
    var $button = $('input[type=submit]', this);
    $button.removeAttr("disabled");
    $button.attr('value', "Login");
  });

  $('form#sign_up_user').bind('ajax:success', function(e, data, status, xhr) {
    if(data.success || typeof data == "string") {
      window.location.reload();
    } else {
      $('form#sign_up_user .alert').empty().prepend(data.errors.join('<br />')).show();
    }
  });
  $('form#sign_up_user').bind('ajax:error', function(e, data, status, xhr) {
    $('form#sign_up_user .alert').empty().prepend(data.responseText).show();
  });
  $('form#sign_in_user').bind('submit', function(e) {
    var $button = $('input[type=submit]', this);
    $button.attr('disabled', 'disabled');
    $button.attr('value', "Please Wait");
  });


});
