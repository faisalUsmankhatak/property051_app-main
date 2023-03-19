// // ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last

// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import '../../app/model/property/propertymodel.dart';
// import '../../components/cards/propertycard.dart';
// import '../../components/cards/tradecard.dart';
// import '../../routes/approutes.dart';
// import '../../utils/colors.dart';
// import '../../utils/fonts.dart';
// import '../dashboard/dashboardcontroller.dart';

// class DashboardView extends StatelessWidget {
//   var dashBoardViewModel = Get.put(DashBoardViewModel());

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: DefaultTabController(
//         length: 2,
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColor.backgroundColor,
//           ),
//           child: SafeArea(
//             child: Scaffold(
//               backgroundColor: AppColor.backgroundColor,
//               appBar: AppBar(
//                 toolbarHeight: Platform.isAndroid ? 6 : 0,
//                 elevation: 0.5,
//                 bottom: TabBar(
//                   tabs: const [
//                     Tab(
//                       child: Text("Property"),
//                     ),
//                     Tab(
//                       child: Text("Trading"),
//                     ),
//                   ],
//                   controller: dashBoardViewModel.tabController,
//                   onTap: (tabIndex) {},
//                 ),
//               ),
//               body: TabBarView(
//                 controller: dashBoardViewModel.tabController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   Container(
//                     child: Column(
//                       children: [
//                         propertyFilterComponent(context),
//                         propertiesModule(),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     color: AppColor.backgroundColor,
//                     child: Column(
//                       children: [
//                         tradeFilterComponent(context),
//                         tradeModule(),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

  // propertiesModule() {
  //   return Expanded(
  //     child: Container(
  //       color: AppColor.whiteColor,
  //       child: PagedListView<int, PropertiesData>.separated(
  //         padding: EdgeInsets.only(top: 0),
  //         shrinkWrap: true,
  //         pagingController: dashBoardViewModel.propertyPagingController,
  //         builderDelegate: PagedChildBuilderDelegate<PropertiesData>(
  //           itemBuilder: (context, item, index) {
  //             return PropertyCard(
  //               property: item,
  //               onTap: () {
  //                 Get.toNamed(AppRoutes.propertyDetail, arguments: item);
  //               },
  //             );
  //           },
  //           firstPageErrorIndicatorBuilder: (context) {
  //             return const Center(
  //               child: Text("No Properties"),
  //             );
  //           },
  //           firstPageProgressIndicatorBuilder: (context) {
  //             return Container(
  //               height: Get.height -
  //                   AppBar().preferredSize.height -
  //                   kBottomNavigationBarHeight -
  //                   40,
  //               child: const Center(
  //                 child: SpinKitFadingCircle(
  //                   color: AppColor.blackColor,
  //                   size: 50.0,
  //                 ),
  //               ),
  //             );
  //           },
  //           newPageProgressIndicatorBuilder: (context) {
  //             return const Center(
  //               child: SpinKitFadingCircle(
  //                 color: AppColor.blackColor,
  //                 size: 50.0,
  //               ),
  //             );
  //           },
  //         ),
  //         separatorBuilder: (context, index) {
  //           return Container(height: 16);
  //         },
  //       ),
  //     ),
  //   );
  // }

//   tradeModule() {
//     return Expanded(
//       child: Container(
//         color: AppColor.whiteColor,
//         child: PagedListView<int, PropertiesData>.separated(
//           padding: EdgeInsets.only(top: 8),
//           shrinkWrap: true,
//           pagingController: dashBoardViewModel.propertyPagingController,
//           builderDelegate: PagedChildBuilderDelegate<PropertiesData>(
//             itemBuilder: (context, item, index) {
//               return TradeCard();
//             },
//             firstPageErrorIndicatorBuilder: (context) {
//               return const Center(
//                 child: Text("No Properties"),
//               );
//             },
//             firstPageProgressIndicatorBuilder: (context) {
//               return Container(
//                 height: Get.height -
//                     AppBar().preferredSize.height -
//                     kBottomNavigationBarHeight -
//                     40,
//                 child: const Center(
//                   child: SpinKitFadingCircle(
//                     color: AppColor.blackColor,
//                     size: 50.0,
//                   ),
//                 ),
//               );
//             },
//             newPageProgressIndicatorBuilder: (context) {
//               return const Center(
//                 child: SpinKitFadingCircle(
//                   color: AppColor.blackColor,
//                   size: 50.0,
//                 ),
//               );
//             },
//           ),
//           separatorBuilder: (context, index) {
//             return Divider(
//               height: 18,
//               color: AppColor.greyColor,
//             );
//           },
//         ),
//       ),
//     );
//   }

//   propertyFilterComponent(context) {
//     return Container(
//       height: 43,
//       decoration: BoxDecoration(
//         color: AppColor.backgroundColor,
//         border: Border(
//           bottom: BorderSide(
//             color: AppColor.greyColor.withOpacity(0.2),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             padding: const EdgeInsets.only(),
//             width: Get.width / 3.3,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               color: AppColor.backgroundColor,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(Icons.tune_outlined, size: 20),
//                 SizedBox(width: 4),
//                 Text(
//                   'Filter',
//                   style: TextStyle(
//                     fontSize: 15,
//                     // fontWeight: FontWeight.w700,
//                     fontFamily: AppFonts.mulishFont,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: double.infinity,
//             width: 1,
//             color: AppColor.greyColor.withOpacity(0.2),
//           ),
//           Expanded(
//             child: Obx(
//               () => Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     dashBoardViewModel.properties.value.data != null
//                         ? '${dashBoardViewModel.properties.value.data!.properties!.total!}0+ Results'
//                         : '0 Results',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: double.infinity,
//             width: 1,
//             color: AppColor.greyColor.withOpacity(0.2),
//           ),
//           GestureDetector(
//             onTap: () {
//               sortActtionSheet(context);
//             },
//             child: Container(
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.only(),
//               width: Get.width / 3.3,
//               height: double.infinity,
//               decoration: BoxDecoration(
//                 color: AppColor.backgroundColor,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Text(
//                     'Sort By',
//                     style: TextStyle(
//                       fontSize: 15,
//                       // fontWeight: FontWeight.w700,
//                       fontFamily: AppFonts.mulishFont,
//                     ),
//                   ),
//                   SizedBox(width: 4),
//                   Icon(Icons.arrow_downward_outlined, size: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   tradeFilterComponent(context) {
//     return Container(
//       height: 43,
//       decoration: BoxDecoration(
//         color: AppColor.backgroundColor,
//         border: Border(
//           bottom: BorderSide(
//             color: AppColor.greyColor.withOpacity(0.2),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.only(),
//               height: double.infinity,
//               color: Color.fromARGB(255, 189, 187, 187).withOpacity(0.4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Expanded(
//                     child: Text(
//                       'Post Your Offer',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: AppFonts.mulishFont,
//                       ),
//                       maxLines: 1,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: double.infinity,
//             width: 1,
//             color: AppColor.greyColor.withOpacity(0.2),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.only(),
//               height: double.infinity,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Text(
//                     '1000+ Results',
//                     style: TextStyle(
//                       fontSize: 15,
//                       // fontWeight: FontWeight.w700,
//                       fontFamily: AppFonts.mulishFont,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: double.infinity,
//             width: 1,
//             color: AppColor.greyColor.withOpacity(0.2),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.only(),
//               height: double.infinity,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Icon(Icons.tune_outlined, size: 20),
//                   SizedBox(width: 4),
//                   Text(
//                     'Filter',
//                     style: TextStyle(
//                       fontSize: 15,
//                       // fontWeight: FontWeight.w700,
//                       fontFamily: AppFonts.mulishFont,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   sortActtionSheet(context) {
//     return showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) => CupertinoActionSheet(
//         title: const Text('Sort By'),
//         actions: <Widget>[
//           CupertinoActionSheetAction(
//             child: const Text('Relevance'),
//             onPressed: () {
//               Navigator.pop(context, 'Relevance');
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: const Text('Latest'),
//             onPressed: () {
//               Navigator.pop(context, 'Latest');
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: const Text('Oldest'),
//             onPressed: () {
//               Navigator.pop(context, 'Oldest');
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: const Text('Lowest Price'),
//             onPressed: () {
//               Navigator.pop(context, 'Lower Price');
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: const Text('Highest Price'),
//             onPressed: () {
//               Navigator.pop(context, 'Lower Price');
//             },
//           )
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: Text(
//             'Cancel',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           isDefaultAction: true,
//           onPressed: () {
//             Navigator.pop(context, 'Cancel');
//           },
//         ),
//       ),
//     );
//   }
// }
