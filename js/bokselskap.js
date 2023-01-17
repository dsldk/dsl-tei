
// Custom sorting plugin
(function($) {

  $.fn.sorted = function(customOptions) {

    var options = {
      reversed: false,
      by: function(a) { return a.text(); }
    };

    $.extend(options, customOptions);
    $data = $(this);

	var sortert_array = new Array();
	$.each($data, function(index, value) {
	//alert(index + ': ' + value.innerHTML);

	//alert($(this).children("span[data-type=periode]").text());

	//alert("tittel: " + $(this).find("span.tittel").text());


	//alert("forfatter: " + $(this).find("span.forfatter").text());
	//alert("utgiver: " + $(this).find("span.utgiver_navn").text());

	// legg hele objektet og tittel i en ny array

	var pushed = sortert_array.push([this, $(this).find("span.forfatter").text()]);
	//alert(sortert_array[0][1]);
	//alert(pushed);	// varen sier antall etter push

	// legg i rekkefølge i ny array
	sortert_array.sort((function(index){
		return function(a, b){
        return (a[index] === b[index] ? 0 : (a[index] < b[index] ? -1 : 1));
    };
	})(1)); // 1 is the index to sort on
	//alert(sortert_array[0][1]);

	// erstatt gammel med ny array
	arr = sortert_array;


	});

	//alert($data[0].innerHTML);

   // arr = $data.get(); //alert(arr);

	//arr.sort(function(a,b) {return a - b})

	/*
    arr.sort(function(a, b) {
      var valA = options.by($(a));
      var valB = options.by($(b));
      if (options.reversed) {
        return (valA < valB) ? 1 : (valA > valB) ? -1 : 0;
      } else {
        return (valA < valB) ? -1 : (valA > valB) ? 1 : 0;
      }
    });*/
	//alert("sort");

    return $(arr);
  };
})(jQuery);



function parseDate(d){
	  var res = d.match(/\d\d\d\d-\d\d-\d\d/);
	  if(res){
		Date.format = "yyyy-mm-dd";
		var dt = new Date(res[0]);
	  }else
		var dt = new Date(d);
	  return dt.getTime();
}

function unique2(array) { // takes array of strings, returns array without duplicates
    return $.grep(array, function(el, index) {
        return index == $.inArray(el, array);
    });
}

function refreshOptionCounts() {

	setTimeout(function() {
		
		$('#filter .dropdown-menu ul').each(function() { 

			$attribute = $(this).parent().parent().prev('select').attr('name');
			//console.log('att:' + $attribute);
			$count = 0;
			$values = [];
			$attributes = [];

			$('#filter select[name="' + $attribute + '"] option').each(function(index){

				//console.log($(this).attr('value'));
				$values.push($(this).attr('value')); 
				//$attributes.push('data-' + $(this).parent().attr('name'));

			});
			//console.log($values);
			//console.log($attributes);

			// only refresh count and hide items in menu if this dropdown is not the only one selected (if only one dropdown is selected, we want the user to able to select another sjanger, for instance)
			if(!$(this).parent().parent().hasClass('selected_select') || $('#filter .selected_select').length > 1) {

				//console.log('processing counts, removing');
				//console.log('l' + $('#filter .selected_select').length);
				
				$(this).find('li a .count').remove();
				$(this).find('li a').each(function(index){

					// find number of books with each count
					$count = $('ul.books li.bok[data-' + $attribute + '="' + $values[index] + '"]').length;
					//console.log('ul.books li.bok[data-' + $attribute + '="' + $values[index] + '"]');

					// add count element

					//if($count == 0) { $(this).find('.text').css('opacity', '0.4'); } else { $(this).find('.text').css('opacity', '1');  }
					if($values[index] != "0" && $count == 0) { $(this).parent().hide(); } else { $(this).parent().show();  }
					if($values[index] != "0") { $(this).append('<span class="count">' + $count + '</span>'); }

				});

			}

		});

	}, 100);
}



function sort_books(type) {

  setTimeout(function() {
	var $divs = $("#books_container ul.books li.bok");

	if (type == "title") {
		
		var $sort = this;
        var $list = $("ul.books");
        var $listLi = $('li.bok',$list);

        $listLi.sort(function(a, b){

            var keyA = $(a).find(".book_title").text();
            var keyB = $(b).find(".book_title").text();
            
            if (keyA < keyB) { return -1; }
		    else { return 1; }
            
        });

        $("ul.books").html('');

        $.each($listLi, function(index, row){
        	//console.log($(row).find(".book_title").text());
            $list.append(row);
            //console.log(row);
        });
        
	}

	if (type == "utg_ar") {

		var $sort = this;
        var $list = $("ul.books");
        var $listLi = $('li.bok',$list);

        $listLi.sort(function(a, b){

            var keyA = parseInt($(a).attr("data-utg-ar"));
            //if(keyA == "" || keyA === undefined) { keyA = 0} else { keyA = parseInt(keyA); }
            //console.log(keyA);
            var keyB = parseInt($(b).attr("data-utg-ar"));
            //if(keyB == "" || keyB === undefined) { keyB = 0} else { keyA = parseInt(keyB); }
			//console.log(keyB);
            
            if (keyA < keyB) { return -1; }
		    else { return 1; }
            
        });

        $("ul.books").html('');

        $.each($listLi, function(index, row){
        	//console.log($(row).attr("data-utg-ar"));
            $list.append(row);
        });


        //$('.utg_ar').css("display", "block");

	}

	if (type == "newest") {

		var $sort = this;
        var $list = $("ul.books");
        var $listLi = $('li.bok',$list);

        $listLi.sort(function(a, b){

            var keyA = parseInt($(a).attr("data-number"));
            //if(keyA == "" || keyA === undefined) { keyA = 0} else { keyA = parseInt(keyA); }
            //console.log(keyA);
            var keyB = parseInt($(b).attr("data-number"));
            //if(keyB == "" || keyB === undefined) { keyB = 0} else { keyA = parseInt(keyB); }
			//console.log(keyB);
            
            if (keyA < keyB) { return -1; }
		    else { return 1; }
            
        });

        $("ul.books").html('');

        $.each($listLi, function(index, row){
//        	console.log($(row).attr("data-utg-ar"));
            $list.append(row);
            //console.log(row);
        });

        
	}
	
	$('ul.books li.bok.visible').hide();

    reset_book_numbers();
	
	}, 100);
}


function reset_book_numbers(){
	/* add number classes to visible books/letters so we can target them using css to prevent spacing issue */
	
	//$('.books li.bok.visible').hide();
	$('.books li.bok').removeClass('_1').removeClass('_2').removeClass('_3').removeClass('_4');						
	$('.books li.bok.visible').slice(0,12).show();

	// sett antall bøker funnet
	var antallBoker = $('.books li.bok.visible:not(.brev)').length;
	//alert(antallBoker);

	if(antallBoker == 0) { $('#antallBoker').html( 'Beklager, ingen bøker samsvarer med dine filtre.'); }
	else if(antallBoker == 1){
		$('#antallBoker').html( '<strong>' + antallBoker + '</strong> bok samsvarer med dine filtre:');
	}

	else {
		$('#antallBoker').html( '<strong>' + antallBoker + '</strong> bøker samsvarer med dine filtre:');
	}

	var antallBrev = $('.books li.bok.brev.visible').length;

	//alert(antallBoker);
	
	// sett antall brev funnet
	
	if(antallBrev == 0 && antallBoker == 0) { $('#antallBoker').html( 'Beklager, ingen bøker samsvarer med dine filtre.'); }
	else if (antallBrev > 0 && antallBoker == 0) {
		$('#antallBoker').html( '<strong>' + antallBrev + '</strong> brev samsvarer med dine filtre:');
	}
	

	number = 1;
	max_number = 5;
	//alert($(window).width());
	if ($(window).width() < 991) { max_number = 4; }

	$('.books li.bok.visible').each(function(){

		$(this).addClass('_' + number);
		number = number + 1;

		if(number == max_number) { number = 1; } 
});
}

// cookie functions http://www.quirksmode.org/js/cookies.html
            function createCookie(name, value, days) {
                if (days) {
                    var date = new Date();
                    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                    var expires = "; expires=" + date.toGMTString();
                }
                else var expires = "";
                document.cookie = name + "=" + value + expires + "; path=/";
            }

            function readCookie(name) {
                var nameEQ = name + "=";
                var ca = document.cookie.split(';');
                for (var i = 0; i < ca.length; i++) {
                    var c = ca[i];
                    while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
                }

                return null;
            }

$(document).ready(function() {

			// we start off with 12 loaded books, then show 12 more every time user reaches bottom of page




			$(window).scroll(function() {
			    if($(window).scrollTop() > $(document).height() - $(window).height() - 700) {
			           // ajax call get data from server and append to the div
			           //console.log('bottom');
			           $('li.bok.visible:hidden').slice(0,12).show();
			    }
			});

			$( window ).resize(function() {
				reset_book_numbers();
			});

			$('.show-all-excerpts').click(function() {

				$(this).parent().parent().find('*').show();
				$(this).hide();
				return false;

			});			

			$('input[type=radio][name="sort-books"]').on("change", function() {
			
		        if (this.value == 'newest') {
		            sort_books("newest");
		        }
		        else if (this.value == 'title') {
		         	sort_books("title");
		        }
		        else if (this.value == 'utg_ar') {
		         	sort_books("utg_ar");
		        }

		    });
			

			$('#toggle_toc').click(function() {

				if($('#innhold_liste').is(":hidden")) { $('#innhold_liste').show(); }
	
				else { $('#innhold_liste').hide(); }

				return false;

			});

				// bind dropdowns in the form
				var $filtersjanger = $('#filter select[name="sjanger"]');
				var $filterperiode = $('#filter select[name="periode"]');
				var $filterforfatter = $('#filter select[name="forfatter"]');
				var $filterserie = $('#filter select[name="serie"]');
				var $filterutgiver = $('#filter select[name="utgiver"]');


				// get the first collection
				var $applications = $('ul.books');

				// clone applications to get a second collection

				var $data = $applications.clone();

				$('.sort').change(
				function() {
					$($filtersjanger).trigger("change");
				});

				// attempt to call Quicksand on every form change

				$('#filter .select_selectpicker').change(
					function() {

						//refreshOptionCounts();
						//console.log("utgiver: " + $($filterutgiver).val() + " periode: " + $($filterperiode).val() + " sjanger: " + $($filtersjanger).val() + " forfatter: " + $($filterforfatter).val());
						$(this).addClass('animate');
						var $filteredData = $data.find('li' );

						// hvis sjanger er valgt

						if ($($filtersjanger).val() != '0'){


							// fjern de der sjanger ikke er verdien som er valgt

							var $sjanger_array = new Array();
							var $valgt = $($filtersjanger).val();


							$.each($filteredData, function(index, value) {

								// hvis sjanger i objektet er samme som valgt sjanger i menyen, sett inn i ny array
								
								var $sjanger = $(this).attr("data-sjanger");
								
								
								// sjekk om den valgte sjanger (som kan ha flere kommaseparerte sjangre) ("Memoarer, Romantikk") finnes i bokens sjanger attributt
								if ($sjanger.indexOf($valgt) >= 0) {

									$sjanger_array.push(this);

								}

								// erstatt gammel med ny array
								$filteredData = $sjanger_array;


							});

						}

						// hvis periode er valgt

						if ($($filterperiode).val() != '0'){

							// fjern de der sjanger ikke er verdien som er valgt

							var $periode_array = new Array();
							var $valgt = $($filterperiode).val();


							$.each($filteredData, function(index, value) {

								// hvis sjanger i objektet er samme som valgt sjanger i menyen, sett inn i ny array
								
								var $periode = $(this).attr("data-periode");
								
								// forfatter og valgt forfatter er den samme
								if($valgt == $periode) {

									$periode_array.push(this);

								}

								// erstatt gammel med ny array
								$filteredData = $periode_array;


							});

						}

						// hvis utgiver er valgt

						if ($($filterutgiver).val() != '0'){

							// fjern de der sjanger ikke er verdien som er valgt

							var $utgiver_array = new Array();
							var $valgt = $($filterutgiver).val();


							$.each($filteredData, function(index, value) {

								// hvis sjanger i objektet er samme som valgt sjanger i menyen, sett inn i ny array
								
								var $utgiver = $(this).attr("data-utgiver");
								
								// forfatter og valgt forfatter er den samme
								if($valgt == $utgiver) {

									$utgiver_array.push(this);

								}

								// erstatt gammel med ny array
								$filteredData = $utgiver_array;


							});

						}

						// hvis serie er valgt

						if ($($filterserie).val() != '0'){

							// fjern de der sjanger ikke er verdien som er valgt

							var $serie_array = new Array();
							var $valgt = $($filterserie).val();
							
							//console.log('valgt :' + $valgt);

							$.each($filteredData, function(index, value) {

								// hvis sjanger i objektet er samme som valgt sjanger i menyen, sett inn i ny array
								
								var $serie = $(this).attr("data-serie");
								// console.log($valgt + $serie);
								// forfatter og valgt forfatter er den samme
								if($valgt == $serie) {

									//console.log('same, adding!');
									$serie_array.push(this);

								}

								// erstatt gammel med ny array
								$filteredData = $serie_array;


							});

							//console.log($filteredData);

						}

						// hvis forfatter er valgt

						if ($($filterforfatter).val() != '0'){


							// fjern de der forfatter ikke er verdien som er valgt

							var $forfatter_array = new Array();
							var $valgt = $($filterforfatter).val();


							$.each($filteredData, function(index, value) {

								

								// hvis forfatter i objektet er samme som valgt forfatter i menyen, sett inn i ny array
								

								//var $forfatter = $(this).find("span.forfatter_etternavn").text();
								var $forfatter = $(this).attr("data-forfatter");
								
								console.log($forfatter);
								
								if ($forfatter !== undefined) {
								

									// sjekk om den valgte forfatter (som kan ha flere kommaseparerte forfattere) finnes
									if ($forfatter.indexOf($valgt) >= 0) {

										$forfatter_array.push(this);

									}
								
								}
								// erstatt gammel med ny array
								$filteredData = $forfatter_array;


							});


						}

						//console.log($filteredData);
						// sortering

						// style selected selects
						if ($($filtersjanger).val() != '0'){ $($filtersjanger).next().addClass('selected_select'); } else { $($filtersjanger).next().removeClass('selected_select'); }
						if ($($filterperiode).val() != '0'){ $($filterperiode).next().addClass('selected_select'); } else { $($filterperiode).next().removeClass('selected_select'); }
						if ($($filterforfatter).val() != '0'){ $($filterforfatter).next().addClass('selected_select'); } else { $($filterforfatter).next().removeClass('selected_select'); }
						if ($($filterutgiver).val() != '0'){ $($filterutgiver).next().addClass('selected_select'); } else { $($filterutgiver).next().removeClass('selected_select'); }
						if ($($filterserie).val() != '0'){ $($filterserie).next().addClass('selected_select'); } else { $($filterserie).next().removeClass('selected_select'); }
						
						// if brev selected, show brev filters
						if ($($filtersjanger).val() == '3'){ 

							// populate letter subselection dropdowns
							$filteredData = $data.find('li[data-sjanger="3"]' ); // make sure letters are shown
							
							$('#books_container ul li.bok.brev').removeClass('visible'); 
							$('#books_container ul li.bok.brev').addClass('visible').show();
						
						} else { 

							$('#filtrer_brev').slideUp(); $('#books_container ul li.bok.brev').removeClass('visible'); 
						}

						new_html = '';

						$.each($filteredData, function(index, value) {
							//console.log(1);
							new_html = new_html + $(this)[0].outerHTML;
						});



						//console.log(new_html);
						$('#books_container ul').html(new_html);

						$("#sort-books-newest").prop("checked", true); // always default to newest as sort
						
						if ($($filtersjanger).val() == 'Brev'){ 

							$('.letter_filter').fadeIn(1000); $('#books_container ul li.bok.brev').removeClass('visible'); 
						} 
							else { 
								$('.letter_filter').hide(); 
								$('#books_container ul li.bok.brev').removeClass('visible'); 
								$('.book_filter').fadeIn(1000); 
							}
						

						// dynamically create letter filters
						if ($($filtersjanger).val() == 'Brev'){ 

							// hide other filters
							$(".book_filter").hide();



							var $letter_senders = new Array();
							var $letter_recipients = new Array();
							var $letter_years = new Array();

							$('#books_container ul li.bok.brev').each(function(){

								
								if($(this).attr('data-avsender') != '') { 
									$letter_senders.push($(this).attr('data-avsender')); 
									console.log($(this).attr('data-avsender'));
								}
								if($(this).attr('data-mottager') != '') { 
									$letter_recipients.push($(this).attr('data-mottager')); 
									//console.log($(this).attr('data-mottager'));
								}
								if($(this).attr('data-ar') != '') { 
									$letter_years.push($(this).attr('data-ar')); 
									//console.log($(this).attr('data-ar'));
								}

							});

							$letter_senders = unique2($letter_senders).sort();
							$letter_recipients = unique2($letter_recipients).sort();
							$letter_years = unique2($letter_years).sort();
							

							// insert values in dropdowns
							console.log($letter_senders);

							var option = '<option value="0">Alle</option>';
							for (i=0;i<$letter_senders.length;i++){
							   option += '<option value="'+ $letter_senders[i] + '">' + $letter_senders[i] + '</option>';
							}
							
							$('#letter_sender').html(option);

							var option = '<option value="0">Alle</option>';
							for (i=0;i<$letter_recipients.length;i++){
							   option += '<option value="'+ $letter_recipients[i] + '">' + $letter_recipients[i] + '</option>';
							}

							
							$('#letter_recipient').html(option);

							var option = '<option value="0">Alle</option>';
							for (i=0;i<$letter_years.length;i++){
							   option += '<option value="'+ $letter_years[i] + '">' + $letter_years[i] + '</option>';
							}
							
							$('#letter_year').html(option);

							$("#letter_year, #letter_sender, #letter_recipient").selectpicker("refresh");
						}


				// LETTER FILTER
				// bind dropdowns in the form
				var $filter_letter_sender = $('#filter select#letter_sender');
				var $filter_letter_recipient = $('#filter select#letter_recipient');
				var $filter_letter_year = $('#filter select#letter_year');
				
				var $data2 = $applications.clone();

				$('#filter .letter_filter select').change(
					function() {

						// style selected selects
						if ($($filter_letter_sender).val() != '0'){ $($filter_letter_sender).next().addClass('selected_select'); } else { $($filter_letter_sender).next().removeClass('selected_select'); }
						if ($($filter_letter_recipient).val() != '0'){ $($filter_letter_recipient).next().addClass('selected_select'); } else { $($filter_letter_recipient).next().removeClass('selected_select'); }
						if ($($filter_letter_year).val() != '0'){ $($filter_letter_year).next().addClass('selected_select'); } else { $($filter_letter_year).next().removeClass('selected_select'); }
						
						//alert();
						$('.bok').addClass('visible');

						var $filteredData = $data2.find('li[class="bok"]' );

						if ($($filter_letter_sender).val() != '0'){ 

							$('.bok').each(function(){ 
							
								if ( $(this).attr('data-avsender') != $($filter_letter_sender).val()) { 
									console.log( $(this).attr('data-avsender') + $(this).attr('data-mottager') + " hiding");
									$(this).removeClass('visible').hide();
								}

							});

						};

						if ($($filter_letter_recipient).val() != '0'){ 

							$('.bok').each(function(){ 
							
								if ( $(this).attr('data-mottager') != $($filter_letter_recipient).val()) { 
									console.log( $(this).attr('data-avsender') + $(this).attr('data-mottager') + " hiding");
									$(this).removeClass('visible').hide();
								}

							});

						};

						if ($($filter_letter_year).val() != '0'){ 

							$('.bok').each(function(){ 
							
								if ( $(this).attr('data-ar') != $($filter_letter_year).val()) { 
									$(this).removeClass('visible').hide();
								}

							});

						};
						
						reset_book_numbers();
					

						
						
						


				});
				
				reset_book_numbers();

						

				});

	

	
	

	//IE svart bilde fix
	(function ($) {
	if (!$) return;
	$.fn.extend({
    fixPNG: function(sizingMethod, forceBG) {
            if (!($.browser.msie)) return this;
            var emptyimg = "http://www.bokselskap.no/wp-content/themes/bokselskap2/images/empty.gif"; //Path to empty 1x1px GIF goes here
            sizingMethod = sizingMethod || "scale"; //sizingMethod, defaults to scale (matches image dimensions)
            this.each(function() {
                    var isImg = (forceBG) ? false : jQuery.nodeName(this, "img"),
                            imgname = (isImg) ? this.src : this.currentStyle.backgroundImage,
                            src = (isImg) ? imgname : imgname.substring(5,imgname.length-2);
                    this.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod='" + sizingMethod + "')";
                    if (isImg) this.src = emptyimg;
                    else this.style.backgroundImage = "url(" + emptyimg + ")";
            });
            return this;
		}
	});
	})(jQuery);


   // Pagination setup
      $('#prev_page .nav_inner a').hover(function() {

        $('#prev_page #arrow').addClass('prev_arrow_active');
		$('#prev_page').addClass('prev_page_active');

      }, function() {

        $('#prev_page #arrow').removeClass('prev_arrow_active');
		$('#prev_page').removeClass('prev_page_active');
      });

	  $('#next_page .nav_inner a').hover(function() {

        $('#next_page #arrow').addClass('next_arrow_active');
		$('#next_page').addClass('next_page_active');

      }, function() {

        $('#next_page #arrow').removeClass('next_arrow_active');
		$('#next_page').removeClass('next_page_active');
      });
		
		// Vis verkspresentasjon

		$('#verkspresentasjon_les_mer').click( function() {

			if($('#verkspresentasjon_under').is(":hidden")) { $('#verkspresentasjon_under').show(); $('#verkspresentasjon_les_mer').html("Skjul"); }

			else { $('#verkspresentasjon_under').hide(); $('#verkspresentasjon_les_mer').html("Les mer..");
		 }

			return false;

		});


		/* Fade in sidebar på hover 

		$("#fade").hover(function(){

		$(this).stop().animate({"opacity": 1});
			},function(){
			$(this).stop().animate({"opacity": 0.25});
		});
		*/

		/* Fade in søkeboks på klikk */

		var $clicked_button = 0;

		// fade in bøker på forsiden på load

		$('#coda-slider-1').codaSlider({
		dynamicArrows: false,
		dynamicTabs: false,
		autoHeightEaseDuration: 300,
		slideEaseDuration: 1200,
		slideEaseFunction: "easeInOutCubic"
		});

		//$(".panel .bok1, .panel .bok2, .panel .bok3, .panel .bok4, .panel .bok5").css("opacity", 0);
		//$(".panel .bok1, .panel .bok2, .panel .bok3, .panel .bok4, .panel .bok5").css("margin-top", "10px");
		
		//$('#bok_slider').animate({opacity: 1}, 1);

		//$(".panel .bok3").animate({opacity: 1}, 800);
		//$(".panel .bok2, .panel .bok4").delay(100).animate({opacity: 1}, 800);
		//$(".panel .bok1, .panel .bok5").delay(200).animate({opacity: 1}, 800);
		//$("#arrows").animate({opacity: 1}, 800);


		// tooltip i tekstvisning

		var img_url = 'http://www.bokselskap.no/wp-content/themes/bokselskap2/images/k_ikon.png';
		var img_url_v = 'http://www.bokselskap.no/wp-content/themes/bokselskap2/images/v_ikon.png';
		var img_url_n = 'http://www.bokselskap.no/wp-content/themes/bokselskap2/images/n_ikon.png';
		//alert (img_url);

		if($('body').hasClass('page-template-bok-kapittel-page-php')) {
					
					// erstatt alle varianter, (disse blir plassert akkurat der de er)
					spans_variant = $('#text').find('span.criticalApp'); // finner alle kids, ikke bare første nivå

					spans_variant.each(function(index2) {

						tittel = $(this).html();

						tittel = tittel.replace(/(<([^>]+)>)/ig,"");

						tittel = tittel.replace("Tm","<em>Tm</em>");


						$(this).html("<img id=\"img_" + index2 + "\" class=\"k_ikon v_ikon\" src=\"" + img_url_v + "\" title=\" " + tittel + " <strong class=\'type\'>variant</strong>" + " \"/> ");
						// skjul fæl bg på parent span som ikke vil bort
						$(this).removeClass("criticalApp");

					});


					// erstatt alle kommentarer, (disse blir plassert akkurat der de er)
					spans_kommentarer = $('#text').find('span.commentary'); // finner alle kids, ikke bare første nivå

					spans_kommentarer.each(function(index2) {

						//alert($(this).html());

						tittel = $(this).html();
						//tittel = tittel.replace(/(<([^>]+)>)/ig,"");
						//alert(tittel);

						$(this).html("<img id=\"img_" + index2 + "\" class=\"k_ikon\" src=\"" + img_url + "\" title=\" " + tittel + " <strong class=\'type\'>kommentar</strong>" + " \"/> ");
						// skjul fæl bg på parent span som ikke vil bort
						$(this).removeClass("commentary");

					});

					//erstatt alle kommentarer m. class ="corrections"
					spans_kommentarer2 = $('#text').find('span.corrections'); // finner alle kids, ikke bare første nivå

					spans_kommentarer2.each(function(index2) {

						//alert($(this).html());

						tittel = $(this).html();
						//tittel = tittel.replace(/(<([^>]+)>)/ig,"");
						//alert(tittel);

						$(this).html("<img id=\"img_" + index2 + "\" class=\"k_ikon n_ikon\" src=\"" + img_url_n + "\" title=\" " + tittel + " <strong class=\'type\'>note</strong>" + " \"/> ");
						// skjul fæl bg på parent span som ikke vil bort
						$(this).removeClass("corrections");

					});

					//erstatt alle fotnoter
					spans_note = $('#text').find('span.footnote'); // finner alle kids, ikke bare første nivå

					spans_note.each(function(index2) {

						//alert($(this).html());

						tittel = $(this).html();
						//tittel = tittel.replace(/(<([^>]+)>)/ig,"");
						//alert(tittel);

						$(this).html("<img id=\"img_" + index2 + "\" class=\"k_ikon n_ikon\" src=\"" + img_url_n + "\" title=\" " + tittel + " <strong class=\'type\'>note</strong>" + " \"/> ");
						// skjul fæl bg på parent span som ikke vil bort
						$(this).removeClass("footnote");

					});

					// SIDETALL - forbered på å få tooltip
					spans_sidetall_siste = $('#text').find('span.origPage'); // finner alle kids, ikke bare første nivå

					spans_sidetall_siste.each(function(index2) {

						tittel = $(this).html();
						$(this).html('<a class="sidetall" title="Teller">' + tittel + '</a>');

					});


		/*

		// etter at alle tooltips er lastet, gjør om klammer/anf.tegn fra entities tilbake til vanlige symboler

			var replacethis = "_klammeVenstre_";
			var replacethis2 = "_klammeHøyre_";

			var replacethis3 = "_ANFVenstre_";
			var replacethis4 = "_ANFHøyre_";

			//var replacethis5 = "_firkantetKlamme_prikker_";


			var el = $('.breadcrumb');
			el.html(el.html().replace(new RegExp(replacethis, 'gim'), '('));
			el.html(el.html().replace(new RegExp(replacethis2, 'gim'), ')'));

			el.html(el.html().replace(new RegExp(replacethis3, 'gim'), '«'));
			el.html(el.html().replace(new RegExp(replacethis4, 'gim'), '»'));

			//el.html(el.html().replace(new RegExp(replacethis5, 'gim'), '[...]'));
			//el.html(el.html().replace(new RegExp(replacethis6, 'gim'), '_firkantetKlammeHøyre_'));

		*/


/*
 * jQuery Highlight plugin
 *
 * Based on highlight v3 by Johann Burkard
 * http://johannburkard.de/blog/programming/javascript/highlight-javascript-text-higlighting-jquery-plugin.html
 *
 */

 // hilite - brukt hvis mulig, ellers kan slettes


jQuery.extend({
    highlight: function (node, re, nodeName, className) {
        if (node.nodeType === 3) {
            var match = node.data.match(re);
            if (match) {
                var highlight = document.createElement(nodeName || 'span');
                highlight.className = className || 'highlight';
                var wordNode = node.splitText(match.index);
                wordNode.splitText(match[0].length);
                var wordClone = wordNode.cloneNode(true);
                highlight.appendChild(wordClone);
                wordNode.parentNode.replaceChild(highlight, wordNode);
                return 1; //skip added node in parent
            }
        } else if ((node.nodeType === 1 && node.childNodes) && // only element nodes that have children
                !/(script|style)/i.test(node.tagName) && // ignore script and style nodes
                !(node.tagName === nodeName.toUpperCase() && node.className === className)) { // skip if already highlighted
            for (var i = 0; i < node.childNodes.length; i++) {
                i += jQuery.highlight(node.childNodes[i], re, nodeName, className);
            }
        }
        return 0;
    }
});

jQuery.fn.unhighlight = function (options) {
    var settings = { className: 'highlight', element: 'span' };
    jQuery.extend(settings, options);

    return this.find(settings.element + "." + settings.className).each(function () {
        var parent = this.parentNode;
        parent.replaceChild(this.firstChild, this);
        parent.normalize();
    }).end();
};

jQuery.fn.highlight = function (words, options) {
    var settings = { className: 'highlight', element: 'span', caseSensitive: false, wordsOnly: false };
    jQuery.extend(settings, options);

    if (words.constructor === String) {
        words = [words];
    }
    words = jQuery.grep(words, function(word, i){
      return word != '';
    });
    if (words.length == 0) { return this; };

    var flag = settings.caseSensitive ? "" : "i";
    var pattern = "(" + words.join("|") + ")";
    if (settings.wordsOnly) {
        pattern = "\\b" + pattern + "\\b";
    }
    var re = new RegExp(pattern, flag);

    return this.each(function () {
        jQuery.highlight(this, re, settings.element, settings.className);
    });
};

		}


(function($) {
    $.fn.fontresizing = function(customOptions) {
        var options = $.extend({}, $.fn.fontresizing.defaultOptions, customOptions);
        var bodyClasses = '' + options.smallClass + ' ' + options.mediumClass + ' ' + options.largeClass + '';
        return this.each(function() {
		//alert(options.fontresizingClass);
            $(this).append('<div class="' + options.fontresizingClass + '"><a title="Mindre tekststørrelse" href="" class="' + options.smallClass + '">A</a><a title="Vanlig tekststørrelse" href="" class="active_resize ' + options.mediumClass + '">A</a><a title="Større tekststørrelse" href="" class="' + options.largeClass + '">A</a>');

            $('div.' + options.fontresizingClass + ' a').click(function() {
                var cssClass = $(this).attr('class');

				// fjern aktiv klasse på trykk
				$('div.' + options.fontresizingClass + ' a').removeClass('active_resize');

				// ny aktiv
				$(this).addClass('active_resize');
                $('.breadcrumb p').removeClass(bodyClasses).addClass(cssClass);
                createCookie('fontresizingClass', cssClass, options.cookieDuration);

                return false;
            });

            var fontresizingClass = readCookie('fontresizingClass');



            if (fontresizingClass == options.smallClass || fontresizingClass == options.mediumClass || fontresizingClass == options.largeClass) {
                $('.breadcrumb p').removeClass(bodyClasses).addClass(fontresizingClass);
				// sett aktiv størrelse når siden laster
				$('div.' + options.fontresizingClass + ' a').removeClass('active_resize');
				$('div.' + options.fontresizingClass + ' a.' + fontresizingClass).addClass('active_resize');

            }

			 else {

			// sett aktiv størrelse når siden laster (hvis ingen cookie fra før)
				//$('div.' + options.fontresizingClass + ' a.' + fontresizingClass).addClass('active_resize');

			}

        });
    };



    $.fn.fontresizing.defaultOptions = {
        smallClass: 'resize_small',
        mediumClass: 'resize_medium',
        largeClass: 'resize_large',
        fontresizingClass: 'font-resizing',
        cookieDuration: 365
    };
})(jQuery);


// With default options

jQuery(function($) {
    $('#font_resizer').fontresizing();
});


});