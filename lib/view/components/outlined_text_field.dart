import 'dart:async';

import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/view/components/separator.dart';

class OutlinedTextField extends StatefulWidget {
  final String labelText;
  final void Function(String) onEditing;
  final bool obscureText;
  final String initialText;
  const OutlinedTextField({
    super.key,
    required this.labelText,
    required this.onEditing,
    this.obscureText = false,
    this.initialText = "",
  });

  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  late final textController = TextEditingController(text: widget.initialText);
  Timer? updateUiTimer;

  @override
  void dispose() {
    updateUiTimer?.cancel();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.labelText,
                  style: const TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Separator(8),
                TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                  obscureText: widget.obscureText,
                  cursorHeight: 12,
                  style: const TextStyle(fontSize: 12),
                  controller: textController,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    updateUiTimer?.cancel();
                    updateUiTimer = Timer(
                      const Duration(milliseconds: 300),
                      () {
                        widget.onEditing(value);
                        setState(() {});
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          if (textController.text.isNotEmpty) ...[
            const Separator(16),
            const Icon(Icons.check_circle_outline_rounded, color: Colors.green),
          ],
        ],
      ),
    );
  }
}
