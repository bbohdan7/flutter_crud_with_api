import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_crud_with_api/services/api.dart';
import 'adddatawidget.dart';
import 'detailwidget.dart';
import 'models/cases.dart';

import 'dart:developer' as dev;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    dev.log("Building MyApp");
    return MaterialApp(
      title: 'Flutter Crud Api',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: "Flutter Crud Api"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  late Future<List<Cases>> _futureCasesList;

  @override
  Widget build(BuildContext context) {
    dev.log("Building MyHomePage");
    _loadData();
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                _futureCasesList = api.allCases();
              });
            });
          },
          child: FutureBuilder<List<Cases>>(
              initialData: const [],
              future: _futureCasesList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? CasesList(cases: snapshot.data as List<Cases>)
                    : Padding(
                        padding: const EdgeInsets.all(100),
                        child: Column(
                          children: <Widget>[
                            const Text("Couldn't load data"),
                            ElevatedButton.icon(
                                icon: const Icon(Icons.refresh),
                              onPressed: _loadData,
                              label: const Text("Try again"),
                            )
                          ],
                        ),
                      );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () => _navigateToAddScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    dev.log("initializing Main widget...");
    _loadData();
    super.initState();
  }

  void _loadData() {
    dev.log("Loading data...");
    setState(() {
      _futureCasesList = api.allCases();
    });
  }

  void _navigateToAddScreen(BuildContext context) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddDataWidget()));
  }
}

class CasesList extends StatelessWidget {
  final List<Cases> cases;

  const CasesList({Key? key, required this.cases}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cases.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailWidget(cases[index]),
                ),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(cases[index].name!),
              subtitle: Text("age: ${cases[index].age}"),
              trailing: Text("${cases[index].country}, ${cases[index].city}"),
            ),
          ),
        );
      },
    );
  }
}
