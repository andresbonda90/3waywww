( function( $ ){
	if($(window).width() >= 700){
	//Masonry blocks
	$blocks = $(".posts");

	$blocks.imagesLoaded(function(){
		$blocks.masonry({
			itemSelector: '.threecolumn, .twocolumn',
			layoutMode : 'masonry'
		});

		// Fade blocks in after images are ready (prevents jumping and re-rendering)
		$(".threecolumn, .twocolumn").fadeIn();
	});

	$(window).resize(function () {
		$blocks.masonry();
	});
	}
})( jQuery );