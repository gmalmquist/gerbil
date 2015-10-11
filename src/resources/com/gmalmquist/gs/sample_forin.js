// From http://www.w3schools.com/js/tryit.asp?filename=tryjs_object_for_in

var txt = "";
var person = {fname:"John", lname:"Doe", age:25}; 
var x;
for (x in person) {
      txt += person[x] + " ";
}
document.getElementById("demo").innerHTML = txt;
