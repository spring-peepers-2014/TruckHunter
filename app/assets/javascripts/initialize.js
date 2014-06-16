$(document).ready(function(){

	var map = new MapWidget.View();
	map.draw();


	$('.newtrucktab').on('click', function(){
		$('.opened').show();
	});


});