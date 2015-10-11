class Foobar {
  var member = 5;
  var uninitialized;
  int number;
  String greeting {
    get { return "Hello, world " + this.number + " times."; }
  }

  Foobar(value=0) {
    this.number = value;
  }

  void hello() {
    console.log('Hello!');
  }

  Foobar __add__(value) {
    return Foobar(value + this.number);
  }

}
