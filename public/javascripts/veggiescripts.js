$(document).ready(function() {
		
	$('#jqueryexample').toggle(function() { 
		$(this).animate({'height':'+=150px'}, 1000, 'swing');
	}, function() {
			$(this).animate({'height':'-=150px'}, 1000, 'swing');
	});


});