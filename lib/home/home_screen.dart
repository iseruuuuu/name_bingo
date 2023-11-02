import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:name_bingo_app/home/home_screen_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  //TODO 効果音をつける

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeScreenViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          TextButton(
            onPressed: state.isActive
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
                                  ref
                                      .read(
                                          homeScreenViewModelProvider.notifier)
                                      .reset();
                                },
                              )
                            ],
                          );
                        });
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
          onPressed: state.isActive
              ? null
              : () {
                  ref
                      .read(homeScreenViewModelProvider.notifier)
                      .onTapHistory(context);
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
            state.select.isEmpty
                ? Text(
                    state.selectedItem,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    state.select,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: state.isActive
                  ? null
                  : () =>
                      ref.read(homeScreenViewModelProvider.notifier).bingo(),
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
