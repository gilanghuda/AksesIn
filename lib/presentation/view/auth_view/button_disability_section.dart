import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:aksesin/presentation/widget/button.dart';

class ButtonDisabilitySection extends StatefulWidget {
  final Function(List<String>) onSelectedOptionsChanged;

  const ButtonDisabilitySection({Key? key, required this.onSelectedOptionsChanged}) : super(key: key);

  @override
  _ButtonDisabilitySectionState createState() => _ButtonDisabilitySectionState();
}

class _ButtonDisabilitySectionState extends State<ButtonDisabilitySection> {
  final List<String> _selectedOptions = [];

  void _toggleOption(String option) {
    setState(() {
      _selectedOptions.clear(); 
      _selectedOptions.add(option); 
      widget.onSelectedOptionsChanged(_selectedOptions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _buildOptionButton('Tuna Netra'),
            _buildOptionButton('Tunarungu / Wicara'),
            _buildOptionButton('Keterbatasan Fisik'),
            _buildOptionButton('Pendamping'),
          ],
        ),
      ],
    );
  }

  Widget _buildOptionButton(String option) {
    final isSelected = _selectedOptions.contains(option);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor, 
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomButton(
        text: option,
        onPressed: () => _toggleOption(option),
        backgroundColor: isSelected ? AppColors.secondaryColor : AppColors.backgroundColor,
        textColor: isSelected ? AppColors.backgroundColor : AppColors.secondaryColor,
        borderRadius: 10,
        width: 150, 
      ),
    );
  }
}
