import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _formKey = GlobalKey<FormState>();
  String result = "";
  TextEditingController p = TextEditingController();
  TextEditingController r = TextEditingController();
  TextEditingController n = TextEditingController();
  bool reset = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMI Calculator"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Image(
                  image: AssetImage("assets/images/emi.png"),
                  height: 150,
                  repeat: ImageRepeat.noRepeat,
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (txt) {
                    if (txt.isEmpty) {
                      return "Please Enter Principal Amount";
                    }
                  },
                  controller: p,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Enter Amount",
                    hintText: "Enter Principal Amount",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (txt) {
                    if (txt.isEmpty) {
                      return "Please Enter Rate of Interest";
                    }
                  },
                  controller: r,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Enter Rate",
                    hintText: "Enter Interest Rate",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (txt) {
                    if (txt.isEmpty) {
                      return "Please Enter No. of Months";
                    }
                  },
                  controller: n,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Enter Months",
                    hintText: "Enter No. of Months",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            var emi = (double.parse(this.p.text) *
                                    double.parse(this.r.text) *
                                    double.parse(this.n.text)) /
                                100;
                            this.result = "Monthly EMI Rs. " + emi.toString();
                            this.reset = true;
                          }
                        });
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: EdgeInsets.all(8),
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      shape: StadiumBorder(),
                    ),
                  ),
                  Container(
                    child: FlatButton(
                      onPressed: this.reset == false ? null : (){
                        setState(() {
                          this.p.text = "";
                          this.r.text = "";
                          this.n.text = "";
                          this.result = "";
                          this.reset = false;
                        });
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.blue,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8),
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
