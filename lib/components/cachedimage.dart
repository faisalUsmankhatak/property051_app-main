// ignore_for_file: unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

Widget commonCacheImageWidget(String url, double height,
    {double? width, BoxFit? fit}) {
  return CachedNetworkImage(
    placeholder: (context, st) {
      return const CupertinoActivityIndicator(
        radius: 18,
      );
    },
    imageUrl: '$url',
    height: height,
    width: width,
    fit: fit,
    errorWidget: (_, __, ___) {
      return Image.asset(
        'images/app/noPhoto.jpg',
        height: height,
        width: width,
        fit: BoxFit.cover,
      );
      // return Image.network(
      //   'https://www.property051.com/images/agency.jpg',
      // height: height,
      // width: width,
      // fit: BoxFit.cover,
      // );
    },
  );
}
