import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  BannerAd? bannerAd;

  ///
  Future<InitializationStatus> initAdmob() async {
    return MobileAds.instance.initialize();
  }

  ///
  void initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );
  }

  ///
  void dispose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
  }

  ///
  void loadBannerAd() {
    bannerAd?.load();
  }

  //---------------------------------------

  InterstitialAd? interstitialAd;
  int maxFailedToAttempt = 3;
  int _numOfInterstitialLoadAttempt = 0;

  void initInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;

          _numOfInterstitialLoadAttempt = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;

          _numOfInterstitialLoadAttempt++;

          if (_numOfInterstitialLoadAttempt <= maxFailedToAttempt) {
            initInterstitialAd();
          }
        },
      ),
    );
  }

  ///
  void loadInterstitialAd() {
    _showInterstitialAd();
  }

  ///
  void _showInterstitialAd() {
    if (interstitialAd == null) {
      return;
    }

    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        initInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        initInterstitialAd();
      },
    );

    interstitialAd!.show();

    interstitialAd = null;
  }

  //---------------------------------------

  ///
  static String get appId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544~3347511713';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  ///
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  ///
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  ///
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

/*
ios
広告フォーマット	デモ広告ユニット ID
アプリ起動	ca-app-pub-3940256099942544/5662855259
バナー	ca-app-pub-3940256099942544/2934735716
インタースティシャル	ca-app-pub-3940256099942544/4411468910
インタースティシャル動画	ca-app-pub-3940256099942544/5135589807
リワード	ca-app-pub-3940256099942544/1712485313
リワード インタースティシャル	ca-app-pub-3940256099942544/6978759866
ネイティブ アドバンス	ca-app-pub-3940256099942544/3986624511
ネイティブ アドバンス動画	ca-app-pub-3940256099942544/2521693316


android
広告フォーマット	サンプル広告ユニット ID
アプリ起動	ca-app-pub-3940256099942544/3419835294
バナー	ca-app-pub-3940256099942544/6300978111
インタースティシャル	ca-app-pub-3940256099942544/1033173712
インタースティシャル動画	ca-app-pub-3940256099942544/8691691433
リワード	ca-app-pub-3940256099942544/5224354917
リワード インタースティシャル	ca-app-pub-3940256099942544/5354046379
ネイティブ アドバンス	ca-app-pub-3940256099942544/2247696110
ネイティブ アドバンス動画	ca-app-pub-3940256099942544/1044960115

*/
