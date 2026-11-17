import 'package:estehlaky/core/constant/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpPin extends StatefulWidget {
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  const OtpPin({super.key, this.onCompleted, this.onChanged});

  @override
  State<OtpPin> createState() => _OtpPinState();
}

class _OtpPinState extends State<OtpPin> {
  static const int _otpLength = 5;
  static const double _spacing = 10;
  static const double _maxPinWidth = 56;

  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  String get _otpCode =>
      _controllers.map((controller) => controller.text).join();

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(_otpLength, (_) => TextEditingController());

    _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    } else if (index == _otpLength - 1 && value.isNotEmpty) {
      _focusNodes[index].unfocus();
    }

    final otp = _otpCode;

    widget.onChanged?.call(otp);

    if (otp.length == _otpLength) {
      widget.onCompleted?.call(otp);
    }

    setState(() {});
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        final pinWidth =
            ((availableWidth - (_spacing * (_otpLength - 1))) / _otpLength)
                .clamp(0.0, _maxPinWidth);

        final pinHeight = pinWidth * 1.12;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_otpLength, (index) {
              return Container(
                width: pinWidth,
                height: pinHeight,
                margin: EdgeInsets.only(
                  right: index == _otpLength - 1 ? 0 : _spacing,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    textInputAction: index == _otpLength - 1
                        ? TextInputAction.done
                        : TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    maxLength: 1,
                    style: AppStyles.style(
                      locale: locale,
                      fontSize: AppStyles.s20,
                      fontWeight: AppStyles.bold,
                      color: colors.onSurface,
                    ),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      _onOtpChanged(value, index);
                    },
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
