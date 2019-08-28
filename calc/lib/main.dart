import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String op = "";
  String res = "";
  String operator;
  int num1 = 0;
  int num2 = 0;

  void btnClicked(String btnVal) {
    if (btnVal == "AC") {
      this.op = "";
      this.num1 = 0;
      this.num2 = 0;
      this.res = "";
    } else if (btnVal == "+" ||
        btnVal == "-" ||
        btnVal == "*" ||
        btnVal == "/" ||
        btnVal == "%") {
      this.res = "";
      this.num1 = int.parse(this.op);
      this.operator = btnVal;
    } else if (btnVal == "=") {
      this.num2 = int.parse(this.res);
      if (this.operator == "+") {
        this.res = (this.num1 + this.num2).toString();
      }
      if (this.operator == "-") {
        this.res = (this.num1 - this.num2).toString();
      }
      if (this.operator == "*") {
        this.res = (this.num1 * this.num2).toString();
      }
      if (this.operator == "/") {
        this.res = (this.num1 / this.num2).toString();
      }
      if (this.operator == "%") {
        this.res = (this.num1 % this.num2).toString();
      }
    } else {
      this.res = int.parse(this.op + btnVal).toString();
    }

    setState(() {
      this.op = this.res;
    });
  }

  Widget calcButton(String val, Color clr, [double sw]) {
    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.all(30),
      minWidth: sw != null ? sw : null,
      onPressed: () {
        btnClicked(val);
      },
      color: Color(0xFF212327),
      textColor: clr,
      child: Text(
        val,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  Widget equalButton([double sw]) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [BoxShadow(color: Colors.green, blurRadius: 8)],
        gradient:
            LinearGradient(colors: [Color(0xFF9AFAA8), Color(0xFF17D398)]),
      ),
      child: MaterialButton(
        shape: StadiumBorder(),
        onPressed: () {
          btnClicked("=");
        },
        child: Text(
          "=",
          style: TextStyle(fontSize: 30),
        ),
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 12),
        minWidth: sw != null ? sw : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth2 = MediaQuery.of(context).size.width / 2;
    var screenWidth4 = MediaQuery.of(context).size.width / 4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF20292A),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF212327),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Color(0xFF20292A),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                this.op,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              calcButton("%", Color(0xFFB5FCB4), screenWidth2),
              calcButton("/", Color(0xFFB5FCB4), screenWidth2),
            ],
          ),
          Row(
            children: <Widget>[
              calcButton("7", Color(0xFFB5B7BB), screenWidth4),
              calcButton("8", Color(0xFFB5B7BB), screenWidth4),
              calcButton("9", Color(0xFFB5B7BB), screenWidth4),
              calcButton("*", Color(0xFFB5FCB4), screenWidth4),
            ],
          ),
          Row(
            children: <Widget>[
              calcButton("4", Color(0xFFB5B7BB), screenWidth4),
              calcButton("5", Color(0xFFB5B7BB), screenWidth4),
              calcButton("6", Color(0xFFB5B7BB), screenWidth4),
              calcButton("-", Color(0xFFB5FCB4), screenWidth4),
            ],
          ),
          Row(
            children: <Widget>[
              calcButton("1", Color(0xFFB5B7BB), screenWidth4),
              calcButton("2", Color(0xFFB5B7BB), screenWidth4),
              calcButton("3", Color(0xFFB5B7BB), screenWidth4),
              calcButton("+", Color(0xFFB5FCB4), screenWidth4),
            ],
          ),
          Row(
            children: <Widget>[
              calcButton("AC", Color(0xFFB5FCB4), screenWidth2/2),
              calcButton("0", Color(0xFFB5B7BB), screenWidth2/2),
              SizedBox(width: 10),
              equalButton(screenWidth2-20),
            ],
          ),
        ],
      ),
    );
  }
}
