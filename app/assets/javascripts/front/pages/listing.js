var myLatlng = new google.maps.LatLng(publicSpaces.features[0].geometry.coordinates[0],publicSpaces.features[0].geometry.coordinates[1]),
    mapOptions,
    markers = [],
    markerIcons = {
        Libre: "<%= asset_url('front/map/marker_free.png') %>",
        featured: "<%= asset_url('front/map/marker_featured.png') %>",
        Adoptado: "<%= asset_url('front/map/marker_adopted.png') %>"
    },
    mapStyle = [{
        "featureType": "water",
        "stylers": [{
            "color": "#46bcec"
        }, {
            "visibility": "on"
        }]
    }, {
        "featureType": "landscape",
        "stylers": [{
            "color": "#f2f2f2"
        }]
    }, {
        "featureType": "road",
        "stylers": [{
            "saturation": -100
        }, {
            "lightness": 45
        }]
    }, {
        "featureType": "road.highway",
        "stylers": [{
            "visibility": "simplified"
        }]
    }, {
        "featureType": "road.arterial",
        "elementType": "labels.icon",
        "stylers": [{
            "visibility": "off"
        }]
    }, {
        "featureType": "administrative",
        "elementType": "labels.text.fill",
        "stylers": [{
            "color": "#444444"
        }]
    }, {
        "featureType": "transit",
        "stylers": [{
            "visibility": "off"
        }]
    }, {
        "featureType": "poi",
        "stylers": [{
            "visibility": "off"
        }]
    }];

function initialize() {
  mapOptions = {
    zoom: 17,
    center: myLatlng,
    mapTypeControl: true,
    panControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: true,
    mapTypeControlOptions: {
        style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
    },
    styles: mapStyle,
    zoomControl: true,
    zoomControlOptions: {
        style: google.maps.ZoomControlStyle.DEFAULT
    }
  };

  map = new google.maps.Map(document.getElementById('venuMap'), mapOptions);

  google.maps.event.addListenerOnce(map, 'idle', function() {
      load_spaces(publicSpaces);
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

function load_spaces(results) {
    for (var i = 0; i < results.features.length; i++) {
        var space = results.features[i];
        var coords = space.geometry.coordinates;
        var latLng = new google.maps.LatLng(coords[0], coords[1]);
        var markerImg;

        if ( space.properties.type == 'Adoptado' ) {
          markerImg = markerIcons.Adoptado;
        } else {
          markerImg = markerIcons.Libre;
        }

        if ( space.properties.is_featured == true ) {
          markerImg = markerIcons.featured;
        }

        var marker = new google.maps.Marker({
            position: latLng,
            map: map,
            icon: markerImg,
            title: space.properties.title,
            tag: space.properties.tag,
            type: space.properties.type,
            is_featured: space.properties.is_featured,
            time: space.properties.time,
            updated: space.properties.updated,
            cover: space.properties.cover,
            cover_thumb: space.properties.cover_thumb,
            street: space.properties.street,
            locality: space.properties.locality,
            region: space.properties.region,
            postal: space.properties.postal,
            url: space.properties.url,
            company: space.properties.company,
            company_url: space.properties.company_url,
            company_facebook: space.properties.company_facebook,
            company_twitter: space.properties.company_twitter,
            animation: google.maps.Animation.DROP,
        });

        markers.push(marker);

    }
}


var urlArray = [];

$('.venu__comments-count').each(function() {
    var url = $(this).attr('data-disqus-url');
    urlArray.push('link:' + url);
});

$.ajax({
    type: 'GET',
    url: "https://disqus.com/api/3.0/threads/set.jsonp",
    data: {
        api_key: disqusPublicKey,
        forum: disqus_shortname,
        thread: urlArray
    },
    cache: false,
    dataType: 'jsonp',
    success: function(result) {

        for (var i in result.response) {
            var countText;
            var count = result.response[i].posts;
            var renderCount;

            if (count == 0) {
                countText = "Deja un comentario!";
                renderCount = countText;
            } else if (count == 1) {
                countText = " Comentario";
                renderCount = count + countText;
            } else {
                countText = " Comentarios";
                renderCount = count + countText;
            }

            $('.venu__comments-count').text(renderCount);

        }
    }
});

$('#blueimp-gallery').data('useBootstrapModal', false);

$('#videoModal').on('show.bs.modal', function (e) {
  // do something...
  var videoID = e.relatedTarget.dataset.id,
      videoURL = e.relatedTarget.dataset.url,
      videoTitle = e.relatedTarget.dataset.title,
      targetModal = $(e.relatedTarget.dataset.target);

      targetModal.find('.modal-title').text(videoTitle);
      targetModal.find('#vidFrame').attr('src', '//www.youtube.com/embed/'+videoID+'?autoplay=1&rel=0&controls=0');

}).on('hide.bs.modal', function (e) {
  var targetModal = $(e.target);
  targetModal.find('.modal-title').text('');
  targetModal.find('#vidFrame').attr('src', 'about:blank');
});

$('.js-event-title').bind('click', function(e) {
    var EleTarget = $(e.target).attr('href');
    $(this).closest('.info').find(EleTarget).toggleClass('show hide');
    return false;
});

// var amount = 0;

// if ($('.money_listing_item').length) {

//     $('.money_listing_item .amount').each(function(index, item) {
//         amount = amount + parseInt(item.innerText, 0);
//     });
//     $('.amount_total').append(amount + ' MXN')
// }

function getQueryVariable(variable)
{
       var query = window.location.search.substring(1);
       var vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
}

if ( getQueryVariable('event') ) {
  var evendID = getQueryVariable('event'),
      eventEle = $('a[data-eid='+evendID+']');
  $('.venu__tabs .nav-tabs a:last').tab('show');
  $('html,body').animate({
    scrollTop: eventEle.offset().top
  }, 1000);
  eventEle.trigger('click');

}

moment.lang('fr', {
    months : ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
    monthsShort : ["Jan", "febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "noviembre "," Diciembre "],
    weekdays : ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"],
    weekdaysShort : "dim._lun._mar._mer._jeu._ven._sam.".split("_"),
    weekdaysMin : "Di_Lu_Ma_Me_Je_Ve_Sa".split("_"),
    longDateFormat : {
        LT : "HH:mm",
        L : "DD/MM/YYYY",
        LL : "D MMMM YYYY",
        LLL : "D MMMM YYYY LT",
        LLLL : "dddd D MMMM YYYY LT"
    },
    calendar : {
        sameDay: "[Aujourd'hui à] LT",
        nextDay: '[Demain à] LT',
        nextWeek: 'dddd [à] LT',
        lastDay: '[Hier à] LT',
        lastWeek: 'dddd [dernier à] LT',
        sameElse: 'L'
    },
    relativeTime : {
        future : "dans %s",
        past : "il y a %s",
        s : "quelques secondes",
        m : "une minute",
        mm : "%d minutes",
        h : "une heure",
        hh : "%d heures",
        d : "un jour",
        dd : "%d jours",
        M : "un mois",
        MM : "%d mois",
        y : "une année",
        yy : "%d années"
    },
    ordinal : function (number) {
        return number + (number === 1 ? 'er' : 'ème');
    },
    week : {
        dow : 1, // Monday is the first day of the week.
        doy : 4  // The week that contains Jan 4th is the first week of the year.
    }
});