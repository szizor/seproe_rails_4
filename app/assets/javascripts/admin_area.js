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
//= require admin/bootstrap/bootstrap
//= require jquery-ui
//= require jquery_ujs
//= require admin/jquery.ba-resize.min
//= require admin/jquery_cookie.min
//= require admin/tinynav
//= require admin/lib/typeahead.js/typeahead.min
//= require admin/lib/typeahead.js/hogan-2.0.0
//= require admin/lib/jQuery-slimScroll/jquery.slimscroll.min
//= require admin/lib/bootstrap-switch/js/bootstrap-switch.min
//= require admin/lib/navgoco/jquery.navgoco.min
//= require admin/lib/select2/select2
//= require admin/lib/FooTable/dist/footable.min
//= require admin/lib/FooTable/dist/footable.filter.min
//= require admin/pages/ebro_responsive_table
//= require front/plugins/moment.min
//= require front/vendor/d3.v3
//= require front/vendor/nv.d3.min
//= require admin/ebro_common.js

jQuery(function() {
    return $('#listing_adopter_name').autocomplete({
        source: $('#listing_adopter_name').data('autocomplete-source')
    });
});
jQuery(function() {
    return $('#adopter_user_id').autocomplete({
        source: $('#adopter_user_id').data('autocomplete-source')
    });
});