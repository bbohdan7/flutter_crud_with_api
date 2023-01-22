import 'package:flutter/material.dart';
import 'package:flutter_crud_with_api/main.dart';
import 'package:flutter_crud_with_api/services/api.dart';

import 'editdatawidget.dart';
import 'models/cases.dart';

class DetailWidget extends StatefulWidget {
  final Cases cases;

  const DetailWidget(this.cases, {super.key});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();

  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: SingleChildScrollView(
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
                        Text("Name: ",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.cases.name!,
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Gender',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.cases.gender!,
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Age',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.cases.age.toString(),
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Address',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.cases.address!,
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        const Text('City',
                            style: TextStyle(color: Colors.black)),
                        Text(widget.cases.city!,
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        const Text('Country',
                            style: TextStyle(color: Colors.black)),
                        Text(widget.cases.country!,
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        const Text('Update date',
                            style: TextStyle(color: Colors.black)),
                        Text(widget.cases.updated!,
                            style: Theme.of(context).textTheme.titleLarge),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () =>
                              _navigateToEditScreen(context, widget.cases),
                          child: const Text('Edit',
                              style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () => _confirmDialog(),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.blue)),
                          child: const Text('Delete',
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _navigateToEditScreen(BuildContext context, Cases cases) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditDataWidget(cases)));
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
              child: ListBody(
            children: const <Widget>[
              Text('Are you sure you want to delete this item?'),
            ],
          )),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  api.deleteCase(widget.cases.id!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (route) =>
                              const MyHomePage(title: "Flutter Crud Api")));
                  //Navigator.popUntil(
                  //    context, ModalRoute.withName(Navigator.defaultRouteName));
                },
                child: const Text("Yes")),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
