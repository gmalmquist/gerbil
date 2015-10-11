// From http://www.w3schools.com/js/tryit.asp?filename=tryjs_while
function myFunction() {
      var text = "";
          var i = 0;
              while (i < 10) {
                        text += "<br>The number is " + i;
                                i++;
                                    }
                  document.getElementById("demo").innerHTML = text;
}
