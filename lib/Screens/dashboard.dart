import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                _FeatureItem(
                  'Transfer',
                  Icons.people,
                  '/transfer'
                ),
                _FeatureItem(
                  'Transaction feed',
                  Icons.description,
                    '/TransactionFeed'
                ),
                _FeatureItem(
                    'Exemplo',
                    Icons.description,
                    ''
                ),
                _FeatureItem(
                    'Exemplo',
                    Icons.description,
                    ''
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String _name;
  final IconData _icon;
  final String _page;

  const _FeatureItem(this._name, this._icon, this._page);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () {
            Get.toNamed(_page);
          },
          child: Container(
            color: Colors.green,
            height: 80,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    _icon,
                    color: Colors.white,
                  ),
                  Text(_name, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
