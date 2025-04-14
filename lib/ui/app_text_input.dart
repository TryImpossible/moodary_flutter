import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moodary_flutter/config/resources/resources.dart';

/// 验证码输入完成Function
/// value 输入值
/// bool 返回值 true---验证成功 false---验证失败
typedef Validator = Future<bool> Function(String value);

class AppTextFieldValidator {
  AppTextFieldValidator({required this.validator, required this.errorText});

  final Validator validator;
  final String errorText;
}

enum AppTextFieldTriggerValidatorType {
  /// 出现焦点
  focus,

  /// 失去焦点
  unfocus,
}

enum AppTextFieldBorderType {
  /// 无边框
  none,

  ///下划线
  underline,

  ///外边框
  outline;

  bool get isNone => this == none;

  bool get isUnderline => this == underline;

  bool get isOutline => this == outline;
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled,
    this.prefixText,
    this.prefixTextStyle,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.errorTextStyle,
    this.showLeading = false,
    this.leading,
    this.trailing,
    this.showEye = true,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 14),
    this.validator,
    this.triggerValidatorType = AppTextFieldTriggerValidatorType.unfocus,
    this.borderType = AppTextFieldBorderType.underline,
    this.constraints,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final int? maxLines;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;

  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final TextStyle? errorTextStyle;

  final bool showLeading;
  final Widget? leading;
  final Widget? trailing;

  final bool showEye;
  final EdgeInsets? contentPadding;
  final List<AppTextFieldValidator>? validator;
  final AppTextFieldTriggerValidatorType triggerValidatorType;
  final AppTextFieldBorderType borderType;

  final BoxConstraints? constraints;

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  bool _isShowClear = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late bool _isSecured = true;
  String? _errorText;

  TextStyle get _prefixTextStyle =>
      widget.prefixTextStyle ??
      TextStyle(
        fontSize: context.dimen.textBig,
        color: context.color.primaryText,
      );

  TextStyle? get _hintStyle =>
      widget.hintStyle ??
      TextStyle(
        fontSize: context.dimen.textBig,
        color: context.color.inputHintText,
      );

  TextStyle? get _errorTextStyle =>
      widget.errorTextStyle ??
      TextStyle(fontSize: 12, color: context.color.error);

  BorderRadius get _inputBorderRadius => widget.borderType.isNone
      ? BorderRadius.zero
      : (widget.borderType.isUnderline
          ? const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            )
          : const BorderRadius.all(Radius.circular(4.0)));

  InputBorder get _border => widget.borderType.isNone
      ? InputBorder.none
      : (widget.borderType.isUnderline
          ? UnderlineInputBorder(
              borderRadius: _inputBorderRadius,
              borderSide: BorderSide(
                color: context.color.inputBorder,
                width: context.dimen.borderSmall,
              ),
            )
          : OutlineInputBorder(
              borderRadius: _inputBorderRadius,
              borderSide:
                  BorderSide(color: context.color.inputBorder, width: 0.5),
            ));

  InputBorder get _focusedBorder => widget.borderType.isNone
      ? InputBorder.none
      : (widget.borderType.isUnderline
          ? UnderlineInputBorder(
              borderRadius: _inputBorderRadius,
              borderSide: BorderSide(color: context.color.inputFocusedBorder),
            )
          : OutlineInputBorder(
              borderRadius: _inputBorderRadius,
              borderSide: BorderSide(color: context.color.inputFocusedBorder),
            ));

  InputBorder get _errorBorder => widget.borderType.isNone
      ? InputBorder.none
      : (widget.borderType.isUnderline
          ? UnderlineInputBorder(
              borderRadius: _inputBorderRadius,
              borderSide: BorderSide(color: context.color.inputErrorBorder),
            )
          : OutlineInputBorder(
              borderRadius: _inputBorderRadius,
              borderSide: BorderSide(color: context.color.inputErrorBorder),
            ));

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller = widget.controller ?? TextEditingController();
    if (widget.triggerValidatorType == AppTextFieldTriggerValidatorType.focus) {
      _controller.addListener(() {
        _checkValidator();
      });
    }
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.autofocus) {
      WidgetsFlutterBinding.ensureInitialized()
          .addPostFrameCallback((timeStamp) {
        _focusNode.requestFocus();
      });
    }

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (widget.triggerValidatorType ==
            AppTextFieldTriggerValidatorType.unfocus) {
          _checkValidator();
        }
        setState(() {
          _isShowClear = false;
        });
      } else {
        setState(() {
          _isShowClear = _controller.text.isNotEmpty;
          _errorText = null;
        });
      }
    });
    _isSecured = widget.obscureText;
    _controller.addListener(() {
      setState(() {
        _isShowClear = _focusNode.hasFocus && _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller = widget.controller ?? _controller;
    _focusNode = widget.focusNode ?? _focusNode;

    /// 外部传递的错误提示
    _errorText = widget.errorText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.textStyle,
      textAlign: widget.textAlign,
      readOnly: widget.readOnly,
      autofocus: false,
      obscureText: _isSecured,
      maxLines: widget.maxLines,
      onChanged: _onChanged,
      onSubmitted: widget.onSubmitted,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: _hintStyle,
        errorText: _errorText,
        errorStyle: _errorTextStyle,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isCollapsed: true,
        isDense: true,
        contentPadding: widget.contentPadding,
        prefixIcon: _buildLeading(),
        prefixIconConstraints: const BoxConstraints(),
        suffixIcon: _buildTrailing(),
        suffixIconConstraints: const BoxConstraints(),
        filled: false,
        fillColor: context.color.background,
        errorBorder: _errorBorder,
        focusedBorder: _focusedBorder,
        focusedErrorBorder: _errorBorder,
        disabledBorder: _border,
        enabledBorder: _border,
        border: InputBorder.none,
        constraints: widget.constraints,
      ),
    );
  }

  Widget _buildLeading() {
    if (!widget.showLeading) {
      return const SizedBox.shrink();
    }
    if (widget.leading != null) {
      return widget.leading!;
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 106),
      child: Text(
        widget.prefixText ?? '',
        style: _prefixTextStyle,
      ),
    );
  }

  Widget _buildTrailing() {
    final List<Widget> children = <Widget>[];
    if (!widget.readOnly && _isShowClear) {
      children.add(GestureDetector(
        onTap: _clear,
        child: SizedBox(
          width: 36,
          height: 48,
          child: UnconstrainedBox(
            child: Image(
              image: context.image.ic_clear,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ));
    }

    if (!widget.readOnly && widget.obscureText) {
      children.add(GestureDetector(
        onTap: _changeSecureStatus,
        child: SizedBox(
          width: 36,
          height: 48,
          child: UnconstrainedBox(
            child: Visibility(
              visible: _isSecured,
              replacement: Image(
                image: context.image.ic_eye_open,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              child: Image(
                image: context.image.ic_eye_close,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ));
    }

    if (widget.trailing != null) {
      children.add(widget.trailing!);
    }
    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }

  /// 清除按钮
  void _clear() {
    _controller.clear();
    if (widget.onChanged != null) {
      widget.onChanged!('');
    }
    _isShowClear = false;
    setState(() {});
  }

  /// 改变安全输入状态
  void _changeSecureStatus() {
    _isSecured = !_isSecured;
    setState(() {});
  }

  /// 输入改变
  void _onChanged(String value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
    setState(() {
      _isShowClear = value.isNotEmpty;
    });
  }

  /// 验证输入
  Future<void> _checkValidator() async {
    for (int i = 0; i < (widget.validator?.length ?? 0); i++) {
      final AppTextFieldValidator item = widget.validator!.elementAt(i);
      final bool result = await item.validator.call(_controller.text);
      setState(() {
        _errorText = result ? null : item.errorText;
      });
      if (!result) {
        break;
      }
    }
  }
}
