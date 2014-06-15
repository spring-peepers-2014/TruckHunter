$(function(){

  // var currencies = [
  //   { value: 'Afghan afghani'},
  //   { value: 'Albanian lek'},
  //   { value: 'Algerian dinar'},
  //   { value: 'European euro'},
  //   { value: 'Angolan kwanza' },

  // ];
  var foodTrucks = []
  findFoodTrucks();
  autoComplete();

  function findFoodTrucks() {
    $.ajax({
        type: 'get',
        url: '/searchbar/new',
        dataType: 'json'
    }).done(function(response){
        // console.log("scope")
        // console.log(foodTrucks)
        var namesofFoodTrucks = response
        for (var i=0; i < namesofFoodTrucks.length; i++) {
            foodTrucks.push({ value: namesofFoodTrucks[i]});
        }
        return foodTrucks;
    })
  }


  function autoComplete() {
    $('#autocomplete').autocomplete({
        lookup: foodTrucks
    })
  }
  
  // setup autocomplete function pulling from currencies[] array
  // $('#autocomplete').autocomplete({
  //   lookup: foodTrucks,
  //   onSelect: function (suggestion) {
  //     var thehtml = '<strong>Currency Name:</strong> ' + suggestion.value + ' <br> <strong>Symbol:</strong> ' + suggestion.data;
  //     $('#outputcontent').html(thehtml);
  //   }
  // });
  

  

  


});