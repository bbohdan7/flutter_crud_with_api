import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_with_api/services/api.dart';

import 'adddatawidget.dart';
import 'models/cases.dart';

class EditDataWidget extends StatefulWidget {
  final Cases cases;

  EditDataWidget(this.cases);

  @override
  _EditDataWidgetState createState() => _EditDataWidgetState();
}

class _EditDataWidgetState extends State<EditDataWidget> {
  _EditDataWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  int? id;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _addressController = TextEditingController();
  String gender = 'male';
  Gender _gender = Gender.male;
  String status = 'single';
  Status _status = Status.single;

  @override
  void initState() {
    id = widget.cases.id!;
    _nameController.text = widget.cases.name!;
    gender = widget.cases.gender!;

    if (widget.cases.gender == 'male') {
      _gender = Gender.male;
    } else {
      _gender = Gender.female;
    }

    _ageController.text = widget.cases.age.toString();
    _addressController.text = widget.cases.address!;
    _cityController.text = widget.cases.city!;
    _countryController.text = widget.cases.country!;

    if (widget.cases.status == 'single') {
      _status = Status.single;
    } else if (widget.cases.status == 'divorced') {
      _status = Status.divorced;
    } else {
      _status = Status.married;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Cases"),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                width: 440,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text("Full Name"),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              hintText: "Enter your full name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please fill your name";
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text("Gender"),
                          ListTile(
                            title: const Text("Male"),
                            leading: Radio(
                              value: Gender.male,
                              groupValue: _gender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _gender = value!;
                                  gender = 'male';
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Female'),
                            leading: Radio(
                              value: Gender.female,
                              groupValue: _gender,
                              onChanged: (Gender? value) {
                                setState(() {
                                  _gender = value!;
                                  gender = 'female';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text('Age'),
                          TextFormField(
                            controller: _ageController,
                            decoration: const InputDecoration(
                              hintText: 'Age',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your age";
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text('Address'),
                          TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              hintText: 'Address',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your address";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text('City'),
                          TextFormField(
                            controller: _cityController,
                            decoration: const InputDecoration(
                              hintText: "City",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your city";
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text('Country'),
                          TextFormField(
                            controller: _countryController,
                            decoration: const InputDecoration(
                              hintText: "Country",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your country";
                              }
                              return null;
                            },
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          const Text("Status"),
                          ListTile(
                            title: const Text("Married"),
                            leading: Radio(
                              value: Status.married,
                              groupValue: _status,
                              onChanged: (Status? value) {
                                setState(() {
                                  _status = value!;
                                  status = 'married';
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("Divorced"),
                            leading: Radio(
                              value: Status.divorced,
                              groupValue: _status,
                              onChanged: (Status? value) {
                                setState(() {
                                  _status = value!;
                                  status = 'divorced';
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Single'),
                            leading: Radio(
                              value: Status.single,
                              groupValue: _status,
                              onChanged: (Status? value) {
                                setState(() {
                                  _status = value!;
                                  status = 'single';
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () {
                                if (_addFormKey.currentState!.validate()) {
                                  _addFormKey.currentState!.save();
                                  api.updateCase(
                                      id!,
                                      Cases(
                                        name: _nameController.text,
                                        gender: gender,
                                        age: int.parse(_ageController.text),
                                        address: _ageController.text,
                                        city: _cityController.text,
                                        country: _countryController.text,
                                        status: status,
                                      ));
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Save', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
