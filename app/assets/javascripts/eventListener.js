EventListener = function(view) {
	this.view = view;
	this.listenToClick();
	this.listenToClose();
}

EventListener.prototype = {
	listenToClick: function() {
		var self = this;
		$('#addtruck').on('click', function(){
			self.view.closePopUp();
			self.view.closeEverything();
  			$('#usersubmit').show();
  			$('#truckowner').show();
		});

		$('#usersubmit').on('click', function(){
			self.view.closePopUp();
  			self.view.closeEverything();
  			$('#usersubmitform').slideDown('slow');
		});

		$('#truckowner').on('click', function(){
			self.view.closePopUp();
  			self.view.closeEverything();
  			$('#truckownerreadme').slideDown('slow');
		});

		$('findme').on('click', function() {
			self.view.closeEverything();
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

