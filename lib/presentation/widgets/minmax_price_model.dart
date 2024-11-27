// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_beresin/common/theme.dart';

enum CustomTextFieldType { underline, outline }

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String hintText;
  final Widget? prefix;
  final TextInputType keyboardType;
  final bool isCurrency;
  final TextEditingController controller;
  final VoidCallback? onCompleted;
  final void Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool? isPicker;
  final void Function()? pickerFunction;
  final bool? isPassword;
  final bool? isObscure;
  final Widget? rightIcon;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool? enableTooltip;
  final bool? enableError;
  final String? errorText;

  final CustomTextFieldType? textFieldType;

  const CustomTextField({
    super.key,
    // this.focusNode = FocusNode(),
    required this.labelText,
    required this.hintText,
    this.prefix,
    required this.keyboardType,
    this.isCurrency = false,
    required this.controller,
    this.onCompleted,
    this.onChanged,
    this.onTapOutside,
    this.isPicker = false,
    this.pickerFunction,
    this.isPassword = false,
    this.isObscure,
    this.rightIcon,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.style,
    this.hintStyle,
    this.errorText = "Can not be empty",
    this.enableTooltip = false,
    this.textFieldType = CustomTextFieldType.underline,
    this.enableError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText!.isNotEmpty
            ? Row(
                children: [
                  Text(
                    labelText!,
                    style: primaryTextStyle.copyWith(
                      fontSize: 14,
                      color: blackTextColor,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  enableTooltip!
                      ? Tooltip(
                          exitDuration: const Duration(seconds: 2),
                          textStyle: primaryTextStyle.copyWith(
                            fontSize: 12,
                            color: alternativeWhiteTextColor,
                          ),
                          triggerMode: TooltipTriggerMode.tap,
                          message:
                              "Password must:\n- Be between 9 and 64 character\n- At least 1 number\n- At least 1 uppercase character",
                          child: Icon(
                            Icons.info_outline,
                            size: 14,
                            color: primaryColor,
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            : const SizedBox(
                height: 0,
              ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: textFieldType == CustomTextFieldType.underline
                ? Colors.transparent
                : Colors.white,
          ),
          child: TextField(
            focusNode: focusNode,
            onTapOutside: onTapOutside,
            onTap: isPicker! ? pickerFunction : null,
            inputFormatters: [
              isCurrency
                  ? CurrencyTextInputFormatter.simpleCurrency(
                      locale: 'id_ID',
                      decimalDigits: 0,
                    )
                  : TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue;
                    }),
            ],
            onEditingComplete: onCompleted,
            onChanged: onChanged,
            // onSubmitted: (value) {
            //   FocusManager.instance.primaryFocus?.unfocus();
            // },
            obscureText: isPassword! ? isObscure! : false,
            readOnly: isPicker!,
            keyboardType: keyboardType,
            controller: controller,
            style: style ??
                primaryTextStyle.copyWith(
                  fontSize: 14,
                ),
            textInputAction: textInputAction,
            decoration: InputDecoration(
              error: enableError! ? Text(errorText!) : null,
              errorBorder: enableError!
                  ? textFieldType == CustomTextFieldType.underline
                      ? const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        )
                      : const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        )
                  : null,
              hoverColor: Colors.red,
              contentPadding: textFieldType == CustomTextFieldType.underline
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
              hintText: hintText,
              hintStyle: hintStyle ??
                  primaryTextStyle.copyWith(
                    color: darkGrayColor,
                  ),
              enabledBorder: textFieldType == CustomTextFieldType.underline
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: darkGrayColor,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(
                        color: darkGrayColor,
                      ),
                    ),
              focusedBorder: textFieldType == CustomTextFieldType.underline
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: isPicker! ? darkGrayColor : primaryColor,
                      ),
                    )
                  : OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide(
                        color: isPicker! ? darkGrayColor : primaryColor,
                        width: isPicker! ? 1 : 2,
                      ),
                    ),
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 20,
                maxWidth: 50,
              ),
              prefixIcon: prefix,
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 20,
              ),
              suffix: isPassword! ? rightIcon : null,
            ),
          ),
        ),
      ],
    );
  }
}
