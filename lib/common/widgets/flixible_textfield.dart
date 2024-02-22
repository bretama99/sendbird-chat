import 'package:flutter/material.dart';
import 'package:sendbirdchat/utils/constants/colors.dart';

class FlexibleTextField extends StatefulWidget {
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  final Widget? suffixIcon;
  final bool? passwordVisibility;
  final String? hintTxt;
  final String? Function(String?)? validator;

  const FlexibleTextField({
    super.key,
    required this.textInputAction,
    required this.keyboardType,
    required this.textEditingController,
    this.validator,
    this.suffixIcon,
    this.hintTxt,
    this.passwordVisibility,
  });

  @override
  State<FlexibleTextField> createState() => _FlexibleTextFieldState();
}

class _FlexibleTextFieldState extends State<FlexibleTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // obscuringCharacter: '*',
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.textEditingController,
      textInputAction: widget.textInputAction,
      // style: const TextStyle(color: Colors.black),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: widget.passwordVisibility ?? false,
      onChanged: (value) {
        setState(() {});
      },
      maxLines: null,
      decoration: InputDecoration(
        // label: Text(label),
        // contentPadding: EdgeInsets.zero,
        hintText: widget.hintTxt ?? "",
        hintStyle: Theme.of(context).textTheme.displaySmall,
        // filled: true,
        // border: InputBorder.none,

        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        // fillColor: AppColor.white,

        suffixIconColor: widget.textEditingController.text.isNotEmpty
            ? AppColor.primaryBtnColor
            : Theme.of(context).dividerColor,
        suffixIcon: widget.suffixIcon ?? const Text(''),
      ),
    );
  }
}
