import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPostSection extends StatefulWidget {
  final Function(String) onCategorySelected;

  const SearchPostSection({super.key, required this.onCategorySelected});

  @override
  _SearchPostSectionState createState() => _SearchPostSectionState();
}

class _SearchPostSectionState extends State<SearchPostSection> {
  List<String> _selectedCategories = ['All'];
  List<String> _tempSelectedCategories = ['All']; 

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 90),
        Row(
          children: [
            Text('Komunitas',
            style : TextStyle(color: Colors.white, fontSize: 36),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Cari Postingan',
              prefixIcon: IconButton(
                icon: Icon(Icons.search_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.tune_rounded),
                onPressed: () {
                  _showFilterDialog(context);
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _showFilterDialog(BuildContext context) {
    _tempSelectedCategories = List.from(_selectedCategories); // Copy current selection
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0), 
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text('Batal'),
                onPressed: () {
                  context.pop();
                },
              ),
              Text('Filter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                child: Text('Terapkan'),
                onPressed: () {
                  setState(() {
                    _selectedCategories = List.from(_tempSelectedCategories);
                  });
                  widget.onCategorySelected(_selectedCategories.join(', '));
                  context.pop();
                },
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kategori'),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  FilterChip(
                    label: Text('Semua'),
                    selected: _tempSelectedCategories.contains('All'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          _tempSelectedCategories = ['All'];
                        } else {
                          _tempSelectedCategories.remove('All');
                        }
                      });
                    },
                  ),
                  FilterChip(
                    label: Text('Tuna Netra'),
                    selected: _tempSelectedCategories.contains('Tuna Netra'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          _tempSelectedCategories.add('Tuna Netra');
                        } else {
                          _tempSelectedCategories.remove('Tuna Netra');
                        }
                      });
                    },
                  ),
                  FilterChip(
                    label: Text('Tunarungu / Wicara'),
                    selected: _tempSelectedCategories.contains('Tunarungu / Wicara'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          _tempSelectedCategories.add('Tunarungu / Wicara');
                        } else {
                          _tempSelectedCategories.remove('Tunarungu / Wicara');
                        }
                      });
                    },
                  ),
                  FilterChip(
                    label: Text('Keterbatasan Fisik'),
                    selected: _tempSelectedCategories.contains('Keterbatasan Fisik'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          _tempSelectedCategories.add('Keterbatasan Fisik');
                        } else {
                          _tempSelectedCategories.remove('Keterbatasan Fisik');
                        }
                      });
                    },
                  ),
                  FilterChip(
                    label: Text('Pendamping'),
                    selected: _tempSelectedCategories.contains('Pendamping'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          _tempSelectedCategories.add('Pendamping');
                        } else {
                          _tempSelectedCategories.remove('Pendamping');
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
