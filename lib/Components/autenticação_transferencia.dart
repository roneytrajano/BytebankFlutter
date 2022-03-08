// ignore_for_file: file_names

// ignore: file_names
import 'package:flutter/material.dart';

class AutenticacaoTransferencia extends StatefulWidget {
  final Function(String password) onConfirm;

  const AutenticacaoTransferencia({Key? key, required this.onConfirm}) : super(key: key);


  @override
  State<AutenticacaoTransferencia> createState() => _AutenticacaoTransferenciaState();
}

class _AutenticacaoTransferenciaState extends State<AutenticacaoTransferencia> {
  TextEditingController _passwordController = TextEditingController();

  bool _validate = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorText: _validate ? 'Value Can\'t Be Empty' : null,
        ),
        maxLength: 4,
        keyboardType: TextInputType.number,
        obscureText: true,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 64,
          letterSpacing: 24,

        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Confirm'),
          onPressed: () {
            setState(() {
              _passwordController.text.isEmpty ? _validate = true : _validate = false;
            });
            if(_validate == false) {
              widget.onConfirm(_passwordController.text);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
