
function sidebarSizing ( ) {
	var winHeight 		= $(window).height();
	var sidebarMargin 	= $('.sidebar-logo').outerHeight() + $('.sidebar-menu').outerHeight() + $('.sidebar-search').outerHeight();

	$('.sidebar-list').css('height', winHeight - sidebarMargin);
}

$(function() {
	$('.public-space__header > a').on({
		click: function (e) {
			e.preventDefault();
			var parentEle = $( e.target.dataset.parent );
			var targetEle = $( e.target.getAttribute("href") );
			targetEle.slideToggle();
            sidebarSizing();
        }
    });
    $('.sidebar-dropdown > a').on({
        click: function (e) {
            e.preventDefault();
            $('.sidebar-list').css('height', 'auto');
            $('.sidebar').slideToggle();
            sidebarSizing();
        }
    });
    $('#searchInput').fastLiveFilter('.public-space__list');

    $('.modal').on('show.bs.modal', function (e) {
        $('html').addClass('modal-open');
    });
    $('.modal').on('shown.bs.modal', function (e) {
        var targetModal = $(e.target);
        $('.modal').not(targetModal).modal('hide');
    });
});

sidebarSizing();
$( window ).resize(function() {
  sidebarSizing();
});