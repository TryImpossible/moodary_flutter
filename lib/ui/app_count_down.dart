import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

import 'app_touchable_opacity.dart';

class AppCountDown extends StatefulWidget {
  const AppCountDown({
    super.key,
    this.sendCodeText,
    this.sendCodeTextStyle,
    this.countdownCodeText,
    this.countdownCodeTextStyle,
    this.resendCodeText,
    this.resendCodeTextStyle,
    this.padding,
    this.decoration,
    this.countdown = 60,
    this.interval = 1,
    this.auto = false,
    this.enabled = true,
    required this.onRequest,
  });

  /// 发送验证码
  final String? sendCodeText;

  /// 发送验证码样式
  final TextStyle? sendCodeTextStyle;

  /// 重新获取验证码(60s)
  final String? countdownCodeText;

  /// 重新获取验证码(60s) 样式
  final TextStyle? countdownCodeTextStyle;

  /// 重新发送验证码
  final String? resendCodeText;

  /// 重新发送验证码样式
  final TextStyle? resendCodeTextStyle;

  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;
  final int countdown;
  final int interval;
  final bool auto;
  final bool enabled;

  final Future<bool> Function() onRequest;

  @override
  State<AppCountDown> createState() => _AppCountDownState();
}

class _AppCountDownState extends State<AppCountDown> {
  Timer? _timer;
  String _title = '';
  TextStyle _titleStyle = const TextStyle();
  int _countdown = 0;

  String get _sendCodeText => widget.sendCodeText ?? '发送验证码';

  TextStyle get _sendCodeTextStyle =>
      widget.sendCodeTextStyle ??
      TextStyle(
        fontSize: context.dimen.textSmall,
        color: context.color.primaryText,
      );

  String get _countdownText => widget.sendCodeText ?? '重新获取验证码（60s）';

  TextStyle get _countdownCodeTextStyle =>
      widget.countdownCodeTextStyle ??
      TextStyle(
        fontSize: context.dimen.textSmall,
        color: context.color.secondaryText,
      );

  String get _resendCodeText => widget.sendCodeText ?? '重新发送验证码';

  TextStyle get _resendCodeTextStyle =>
      widget.resendCodeTextStyle ??
      TextStyle(
        fontSize: context.dimen.textSmall,
        color: context.color.primaryText,
      );

  @override
  void initState() {
    super.initState();
    _title = _sendCodeText;
    _titleStyle = _titleStyle.merge(_sendCodeTextStyle);
    _countdown = widget.countdown;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.auto) {
        _requestCaptcha();
      }
    });
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTouchableOpacity(
      onTap: _requestCaptcha,
      child: Container(
        decoration: widget.decoration,
        padding: widget.padding,
        child: Text(_title, style: _titleStyle),
      ),
    );
  }

  void _safeSetState(VoidCallback callback) {
    if (mounted) {
      setState(callback);
    }
  }

  Future<void> _requestCaptcha() async {
    if (!widget.enabled || _countdown != widget.countdown) {
      return;
    }
    if (await widget.onRequest()) {
      _startTimer();
    }
  }

  void _startTimer() {
    _stopTimer();
    _safeSetState(() {
      _title = _countdownText.replaceAll(RegExp(r'(\d+)'), '$_countdown');
      _titleStyle = _titleStyle.merge(_countdownCodeTextStyle);
    });
    _timer = Timer.periodic(Duration(seconds: widget.interval), (Timer value) {
      if (_countdown > 0) {
        _safeSetState(() {
          _countdown--;
          _title = _countdownText.replaceAll(RegExp(r'(\d+)'), '$_countdown');
          _titleStyle = _titleStyle.merge(_countdownCodeTextStyle);
        });
      } else {
        _stopTimer();
        _safeSetState(() {
          _countdown = widget.countdown;
          _title = _resendCodeText;
          _titleStyle = _titleStyle.merge(_resendCodeTextStyle);
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
