import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({required this.onSaved, super.key});

  final void Function(String?) onSaved;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final TextEditingController _textEditingController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autocorrect: true,
              onFieldSubmitted: (String value) {
                setState(() => _autovalidateMode = AutovalidateMode.disabled);

                if (_formKey.currentState!.validate()) {
                  widget.onSaved(_textEditingController.text);
                  Navigator.pop(context);
                }
              },
              onSaved: widget.onSaved,
              controller: _textEditingController,
              autovalidateMode: _autovalidateMode,
              validator: (value) {
                return value!.toLowerCase() == 'f' ||
                        value.toLowerCase() == 'b' ||
                        value.toLowerCase() == 'r' ||
                        value.toLowerCase() == 'l' ||
                        value.toLowerCase() == 'x' ||
                        value.toLowerCase() == 's'
                    ? null
                    : "Enter Valid Command";
              },
              decoration: InputDecoration(
                labelText: "Command",
                hintText: "Enter Command(f, b, r, l, s, x)",
                hintStyle: TextStyle(fontWeight: FontWeight.w500),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0XFF26A59A), width: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
