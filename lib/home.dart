import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _gender = 1.0;
  String _genderValue;
  double _meterValue;
  double _kgValue;
  double _bmi;
  String _displayResult = "";
  var _healthRange;
  Color _genderColor;

  var _formKey = GlobalKey<FormState>();

  TextEditingController cmController = TextEditingController();
  TextEditingController kgController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _genderValue = _gender == 1.0 ? "Male" : "Female";
    _genderColor = _gender == 1.0 ? Colors.blue : Colors.pink;
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, right: 20.0, left: 20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       Text(
            //         "Gender",
            //         style: Theme.of(context).textTheme.headline5,
            //       ),
            //       showSlider()
            //     ],
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Height",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100.0,
                        child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Must not be empty";
                            }
                            return null;
                          },
                          controller: cmController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "cm",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Weight",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 100.0,
                        child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Must not be empty";
                            }
                            return null;
                          },
                          controller: kgController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "kg",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       Text(
            //         "Age",
            //         style: Theme.of(context).textTheme.headline5,
            //       ),
            //       Row(
            //         children: <Widget>[
            //           SizedBox(
            //             width: 100.0,
            //             // height: 50.01,
            //             child: TextFormField(
            //               validator: (String value) {
            //                 if (value.isEmpty) {
            //                   return "Must not be empty";
            //                 }
            //                 return null;
            //               },
            //               controller: ageController,
            //               keyboardType: TextInputType.number,
            //               decoration: InputDecoration(
            //                   labelText: "age",
            //                   border: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(5))),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_formKey.currentState.validate()) {
                          _getBmi();
                        }
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                  SizedBox(width: 50.0),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.red,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _reset();
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 1.5),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _displayResult == "" ? null : Colors.grey[800],
                ),
                child: Text(
                  _displayResult,
                  style: TextStyle(
                      fontSize: 18.0, letterSpacing: 1.5, color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Widget showSlider() {
    return Container(
      width: 100.0,
      child: Slider(
        activeColor: _genderColor,
        value: _gender,
        onChanged: (double newValue) {
          setState(() {
            _gender = newValue;
          });
        },
        divisions: 1,
        min: 1.0,
        max: 2.0,
        label: _genderValue,
      ),
    );
  }

  void _getBmi() {
    setState(() {
      _meterValue = double.parse(cmController.text) / 100;
      _kgValue = double.parse(kgController.text);
      _bmi = _kgValue / (_meterValue * _meterValue);
      if (_bmi < 18.5) {
        _healthRange = "Underweight";
      } else if (_bmi > 18.5 && _bmi < 24.9) {
        _healthRange = "Healthy / Normal weight";
      } else if (_bmi > 25.0 && _bmi < 29.9) {
        _healthRange = "Overweight";
      } else if (_bmi > 30) {
        _healthRange = "Obese";
      }
      _displayResult = showString(_bmi, _healthRange);
      print(_bmi);
    });
  }

  void _reset() {
    setState(() {
      cmController.text = "";
      kgController.text = "";
      ageController.text = "";
      _gender = 1;
      _displayResult = "";
    });
  }

  String showString(bmi, healthRange) {
    var round = double.parse(bmi.toStringAsFixed(2));
    return "Your BMI is $round and you are considered $healthRange. These finding are only for 20 years old and above.";
  }
}
