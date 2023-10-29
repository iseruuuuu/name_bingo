import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
    required this.bingoList,
  });

  final List<String> bingoList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: bingoList.length,
        itemBuilder: (context, index) {
          if (bingoList.isNotEmpty) {
            return ListTile(
              leading: Text(
                '${index + 1}回目',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              trailing: Text(
                bingoList[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
