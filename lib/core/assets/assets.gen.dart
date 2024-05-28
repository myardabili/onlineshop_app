/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/bag.svg
  SvgGenImage get bag => const SvgGenImage('assets/icons/bag.svg');

  /// File path: assets/icons/cart.svg
  SvgGenImage get cart => const SvgGenImage('assets/icons/cart.svg');

  /// File path: assets/icons/clock.svg
  SvgGenImage get clock => const SvgGenImage('assets/icons/clock.svg');

  /// File path: assets/icons/copy.svg
  SvgGenImage get copy => const SvgGenImage('assets/icons/copy.svg');

  /// File path: assets/icons/creditcard.svg
  SvgGenImage get creditcard =>
      const SvgGenImage('assets/icons/creditcard.svg');

  /// File path: assets/icons/email.svg
  SvgGenImage get email => const SvgGenImage('assets/icons/email.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/location.svg
  SvgGenImage get location => const SvgGenImage('assets/icons/location.svg');

  /// File path: assets/icons/notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/icons/notification.svg');

  /// File path: assets/icons/order.svg
  SvgGenImage get order => const SvgGenImage('assets/icons/order.svg');

  /// File path: assets/icons/password.svg
  SvgGenImage get password => const SvgGenImage('assets/icons/password.svg');

  /// File path: assets/icons/person.svg
  SvgGenImage get person => const SvgGenImage('assets/icons/person.svg');

  /// File path: assets/icons/routing.svg
  SvgGenImage get routing => const SvgGenImage('assets/icons/routing.svg');

  /// File path: assets/icons/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/search.svg');

  /// File path: assets/icons/shield-done.svg
  SvgGenImage get shieldDone =>
      const SvgGenImage('assets/icons/shield-done.svg');

  /// File path: assets/icons/user.svg
  SvgGenImage get user => const SvgGenImage('assets/icons/user.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        bag,
        cart,
        clock,
        copy,
        creditcard,
        email,
        home,
        location,
        notification,
        order,
        password,
        person,
        routing,
        search,
        shieldDone,
        user
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bag banner.png
  AssetGenImage get bagBanner =>
      const AssetGenImage('assets/images/bag banner.png');

  $AssetsImagesBanksGen get banks => const $AssetsImagesBanksGen();

  /// File path: assets/images/clothes banner.png
  AssetGenImage get clothesBanner =>
      const AssetGenImage('assets/images/clothes banner.png');

  /// File path: assets/images/electronics banner.png
  AssetGenImage get electronicsBanner =>
      const AssetGenImage('assets/images/electronics banner.png');

  /// File path: assets/images/flashsale.png
  AssetGenImage get flashsale =>
      const AssetGenImage('assets/images/flashsale.png');

  /// File path: assets/images/google.png
  AssetGenImage get google => const AssetGenImage('assets/images/google.png');

  /// File path: assets/images/oops.png
  AssetGenImage get oops => const AssetGenImage('assets/images/oops.png');

  /// File path: assets/images/process-order.png
  AssetGenImage get processOrder =>
      const AssetGenImage('assets/images/process-order.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        bagBanner,
        clothesBanner,
        electronicsBanner,
        flashsale,
        google,
        oops,
        processOrder
      ];
}

class $AssetsImagesBanksGen {
  const $AssetsImagesBanksGen();

  /// File path: assets/images/banks/BCA.png
  AssetGenImage get bca => const AssetGenImage('assets/images/banks/BCA.png');

  /// File path: assets/images/banks/BRI Direct Debit.png
  AssetGenImage get bRIDirectDebit =>
      const AssetGenImage('assets/images/banks/BRI Direct Debit.png');

  /// File path: assets/images/banks/Mandiri.png
  AssetGenImage get mandiri =>
      const AssetGenImage('assets/images/banks/Mandiri.png');

  /// List of all assets
  List<AssetGenImage> get values => [bca, bRIDirectDebit, mandiri];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
