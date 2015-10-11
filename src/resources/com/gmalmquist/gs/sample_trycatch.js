// From http://www.w3schools.com/js/tryit.asp?filename=tryjs_try_catch

try {
      adddlert("Welcome guest!");
}
catch(err) {
      document.getElementById("demo").innerHTML = err.message;
}
