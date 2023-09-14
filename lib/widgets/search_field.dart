import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;

  const SearchField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: borderRadius,
    );

    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          size: 23,
        ),
        suffixIcon: textEditingController.text.isNotEmpty
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              )
            : null,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(16),
      ),
      keyboardType: textInputType,
    );
  }
}
