import 'package:ezmoney/models/extension.dart';
import 'package:flutter/material.dart';

String? validateFirstName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your first name';
  }
  if (!value.isValidName) {
    return 'Enter a valid first name';
  }
  return null;
}

String? validateLastName(String? value) {
  if (value == "") {
    return 'Please enter your last name';
  }
  if (!value!.isValidName) {
    return 'Enter valid last name';
  }
  return null;
}

String? validateAddress(String? value) {
  if (value == "") {
    return 'Please enter your address';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == "") {
    return 'Please enter your phone number';
  }
  if (!value!.isValidPhone) {
    return 'Enter valid phone number';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == "") {
    return 'Please enter your email';
  }
  if (!value!.isValidEmail) {
    return 'Enter valid email';
  }
  return null;
}

String? validateUsername(String? value) {
  if (value == "") {
    return 'Please enter your username';
  }

  return null;
}

String? validatePassword(String? password) {
  if (password!.isEmpty) {
    return 'Please enter password';
  }
  return null;
}

String? validateConfirmPassword(
  String? value,
  TextEditingController passwordController,
  TextEditingController confirmPasswordController,
) {
  final password = passwordController.text;
  final confirmPassword = confirmPasswordController.text;

  if (value!.isEmpty) {
    return 'Please enter confirm password';
  }

  if (password != confirmPassword) {
    return 'Password is not the same';
  }

  return null;
}

String? validateField(String? value) {
  if (value!.isEmpty) {
    return 'Field empty. Please input information';
  }
  return null;
}
