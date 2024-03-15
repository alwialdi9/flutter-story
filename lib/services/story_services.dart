part of 'services.dart';

// ignore: non_constant_identifier_names
String SERVICE = 'story_service';

class StoryServices {
  static Future<ApiReturnValue<List<Story>>> getAllStories(int? page, int? size, bool? location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final header = {'Content-Type': 'application/json', 'Authorization' : 'Bearer ${prefs.getString('token')}'};
      final response = await http.get(Uri.parse("${Apis.getAllStories}?page=$page&size=$size&location=$location"), headers: header);

      var error = jsonDecode(response.body)['error'] ?? true;
      var message = jsonDecode(response.body)['message'] ?? 'Error when fetch data';

      if (response.statusCode == 200) {
        log("[${DateTime.now()}] $message PAGE $page", name: SERVICE);
        var result = jsonDecode(response.body)['listStory'];
        var parsing = result.map((json) => Story.fromJson(json)).toList();
        return ApiReturnValue(value: List.from(parsing), error: error, message: message);
      }else{
        log("[${DateTime.now()}] $message", error: "There is error fetch story", name: SERVICE);
        return ApiReturnValue(message: 'Internal Server Error', error: true);
      }

    } catch (e) {
      log("[${DateTime.now()}] $e", error: "There is error fetch story", name: SERVICE);
      return ApiReturnValue(
          message: "There is Error when fetch story", error: true);
    }
  }
}