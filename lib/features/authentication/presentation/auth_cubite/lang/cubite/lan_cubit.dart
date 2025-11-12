import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanCubit extends Cubit<Locale> {
  LanCubit() : super(const Locale("en"));

  void toggleLanguage() {
    if (state.languageCode == "en") {
      emit(const Locale("ar"));
    } else {
      emit(const Locale("en"));
    }
  }
}
