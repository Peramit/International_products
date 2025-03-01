import 'package:flutter_pj/main.dart';
import 'package:flutter_pj/model/transactions.dart';
import 'package:flutter_pj/provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final name = TextEditingController();
  final Type = TextEditingController();
  final Catalog = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.statement.title;
    name.text = widget.statement.title1;
    Type.text = widget.statement.title2;
    Catalog.text = widget.statement.title3;
    amountController.text = widget.statement.amount.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit International Prodauct',
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/in2.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: titleController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'Please fill in information';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Business Name',
                    filled: true,
                    fillColor: Colors.white.withAlpha(204),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: name,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'Please fill in information';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    filled: true,
                    fillColor: Colors.white.withAlpha(204),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: Type,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'Please fill in information';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Exhibition Type',
                    filled: true,
                    fillColor: Colors.white.withAlpha(204),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: Catalog,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'Please fill in information';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '(Product List',
                    filled: true,
                    fillColor: Colors.white.withAlpha(204),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (String? input) {
                    try {
                      int amount = int.parse(input!);
                      if (amount < 0) {
                        return 'Please enter a value greater than 0.';
                      }
                    } catch (e) {
                      return 'Please enter a numeric value.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Edit'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var statement = Transactions(
                        keyID: widget.statement.keyID,
                        title: titleController.text,
                        title1: name.text,
                        title2: Type.text,
                        title3: Catalog.text,
                        amount: int.parse(amountController.text),
                        date: DateTime.now(),
                      );

                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.updateTransaction(statement);

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
    );
  }
}