$( document ).ready(function() {
    $('.thanks-image').hover(function() {
		$(this).animate({'margin-right': '500'}, 1000);
		$('.thanks-text').css({
			'display': 'block',
			'animation': 'fadeIn 3s ease 0s 1 normal'
		});
	});
});