import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:name_bingo_app/constants/name_list.dart';
import 'package:name_bingo_app/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> bingoList = [];
  List<String> namesList = [];
  var select = '';

  late String selectedItem;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    namesList = nameList;
    selectedItem = 'ビンゴスタート!!';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateSelectedItem() {
    final random = Random();
    int randomIndex = random.nextInt(namesList.length);
    setState(() {
      selectedItem = namesList[randomIndex];
    });
  }

  void bingo() async {
    if (namesList.isNotEmpty) {
      select = '';
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      } else {
        _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
          _updateSelectedItem();
        });
      }
      await Future.delayed(const Duration(seconds: 3));
      final random = Random();
      int index = random.nextInt(namesList.length);
      String selectedName = namesList[index];
      select = selectedName;
      namesList.removeAt(index);
      bingoList.add(selectedName);
      _timer?.cancel();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          TextButton(
            onPressed: (_timer?.isActive ?? false)
                ? null
                : () {
                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                'ビンゴをリセット',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            content: const Text(
                              'ビンゴを最初からやり直しますか？',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            actions: [
                              GestureDetector(
                                child: const Text(
                                  'いいえ',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              GestureDetector(
                                child: const Text(
                                  'はい',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  bingoList.clear();
                                  namesList = List.from(nameList);
                                  select = '';
                                  selectedItem = 'ビンゴスタート!!';
                                  _timer?.cancel();
                                  setState(() {});
                                },
                              )
                            ],
                          );
                        });
                    setState(() {});
                  },
            child: const Text(
              'リセット',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
        leading: TextButton(
          onPressed: (_timer?.isActive ?? false)
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                        bingoList: bingoList,
                      ),
                    ),
                  );
                },
          child: const Text(
            '履歴',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Spacer(),
            select.isEmpty
                ? Text(
                    selectedItem,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    select,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: (_timer?.isActive ?? false) ? null : () => bingo(),
              child: const Text(
                'ビンゴ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
