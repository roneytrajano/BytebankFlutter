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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        maxLength: 4,
        keyboardType: TextInputType.number,
        obscureText: true,
        textAlign: TextAlign.center,
        style: TextStyle(
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
            widget.onConfirm(_passwordController.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
