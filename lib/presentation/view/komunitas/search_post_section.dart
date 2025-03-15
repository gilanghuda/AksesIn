import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPostSection extends StatelessWidget {
  final Function(String) onCategorySelected;

  const SearchPostSection({super.key, required this.onCategorySelected});

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
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      onCategorySelected('All');
                      context.pop();
                    },
                  ),
                  FilterChip(
                    label: Text('Umum'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      onCategorySelected('Umum');
                      context.pop();
                    },
                  ),
                  FilterChip(
                    label: Text('Tunanetra'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      onCategorySelected('Tunanetra');
                      context.pop();
                    },
                  ),
                  FilterChip(
                    label: Text('Tunarungu / wicara'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      onCategorySelected('Tunarungu / wicara');
                      context.pop();
                    },
                  ),
                  FilterChip(
                    label: Text('Keterbatasan Fisik'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      onCategorySelected('Keterbatasan Fisik');
                      context.pop();
                    },
                  ),
                  FilterChip(
                    label: Text('Pendamping'),
                    selectedColor: Colors.blue,
                    onSelected: (bool value) {
                      onCategorySelected('Pendamping');
                      context.pop();
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
