String? nameValidator(String? name) {
  if (name == null || name.trim().isEmpty) {
    return "Please enter your name";
  }
  return null;
}

String? emailValidator(String? email) {
  if (email == null || email.trim().isEmpty) {
    return "Please enter your email";
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
    return "Invalid email address";
  } else {
    return null;
  }
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.trim().isEmpty) {
    return "Please enter your phone number";
  }

  // إزالة المسافات
  phone = phone.trim();

  // يقبل رقم يبدأ بـ 0 أو +20 ويتأكد من الطول الصحيح
  final phoneRegex = RegExp(r'^(?:\+20|0)?1[0-9]{8,9}$');

  if (!phoneRegex.hasMatch(phone)) {
    return "Invalid phone number format";
  }

  return null;
}

String? validatePassword(String? password) {
  RegExp regex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
  if (password == null || password.trim().isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(password)) {
      return 'Enter valid password';
    } else {
      return null;
    }
  }
}
