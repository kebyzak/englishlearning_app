// ignore_for_file: depend_on_referenced_packages

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  factory User({
    required String uid,
    required String name,
    required String email,
  }) = _User;
}
