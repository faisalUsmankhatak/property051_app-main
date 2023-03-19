import 'dart:convert';
import '../../app/model/comment/commentmodel.dart';
import 'network/config.dart';
import 'network/network_utils.dart';

class CommentService {
  static Future<CommentModel> getComments(id) async {
    var response = await getRequest('${ApiURLS.getComments}/$id');
    if (response.statusCode == 200) {
      var properties = json.decode(response.body);
      return CommentModel.fromJson(properties);
    } else {
      throw Exception('Failed to load comments');
    }
  }

  static Future<bool> addComment({chatID, sendBy, recBy, comment}) async {
    var params = {
      'file_trending_chats_id': '$chatID',
      'send_by': '$sendBy',
      'received_by': '$recBy',
      'comment': '$comment',
    };
    var response =
        await postRequest('${ApiURLS.addComment}/$chatID', body: params);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
