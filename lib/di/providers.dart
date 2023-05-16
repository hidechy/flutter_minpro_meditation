import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../models/ad_manager.dart';
import '../models/purchase_manager.dart';
import '../models/shared_prefs_repository.dart';
import '../models/sound_manager.dart';
import '../viewmodels/main_viewmodel.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels = [
  Provider<SharedPrefsRepository>(
    create: (context) => SharedPrefsRepository(),
  ),
  Provider<SoundManager>(
    create: (context) => SoundManager(),
  ),
  Provider<AdManager>(
    create: (context) => AdManager(),
  ),
  Provider<PurchaseManager>(
    create: (context) => PurchaseManager(),
  ),
];

List<SingleChildWidget> dependentModels = [];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<MainViewModel>(
    create: (context) => MainViewModel(
      sharedPrefsRepository: context.read<SharedPrefsRepository>(),
      soundManager: context.read<SoundManager>(),
      adManager: context.read<AdManager>(),
      purchaseManager: context.read<PurchaseManager>(),
    ),
  ),
];
