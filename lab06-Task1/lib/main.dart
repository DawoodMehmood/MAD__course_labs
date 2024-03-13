import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SavedSuggestionsScreen(),
    );
  }
}

class SavedSuggestionsScreen extends StatefulWidget {
  const SavedSuggestionsScreen({super.key});

  @override
  _SavedSuggestionsScreenState createState() => _SavedSuggestionsScreenState();
}

class _SavedSuggestionsScreenState extends State<SavedSuggestionsScreen> {
  List<String> savedSuggestions = [
    "Audi",
    "BMW",
    "Ferrari",
    "Lambo",
    "Mercedes",
    "Porsche",
    "Tesla",
    "Toyota",
    "Volkswagen",
    "Volvo"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dawood Mehmood - BESE 11A - 341706"),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: savedSuggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(savedSuggestions[index]),
                  onTap: () {
                    _showRemoveDialog(savedSuggestions[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showRemoveDialog(String suggestion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Remove Suggestion"),
          content: Text(
              "Are you sure you want to remove '$suggestion' from the list?"),
          actions: [
            TextButton(
              onPressed: () {
                _removeSuggestion(suggestion);
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
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

  void _removeSuggestion(String suggestion) {
    setState(() {
      savedSuggestions.remove(suggestion);
    });
  }
}
