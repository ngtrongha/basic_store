import 'package:flutter/material.dart';

class NumericKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback? onBackspace;
  final VoidCallback? onEnter;
  final String? initialValue;

  const NumericKeypad({
    super.key,
    required this.onKeyPressed,
    this.onBackspace,
    this.onEnter,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Display current value
          if (initialValue != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                initialValue!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          // Keypad grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                _buildKey('1', onKeyPressed),
                _buildKey('2', onKeyPressed),
                _buildKey('3', onKeyPressed),
                _buildKey('4', onKeyPressed),
                _buildKey('5', onKeyPressed),
                _buildKey('6', onKeyPressed),
                _buildKey('7', onKeyPressed),
                _buildKey('8', onKeyPressed),
                _buildKey('9', onKeyPressed),
                _buildKey('0', onKeyPressed),
                _buildKey('00', onKeyPressed),
                _buildKey('000', onKeyPressed),
              ],
            ),
          ),
          // Bottom row with backspace and enter
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onBackspace,
                  child: const Icon(Icons.backspace),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: onEnter,
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String text, Function(String) onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(text),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
