//flutter
import 'package:flutter/material.dart';
//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider = ChangeNotifierProvider((ref) => ProfileModel());

class ProfileModel extends ChangeNotifier {}
