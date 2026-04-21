import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

/// A custom phone number field that wraps the PhoneFormField from the phone_form_field package.
class CustomPhoneNumberField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool readOnly;
  final String? initialValue;
  final Function(PhoneNumber)? onChanged;
  final PhoneController? controller;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final bool isRequired;

  const CustomPhoneNumberField({
    super.key,
    this.label,
    this.hintText,
    this.readOnly = false,
    this.initialValue = AppConstants.defaultCountryDialCode,
    this.onChanged,
    this.controller,
    this.autofillHints,
    this.textInputAction,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    const borderRadius = 5.0;
    return PhoneFormField(
      controller: controller,
      initialValue: controller != null
          ? null
          : initialValue.isNullOrEmpty
          ? null
          : PhoneNumber.parse(initialValue!),
      validator: PhoneValidator.compose([
        if (isRequired) PhoneValidator.required(context),
        PhoneValidator.validMobile(context),
      ]),
      onChanged: (phoneNumber) => onChanged != null
          ? onChanged!(phoneNumber)
          : log('changed into $phoneNumber', name: 'CustomPhoneNumberField'),
      onTapOutside: (_) => context.hideKeyboard(),
      countryButtonStyle: const CountryButtonStyle(
        flagSize: 16,
        showFlag: false,
      ),
      shouldLimitLengthByCountry: true,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      countrySelectorNavigator: CountrySelectorNavigator.modalBottomSheet(
        favorites: [
          IsoCode.IN,
          IsoCode.SA,
          IsoCode.AE,
          IsoCode.CA,
          IsoCode.AU,
          IsoCode.US,
          IsoCode.QA,
          IsoCode.KW,
          IsoCode.OM,
          IsoCode.BH,
          IsoCode.GB,
          IsoCode.DE,
          IsoCode.SG,
          IsoCode.LK,
          IsoCode.IT,
          IsoCode.FR,
        ],
        noResultMessage: 'No country found with this name or dial code',
        searchBoxTextStyle: const TextStyle(fontWeight: FontWeight.w500),
        searchBoxDecoration: InputDecoration(
          labelText: 'Search Country',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey400),
            borderRadius: borderRadius.radiusBorder,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey400),
            borderRadius: borderRadius.radiusBorder,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey400),
            borderRadius: borderRadius.radiusBorder,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius.radiusBorder,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.redTomato),
            borderRadius: borderRadius.radiusBorder,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.redTomato),
            borderRadius: borderRadius.radiusBorder,
          ),
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: const TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      cursorColor: AppColors.grey600,
      style: TextStyle(color: AppColors.grey600, fontWeight: FontWeight.w500),
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: borderRadius.radiusBorder,
          borderSide: BorderSide(color: AppColors.grey400),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey400),
          borderRadius: borderRadius.radiusBorder,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey400),
          borderRadius: borderRadius.radiusBorder,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius.radiusBorder,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.redTomato),
          borderRadius: borderRadius.radiusBorder,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.redTomato),
          borderRadius: borderRadius.radiusBorder,
        ),
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
        labelStyle: const TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
