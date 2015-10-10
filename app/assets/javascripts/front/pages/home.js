var state = "Guadalajara, Jalisco",
    mapOptions,
    map,
    geocoder,
    pubMarker,
    markers = [],
    infowindow = null,
    infobox,
    boxes,
    contentLoading = "Loading...",
    infoTemplate = document.getElementById("infobox"),
    markerIcons = {
      normal: {
        Libre: '/assets/front/map/free.png',
        EnProcesso: '/assets/front/map/pending.png',
        Adoptado: '/assets/front/map/adopted.png'
      },
      featured: {
        Libre: '/assets/front/map/free_featured.png',
        EnProcesso: '/assets/front/map/pending_featured.png',
        Adoptado: '/assets/front/map/adopted_featured.png'
      }
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
    

google.maps.visualRefresh = true;

function initialize() {
    var boxes = $('.map-options input:checkbox');

    geocoder = new google.maps.Geocoder();
    geocoder.geocode({
        'address': state
    }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
        }
    });
    mapOptions = {
        zoom: 12,
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
            style: google.maps.ZoomControlStyle.DEFAULT,
            position: google.maps.ControlPosition.LEFT_TOP
        }
    };

    geocoder = new google.maps.Geocoder();
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    infobox = new InfoBox({
        content: infoTemplate,
        disableAutoPan: false,
        maxWidth: 0,
        pixelOffset: new google.maps.Size(-165, 6),
        zIndex: null,
        boxStyle: {
            width: "330px"
        },
        closeBoxMargin: "5px 5px 2px 2px",
        infoBoxClearance: new google.maps.Size(1, 1),
        isHidden: false,
        pane: "floatPane",
        closeBoxURL: "http://www.google.com/intl/en_us/mapfiles/close.gif",
        enableEventPropagation: false
    });

    boxes.change(function(e) {
        if ($(e.target).is(':checked')) {
            showMarker(e.target, e.target.name);
        } else {
            hideMarker(e.target, e.target.name);
        }
    });

    google.maps.event.addListenerOnce(map, 'idle', function() {
        load_spaces(publicSpaces);
    });
}

function showMarker(obj, name) {
    for (var i = 0; i < markers.length; ++i) {

        if (name == 'preferido' && markers[i].is_featured == true) {
            markers[i].setVisible(true);
        }

        if (name == 'libre' && markers[i].type == "Libre") {
            markers[i].setVisible(true);
        }

        if (name == 'En Proceso' && markers[i].type == "En Proceso") {
            markers[i].setVisible(true);
        }

        if (name == 'adoptado' && markers[i].type == "Adoptado") {
            markers[i].setVisible(true);
        }

        // markers[i].setVisible(slideAmount >= markers[i].get('value'));
    }
}

function hideMarker(obj, name) {
    for (var i = 0; i < markers.length; ++i) {

        if (name == 'preferido' && markers[i].is_featured == true) {
            markers[i].setVisible(false);
        }

        if (name == 'libre' && markers[i].type == "Libre") {
            markers[i].setVisible(false);
        }

        if (name == 'adoptado' && markers[i].type == "Adoptado") {
            markers[i].setVisible(false);
        }

        if (name == 'En Proceso' && markers[i].type == "En Proceso") {
            markers[i].setVisible(false);
        }

        // markers[i].setVisible(slideAmount >= markers[i].get('value'));
    }
}

function load_spaces(results) {
    for (var i = 0; i < results.features.length; i++) {
        var space = results.features[i];
        var coords = space.geometry.coordinates;
        var latLng = new google.maps.LatLng(coords[0], coords[1]);
        var markerImg = null;
        var markerObj = null;
        var is_featured = space.properties.is_featured;
        var spaceType = space.properties.type;

        switch(is_featured) {
          case true:
            markerObj = markerIcons.featured;
            break;

          default:
            markerObj = markerIcons.normal;
            break;
        }

        if ( spaceType == 'Adoptado' ) {
          markerImg = markerObj.Adoptado;
        } else if ( spaceType == 'Libre' ) {
          markerImg = markerObj.Libre;
        } else {
          markerImg = markerObj.EnProcesso;
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
            html: infoTemplate
        });
        var styles = [[{
            url: "/assets/front/map/f1.png",
            height: 53,
            width: 53
          }, {
            url: "/assets/front/map/f2.png",
            height: 56,
            width: 56
          }, {
            url: "/assets/front/map/f3.png",
            height: 66,
            width: 66
          }]];

        markers.push(marker);

        google.maps.event.addListener(marker, 'click', function() {
            var pubArr = publicSpaces.features;
            for (var i = 0; i < pubArr.length; i++) {
                if (pubArr[i].properties.title === this.title) {
                    pubMarker = pubArr[i].properties
                }
            }
            var thisInfoContent = $(infoTemplate);

            thisInfoContent.find('img')
                .attr('src', this.cover_thumb)
                .attr('alt', this.title);

            thisInfoContent.find('.info-data__name')
                .attr('href', this.url)
                .attr('title', this.title)
                .text(this.title);

            thisInfoContent.find('.info-data__address_street')
                .text(this.street);
            thisInfoContent.find('.info-data__address_locality')
                .text(this.locality);
            thisInfoContent.find('.info-data__address_region')
                .text(this.region);
            thisInfoContent.find('.info-data__address_postal')
                .text(this.postal);

            thisInfoContent.find('meta[itemprop="latitude"]')
                .attr('content', this.getPosition().ob);
            thisInfoContent.find('meta[itemprop="longitude"]')
                .attr('content', this.getPosition().pb);

            thisInfoContent.find('.info-data__action .btn-primary')
                .attr('href', this.url);

            thisInfoContent.find('.info-data__action .btn-link')
                .attr('href', '/reportes/#'+this.title);

            if (this.company.length) {

                thisInfoContent.find('.info-adopter__adoptor')
                    .attr('href', this.company_url);

                thisInfoContent.find('.info-adoptor__adopter_company')
                    .text(this.company);

                thisInfoContent.find('.info-adopter__adopter_facebook')
                    .attr('href', this.company_facebook);
                thisInfoContent.find('.info-adopter__adopter_twitter')
                    .attr('href', this.company_twitter);

                thisInfoContent.find('.info-adopter__adopter_social').show();
                thisInfoContent.find('.info-adopter').show();

            } else {
                thisInfoContent.find('.info-adopter__adoptor')
                    .attr('href', '/adoptar/#'+this.title)
                    .attr('target', '_self');

                thisInfoContent.find('.info-adoptor__adopter_company')
                    .text('Adoptar');

                thisInfoContent.find('.info-adopter__adopter_social').hide();
            }

            infobox.open(map, this);
        });

    }
    
    var markerCluster = new MarkerClusterer(map, markers, {
          maxZoom: 13,
          gridSize: 30,
          styles: styles[0]
        });
}

google.maps.event.addDomListener(window, 'load', initialize);

(function($) {

    var $container = $('.content-listing'),
        $mapMaximizer = $('.map-maximizer .btn'),
        mapCanvas = $('.map-canvas');
    // initialize
    $container.masonry({
        columnWidth: 278,
        "gutter": 20,
        itemSelector: '.listing_item'
    });

    $mapMaximizer.on('click', function (e) {
      mapCanvas.toggleClass('minimized');

      if (mapCanvas.hasClass('minimized')) {
        $mapMaximizer.find('.helper-text').text('Abrir Mapa');
        $mapMaximizer.find('.fa').removeClass('fa-caret-up').addClass('fa-caret-down');
      } else {
        $mapMaximizer.find('.helper-text').text('Cerrar Mapa');
        $mapMaximizer.find('.fa').removeClass('fa-caret-down').addClass('fa-caret-up');
      }
      
    });

}(jQuery));