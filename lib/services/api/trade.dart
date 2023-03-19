import 'dart:convert';
import 'dart:developer';
import 'package:property_051/services/localstorage/SessionManager.dart';

import '../../app/model/trade/societymodel.dart';
import '../../app/model/trade/trademodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class TradeService {
  static Future<SocietyModel> getAllSocieties() async {
    var response = await getRequest('${ApiURLS.getTradingSocieties}');
    if (response.statusCode == 200) {
      return SocietyModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<TradeModel> getTodayTrade(int pageKey, String date) async {
    var response = await postRequest(
      '${ApiURLS.getTodayTrades}?page=$pageKey',
      body: {
        // 'today_file_trending_chat': date,
        'purpose_id': '1',
      },
    );
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return TradeModel.fromJson(properties);
    } else {
      throw Exception('Failed to load trades');
    }
  }

  static Future<TradeModel> getYesterdayTrade(int pageKey, String date) async {
    var response = await postRequest(
      '${ApiURLS.getTodayTrades}?page=$pageKey',
      body: {
        // 'today_file_trending_chat': date,
        'purpose_id': '2',
      },
    );
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return TradeModel.fromJson(properties);
    } else {
      throw Exception('Failed to load trades');
    }
  }

  static Future<TradeModel> getMyTrade(int pageKey) async {
    var response = await postRequest(
      '${ApiURLS.getMyTrades}?page=$pageKey',
      body: {
        'customer_id': '${SessionManager().userID}',
      },
    );
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return TradeModel.fromJson(properties);
    } else {
      throw Exception('Failed to load trades');
    }
  }

  static Future<TradeModel> getSocietyTrade(
    int pageKey,
    String societyID, {
    String? purposeID = '',
    String? blockID = '',
    String? sizeID = '',
    String? boookingID = '',
  }) async {
    var response = await getRequest(
        '${ApiURLS.getSocietyTrades}/$societyID?page=$pageKey&purpose_id=$purposeID&society_block=$blockID&society_size=$sizeID&booking_type=$boookingID');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return TradeModel.fromJson(properties);
    } else {
      throw Exception('Failed to load trades');
    }
  }

  static Future<TradeModel> getPersonTrade(
    int pageKey,
    String personID, {
    String? purposeID = '',
    String? blockID = '',
    String? sizeID = '',
    String? boookingID = '',
  }) async {
    var response = await getRequest(
        '${ApiURLS.getPersonTrades}/$personID?page=$pageKey&purpose_id=$purposeID&society_block=$blockID&society_size=$sizeID&booking_type=$boookingID');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return TradeModel.fromJson(properties);
    } else {
      throw Exception('Failed to load trades');
    }
  }

  static Future<TradeModel> postTrade(
    String sid,
    String sizeid,
    String bid,
    String nof,
    String price,
    String desc, {
    String? purposeId,
    String? blockType,
    String? plotType,
    String? demandType,
    String? demandPrice,
    String? discountPrice,
    String? discountPercentage,
  }) async {
    var response = await postRequest(
      '${ApiURLS.addTrade}',
      body: {
        'purpose_id': purposeId,
        'file_trending_society_id': sid,
        'society_block_id': blockType,
        'trending_society_size_id': sizeid,
        'trending_booking_type_id': bid,
        'no_of_files': nof,
        'price': price,
        'description': desc,
        'plot_type': plotType,
        'demand_type': demandType,
        'demand_price': demandPrice,
        'discount_price': discountPrice,
        'discount_percent': discountPercentage,
        'customer_id': '${SessionManager().userID}',
      },
    );
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return TradeModel.fromJson(properties);
    } else {
      log(response.body);
      throw Exception('Failed to add trade');
    }
  }

  static Future<TradeModel> soldTrade(String id) async {
    var response = await postRequest(
      '${ApiURLS.soldTrade}',
      body: {
        'id': '$id',
        'status': '1',
      },
    );
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return TradeModel.fromJson(properties);
    } else {
      log(response.body);
      throw Exception('Failed to add trade');
    }
  }
}
