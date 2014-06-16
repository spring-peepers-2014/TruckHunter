$(document).ready(function(){

	var map = new MapWidget.View();
	map.draw();

	$('.newtrucktab').on('click', function(){
		$('.opened').show();
	});


	$('form.new_truck').submit(function(e) {
		e.preventDefault();

		$.ajax({
		        type: 'POST',
		        url: '/addtruck',
		        data: $(this).serialize()
		}).done(function() {
		   document.getElementById("new_truck").reset();
		   $('.opened').hide();
		   })
	})


});