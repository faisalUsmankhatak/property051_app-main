// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../app/model/phone/region.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class IntlPhoneField extends StatelessWidget {
  TextEditingController? numberCtrl;
  String? hintText;
  Region? region;
  Function()? chooseRegions;
  FocusNode? focusNode;
  bool? autoFocus;
  Function(String)? onNumberChange;
  IntlPhoneField({
    this.numberCtrl,
    this.hintText = 'Phone Number',
    this.region,
    this.chooseRegions,
    this.focusNode,
    this.autoFocus = false,
    this.onNumberChange,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: chooseRegions,
            child: Container(
              height: 45,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, right: 10, top: 3),
              child: Text(
                region != null
                    ? '${region!.code} +${region!.prefix}'
                    : 'Choose Region',
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            width: 0.5,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Container(
              height: 45,
              child: TextField(
                controller: numberCtrl,
                autocorrect: false,
                enableSuggestions: false,
                focusNode: focusNode,
                autofocus: autoFocus!,
                keyboardType: TextInputType.phone,
                onChanged: onNumberChange,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
                  hintStyle: TextStyle(
                    color: AppColor.greyColor,
                    fontSize: 14,
                    fontFamily: AppFonts.mulishFont,
                  ),
                ),
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14,
                  fontFamily: AppFonts.mulishFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:property_051/utils/phoneutil.dart';
import '../../../utils/global.dart';
import '../../app/model/phone/parse_result.dart';
import '../../app/model/phone/region.dart';
import '../../utils/colors.dart';
import '../../utils/fonts.dart';
import 'regionpicker.dart';

parse '17449106505' (MX)
parse list "+48606723456", "+48774843312"
format '+47234723432', 'BR'

class IntlPhoneField extends StatefulWidget {
  final PhoneUtil phoneUtil = PhoneUtil();
  TextEditingController? numberCtrl;
  IntlPhoneField({Key? key, this.numberCtrl}) : super(key: key);

  @override
  IntlPhoneFieldState createState() => IntlPhoneFieldState();
}

class IntlPhoneFieldState extends State<IntlPhoneField>
    with AutomaticKeepAliveClientMixin {
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchDevicesRegionCode();
  }

  Region? region;
  ParseResult? result;

  bool get hasResult => result != null;
  String? devicesRegionCode = 'PK';

  Future<void> parse() async {
    setState(() => result = null);
    result =
        await widget.phoneUtil.parse(widget.numberCtrl!.text, region: region);
    log('Parse Result: $result');
    setState(() {});
  }

  Future<void> format() async {
    final formatted =
        await widget.phoneUtil.format(widget.numberCtrl!.text, region!);
    if (formatted != null) {
      // widget.numberCtrl.text = formatted;
      widget.numberCtrl!.value = widget.numberCtrl!.value.copyWith(
        text: formatted,
        selection: TextSelection(
            baseOffset: formatted.length, extentOffset: formatted.length),
        composing: TextRange.empty,
      );
      setState(() {});
    }
  }

  Future<void> fetchDevicesRegionCode() async {
    final code = await widget.phoneUtil.carrierRegionCode();
    region = await widget.phoneUtil.getRegion(code!);
    setState(
      () {
        devicesRegionCode = code;
        region = region;
      },
    );
  }

  Future<void> chooseRegions() async {
    dismissKeyboard(context);
    final regions = await widget.phoneUtil.getRegions();
    final selectedRegion = await Get.to(
      () => RegionPicker(regions: regions),
      fullscreenDialog: true,
    );
    if (selectedRegion != null) {
      log('Region selected: $selectedRegion');
      setState(() => region = selectedRegion);
    }
  }

  Future<void> validate() async {
    final isValid = await widget.phoneUtil.validate(
      widget.numberCtrl!.text,
      region: region,
    );
    log('isValid : $isValid');
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: chooseRegions,
            child: Container(
              height: 45,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, right: 10, top: 3),
              child: Text(
                region != null
                    ? '${region!.code} +${region!.prefix}'
                    : 'Choose Region',
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            width: 0.5,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Container(
              height: 45,
              child: TextField(
                controller: widget.numberCtrl,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.phone,
                onChanged: (t) {
                  format();
                  parse();
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  contentPadding: EdgeInsets.only(top: 0, left: 10, bottom: 0),
                  hintStyle: TextStyle(
                    color: AppColor.greyColor,
                    fontSize: 14,
                    fontFamily: AppFonts.mulishFont,
                  ),
                ),
                style: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 14,
                  fontFamily: AppFonts.mulishFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/