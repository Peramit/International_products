import 'package:flutter_pj/main.dart';
import 'package:flutter_pj/model/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pj/provider/transactionProvider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final name = TextEditingController();
  final type = TextEditingController();
  final Catalog = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form to add information international expo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 61, 61, 61),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/in3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Start-End',
                      filled: true,
                      fillColor: Colors.white.withAlpha(204),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.grey,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                    autofocus: false,
                    controller: titleController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'Please fill in information';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Business Name',
                      filled: true,
                      fillColor: Colors.white.withAlpha(204),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.grey,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                    autofocus: false,
                    controller: name,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'Please fill in information';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      filled: true,
                      fillColor: Colors.white.withAlpha(204),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.grey,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                    autofocus: false,
                    controller: type,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'Please fill in information';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Exhibition Type',
                      filled: true,
                      fillColor: Colors.white.withAlpha(204),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.grey,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                    autofocus: false,
                    controller: Catalog,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'Please fill in information';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Product List',
                      filled: true,
                      fillColor: Colors.white.withAlpha(204),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.grey,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    validator: (String? input) {
                      try {
                        double amount = double.parse(input!);
                        if (amount < 0) {
                          return 'Please enter a value greater than 0.';
                        }
                      } catch (e) {
                        return 'Please enter a numeric value.';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var statement = Transactions(
                          keyID: null,
                          title: titleController.text,
                          title1: name.text,
                          title2: type.text,
                          title3: Catalog.text,
                          amount: int.parse(amountController.text),
                          date: DateTime.now(),
                        );

                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);
                        provider.addTransaction(statement);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return const MyHomePage();
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}