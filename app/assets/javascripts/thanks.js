$( document ).ready(function() {
    $('.thanks-image').hover(function() {
		$(this).animate({'margin-right': '500'}, 500);
		$('.thanks-text').css({
			'display': 'block',
			'animation': 'fadeIn 2s ease 0s 1 normal'
		});
	});
});