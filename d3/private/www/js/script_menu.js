function menu_showSVG(tab) {
    name = "svg"+tab;
    console.log(name);
    var svg = document.getElementById(name);
    console.log(svg);
    svg.toDataURL("image/svg+xml", {
      callback: function(data) {
        window.open(data,'_blank');
      }
    })
  }

function menu_showPNG(tab) {
    name = "svg"+tab;
    console.log(name);
    var svg = document.getElementById(name);
    console.log(svg);
    svg.toDataURL("image/png", {
      callback: function(data) {
        window.open(data,'_blank');
      }
    })
  }

function menu_saveSVG(tab) {
    name = "svg"+tab;
    console.log(name);
    var svg = document.getElementById(name);
    console.log(svg);
    svg.toDataURL("image/svg+xml", {
      callback: function(data) {
        var blob = new Blob([data], {type: "text/plain;charset=utf-8"});
        alert('The save functionality has not been implemented yet');
        return;
        saveAs(blob, "figure "+tab+".svg");
      }
    })
  }

function menu_savePNG(tab) {
    name = "svg"+tab;
    console.log(name);
    var svg = document.getElementById(name);
    console.log(svg);
    svg.toDataURL("image/png", {
      callback: function(data) {
        var blob = new Blob([data], {type: "text/plain;charset=utf-8"});
        alert('The save functionality has not been implemented yet');
        return;
        saveAs(blob, "figure "+tab+".png");
      }
    })
  }
