$(function(){


  var foodTrucks = []
  findFoodTrucks();
  autoComplete();

  function findFoodTrucks() {
    $.ajax({
        type: 'get',
        url: '/searchbar/new',
        dataType: 'json'
    }).done(function(response){
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
  


  // $('#searchbox').keyup(search);

  //   function search() {
  //   // get the value of the search input field
  //       var searchString = $('#autocomplete').val().toLowerCase();
  //       console.log(searchString)
  //       featureLayer.setFilter(showState);

  //   // here we're simply comparing the 'state' property of each marker
  //   // to the search string, seeing whether the former contains the latter.
  //       function showTruck(feature) {
  //           return feature.properties.title
  //               .toLowerCase()
  //               .indexOf(searchString) !== -1;
  //       }
  //   }
  // setup autocomplete function pulling from currencies[] array
  // $('#autocomplete').autocomplete({
  //   lookup: foodTrucks,
  //   onSelect: function (suggestion) {
  //     var thehtml = '<strong>Currency Name:</strong> ' + suggestion.value + ' <br> <strong>Symbol:</strong> ' + suggestion.data;
  //     $('#outputcontent').html(thehtml);
  //   }
  // });
  

  

  


});