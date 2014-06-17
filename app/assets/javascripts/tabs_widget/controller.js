TabBarWidget.Controller = function() {
	this.listenToClick();
	this.listenToClose();
}

TabBarWidget.Controller.prototype = {
	listenToClick: function() {
		$('#truckownertab').on('click', function(){
			$('#readme').show();
		});

		$('#newtrucktab').on('click', function(){
  			$('.opened').show();
		});
 	},
	listenToClose: function() {
		$(document).on('click', '#close', function(e){
  			$('#popup').remove();
  			$('#readme').hide();
  			$('.opened').hide();
		})
	}
}