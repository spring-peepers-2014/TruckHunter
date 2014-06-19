EventListener = function() {
	this.listenToClick();
	this.listenToClose();
}

EventListener.prototype = {
	listenToClick: function() {
		$('#addtruck').on('click', function(){
  			console.log('yo')
  			$('#usersubmit').show();
  			$('#truckowner').show();
		});

		$('#usersubmit').on('click', function(){
  			$('#truckowner').hide();
  			$(this).hide()
  			$('#usersubmitform').slideDown('slow');
		});

		$('#truckowner').on('click', function(){
			$('#usersubmit').hide();
  			$(this).hide();
  			$('#truckownerreadme').slideDown('slow');
		});

		$('form.new_truck').submit(function(e) {
		    e.preventDefault();

		    $.ajax({
		      type: 'POST',
		      url: '/addtruck',
		      data: $(this).serialize()
		    }).done(function() {
		     document.getElementById("new_truck").reset();
		     $('#usersubmitform').hide();
		   })
  		})
 	},
	listenToClose: function() {
		$(document).on('click', '#close', function(e){
  			$('#popup').remove();
  			$('#readme').hide();
  			$('#newtruckform').hide();
  			$('#usersubmitform').hide();
  			$('#truckownerreadme').hide();
		})
	}
}