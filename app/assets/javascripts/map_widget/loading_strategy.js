MapWidget.LoadingStrategy = function() {  
}

MapWidget.LoadingStrategy.prototype = {
  
  showLoad: function() {
    var loader = document.getElementById('loader');
  
    startLoading();

    L.mapbox.tileLayer('inslee.igapaca7')
      .addTo(map) 
      .on('load', finishedLoading); // when the tiles load, remove the screen
  }

}

function startLoading() {
    loader.className = '';
}

function finishedLoading() {
    // first, toggle the class 'done', which makes the loading screen
    // fade out
    loader.className = 'done';
    setTimeout(function() {
        // then, after a half-second, add the class 'hide', which hides
        // it completely and ensures that the user can interact with the
        // map again.
        loader.className = 'hide';
    }, 500);
}