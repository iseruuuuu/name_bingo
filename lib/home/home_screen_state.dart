import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_state.freezed.dart';
part 'home_screen_state.g.dart';

@freezed
abstract class HomeScreenState with _$HomeScreenState {
  const factory HomeScreenState({
    required String selectedItem,
    required String select,
    required bool isActive,
  }) = _HomeScreenState;

  factory HomeScreenState.fromJson(Map<String, dynamic> json) =>
      _$HomeScreenStateFromJson(json);
}
