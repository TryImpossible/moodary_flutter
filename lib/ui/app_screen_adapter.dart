import 'package:flutter/material.dart';

extension SizeExtensions on num {
  double get w => AppScreenAdapter.getWidth(this);

  double get h => AppScreenAdapter.getHeight(this);

  double get sp => AppScreenAdapter.getFontSize(this);

  double get sw => AppScreenAdapter.screenWidth * this;

  double get sh => AppScreenAdapter.screenHeight * this;

  double get dpr => AppScreenAdapter.devicePixelRatio;

  double get statusBar => AppScreenAdapter.statusBarHeight;

  double get bottomBar => AppScreenAdapter.bottomBarHeight;

  double get px => AppScreenAdapter.onePX * this;
}

class AppScreenAdapter extends StatelessWidget {
  AppScreenAdapter({
    super.key,
    Size designSize = DEFAULT_DESIGN_SIZE,
    required this.child,
  }) {
    _designSize = designSize;
  }

  final Widget child;

  /// 默认的UI设计稿尺寸, 基于iphone x
  // ignore: constant_identifier_names
  static const Size DEFAULT_DESIGN_SIZE = Size(375, 812);

  /// UI设计图的宽度
  static double get designWidth => _designSize.width;

  /// UI设计图的高度
  static double get designHeight => _designSize.height;

  /// UI设计稿高宽比，iphone 6高宽比为16：9
  static double get designAspectRatio => _designSize.width / _designSize.height;

  /// UI设计图的尺寸
  static Size get designSize => _designSize;
  static late Size _designSize;

  /// 屏幕方向
  static Orientation get orientation => _orientation;
  static late Orientation _orientation;

  /// 设备的像素密度
  /// The size of the media in logical pixels (e.g, the size of the screen).
  static double get devicePixelRatio => _devicePixelRatio;
  static late double _devicePixelRatio;

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  /// The number of font pixels for each logical pixel.
  static double get textScaleFactor => _textScaleFactor;
  static late double _textScaleFactor;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  static double get screenWidth => _screenWidth;
  static late double _screenWidth;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  static double get screenHeight => _screenHeight;
  static late double _screenHeight;

  /// 当前设备宽度 px
  /// The vertical extent of this size. px
  static double get screenWidthPx => _screenWidth * _devicePixelRatio;

  /// 当前设备高度 px
  /// The vertical extent of this size. px
  static double get screenHeightPx => _screenHeight * _devicePixelRatio;

  /// 状态栏高度 dp 刘海屏会更高
  /// The offset from the top
  static double get statusBarHeight => _statusBarHeight;
  static late double _statusBarHeight;

  /// 底部安全区距离 dp
  /// The offset from the bottom.
  static double get bottomBarHeight => _bottomBarHeight;
  static late double _bottomBarHeight;

  /// 实际的dp与UI设计px的比例
  /// The ratio of the actual dp to the design draft px
  static double get scaleWidthRatio => _screenWidth / designWidth;

  static double get scaleHeightRatio => _screenHeight / designHeight;

  // static double get scaleTextRatio => min(scaleWidthRatio, scaleHeightRatio);
  static double get scaleTextRatio => scaleWidthRatio;

  static double get onePX => 1 / _devicePixelRatio;

  /// 根据UI设计的设备宽度适配
  /// 高度也可以根据这个来做适配可以保证不变形,比如你先要一个正方形的时候.
  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  static double getWidth(num width) => width * scaleWidthRatio;

  /// 根据UI设计的设备高度适配
  /// 当发现UI设计中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,建议使用此方法实现高度适配.
  /// 高度适配主要针对想根据UI设计的一屏展示一样的效果
  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  static double getHeight(num height) => height * scaleHeightRatio;

  ///字体大小适配方法
  ///@param [fontSize] UI设计上字体的大小
  ///Font size adaptation method
  ///@param [fontSize] The size of the font on the UI design
  ///@param [allowFontScaling]
  static double getFontSize(num fontSize) => fontSize * scaleTextRatio;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth > 0) {
          _orientation = MediaQuery.orientationOf(context);
          _devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
          _screenWidth = MediaQuery.sizeOf(context).width;
          _screenHeight = MediaQuery.sizeOf(context).height;
          _statusBarHeight = MediaQuery.viewPaddingOf(context).top;
          _bottomBarHeight = MediaQuery.viewPaddingOf(context).bottom;
          _textScaleFactor = MediaQuery.textScalerOf(context).textScaleFactor;
          return child;
        }
        return const SizedBox.shrink();
      },
    );
  }
}
