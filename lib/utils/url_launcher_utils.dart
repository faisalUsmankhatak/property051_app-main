import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> launchWebUrl(String url) async {
    final Uri _url = Uri.parse('$url');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  static Future<void> launchEmailUrl(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Hello!'},
    );
    if (!await launchUrl(_emailLaunchUri)) {
      throw 'Could not launch $_emailLaunchUri';
    }
  }

  static Future<void> launchPhoneUrl(String phone) async {
    final Uri _phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (!await launchUrl(_phoneLaunchUri)) {
      throw 'Could not launch $_phoneLaunchUri';
    }
  }

  static Future<void> launchWhatsapp(String phone, {String? text}) async {
    var whatsapp = "$phone";
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=$text");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      log('dhj');
    }
  }
}
