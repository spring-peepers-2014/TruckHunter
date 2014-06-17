// AutoComplete = {};


// AutoComplete.Controller = function() {
//   this.foodTrucks = [];
//   this.findFoodTrucks();
//   this.autoCompleteThis();
// }

// AutoComplete.Controller.prototype = {
//   findFoodTrucks: function() {
//     $.ajax({
//       type: 'get',
//       url: '/searchbar/new',
//       dataType: 'json'
//     }).done(function(response){
//       var namesofFoodTrucks = response
//       for (var i=0; i < namesofFoodTrucks.length; i++) {
//         foodTrucks.push({ value: namesofFoodTrucks[i]});
//       }
//     })
//   },

//   autoCompleteThis: function() {
//     $('#autocomplete').autocomplete({
//         lookup: foodTrucks
//     })
//   }
  

// }