import 'package:flutter_pj/provider/transactionProvider.dart';
import 'package:flutter_pj/screen/editScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAscending = true;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('image/in3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 56, 56, 56),
          elevation: 0,
          toolbarHeight: 40,
          title: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.white, size: 18),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search',
                            hintStyle:
                                TextStyle(color: Colors.white70, fontSize: 14),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          onChanged: (text) {
                            setState(() {
                              _searchText = text;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  dropdownColor: Colors.grey[800],
                  underline: const SizedBox(),
                  icon:
                      const Icon(Icons.category, color: Colors.white, size: 18),
                  items: <String>[
                    'All',
                    'Fashion',
                    'Food',
                    'Lifestyle',
                    'Automotive',
                  ].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: Icon(
                    isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      isAscending = !isAscending;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        body: Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            if (provider.transactions.isEmpty) {
              return const Center(
                child: Text('No Items'),
              );
            } else {
              var filteredTransactions =
                  provider.transactions.where((transaction) {
                bool matchesSearchText =
                    transaction.title.contains(_searchText) ||
                        transaction.title3.contains(_searchText);
                bool matchesCategory = _selectedCategory == 'All' ||
                    transaction.title2 == _selectedCategory;
                return matchesSearchText && matchesCategory;
              }).toList();

              filteredTransactions.sort((a, b) => isAscending
                  ? a.amount.compareTo(b.amount)
                  : b.amount.compareTo(a.amount));

              return ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  var statement = filteredTransactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('image/in4.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        ListTile(
                          title: _buildShadowedText(statement),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black54,
                            child: FittedBox(
                              child: Text('${statement.amount}',
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.deleteTransaction(statement.keyID);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditScreen(statement: statement);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildShadowedText(var statement) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(136, 0, 0, 0),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'State-End: ${statement.title}',
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Text(
            'Business Name: ${statement.title1}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Text(
            'Category: ${statement.title2}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Text(
            'Exhibition Type: ${statement.title3}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd MMM yyyy hh:mm:ss').format(statement.date),
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}