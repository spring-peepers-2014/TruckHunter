TabBarWidget.Controller = function() {
	this.listenToClick();
	this.listenToClose();
}

TabBarWidget.Controller.prototype = {
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