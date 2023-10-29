import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:name_bingo_app/constants/name_list.dart';
import 'package:name_bingo_app/history_screen.dart';
import 'package:name_bingo_app/home/home_screen_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_screen_view_model.g.dart';

@riverpod
final class HomeScreenViewModel extends _$HomeScreenViewModel {
  HomeScreenViewModel() {
    namesList = nameList;
  }

  @override
  HomeScreenState build() {
    return const HomeScreenState(
      select: '',
      selectedItem: 'ビンゴスタート!!',
      isActive: false,
    );
  }

  List<String> bingoList = [];
  List<String> namesList = [];

  Timer? _timer;

  void _updateSelectedItem() {
    final random = Random();
    int randomIndex = random.nextInt(namesList.length);
    state = state.copyWith(
      selectedItem: namesList[randomIndex],
    );
  }

  void bingo() async {
    if (namesList.isNotEmpty) {
      state = state.copyWith(
        select: '',
      );
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      } else {
        _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
          _updateSelectedItem();
        });
        state = state.copyWith(
          isActive: true,
        );
      }
      await Future.delayed(const Duration(seconds: 3));
      final random = Random();
      int index = random.nextInt(namesList.length);
      String selectedName = namesList[index];
      state = state.copyWith(
        select: selectedName,
        isActive: false,
      );
      namesList.removeAt(index);
      bingoList.add(selectedName);
      _timer?.cancel();
    }
  }

  void reset() {
    bingoList.clear();
    namesList = List.from(nameList);
    state = state.copyWith(
      select: '',
      selectedItem: 'ビンゴスタート!!',
    );
    _timer?.cancel();
    state = state.copyWith(isActive: false);
  }

  void onTapHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(
          bingoList: bingoList,
        ),
      ),
    );
  }
}
