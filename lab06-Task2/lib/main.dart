import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SavedSuggestions(
        suggestions: [
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
        ],
      ),
    );
  }
}

class SavedSuggestions extends StatefulWidget {
  final List<String> suggestions;

  const SavedSuggestions({Key? key, required this.suggestions})
      : super(key: key);

  @override
  State<SavedSuggestions> createState() => _SavedSuggestionsState();
}

class _SavedSuggestionsState extends State<SavedSuggestions> {
  late List<bool> _isSelected;
  late List<String> _selectedToDelete;

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(widget.suggestions.length, (_) => false);
    _selectedToDelete = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dawood Mehmood - 341706"),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              if (_isSelected.any((isSelected) => isSelected)) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Item(s)'),
                    content: const Text(
                        'Are you sure you want to delete the selected item(s)?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Add selected items to delete list
                          for (var i = 0; i < _isSelected.length; i++) {
                            if (_isSelected[i]) {
                              _selectedToDelete.add(widget.suggestions[i]);
                            }
                          }
                          // Remove selected items from suggestions list and update isSelected state
                          setState(() {
                            widget.suggestions.removeWhere((suggestion) =>
                                _selectedToDelete.contains(suggestion));
                            _isSelected = List.generate(
                                widget.suggestions.length, (_) => false);
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No Suggestion Selected'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: widget.suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.suggestions[index]),
            trailing: _isSelected[index]
                ? Icon(Icons.check, color: Colors.green)
                : SizedBox.shrink(),
            onTap: () {
              setState(() {
                _isSelected[index] = !_isSelected[index];
              });
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          height: 1,
          thickness: 0.5,
        ),
      ),
    );
  }
}
