import 'package:firebase_admob/firebase_admob.dart';

class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService() => _instance;
  MobileAdTargetingInfo _targetingInfo;
  AdvertService._internal() {
    _targetingInfo = MobileAdTargetingInfo();
  }

  showBanner() {
    BannerAd banner = BannerAd(
        adUnitId: "ca-app-pub-4637731036519015/4506430459",
        size: AdSize.fullBanner,
        targetingInfo: _targetingInfo);
    banner
      ..load()
      ..show();
    banner.dispose();
  }

  showIntersitial() {
    InterstitialAd interstitialAd = InterstitialAd(
        adUnitId: "ca-app-pub-4637731036519015/9596773906",
        targetingInfo: _targetingInfo);
    interstitialAd
      ..load()
      ..show();
    interstitialAd.dispose();
  }
}
