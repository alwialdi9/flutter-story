part of 'services.dart';

// ignore: non_constant_identifier_names
String SERVICE = 'story_service';

class StoryServices {
  static Future<ApiReturnValue<List<Story>>> getAllStories(
      int? page, int? size, bool? location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      };
      final response = await http.get(
          Uri.parse(
              "${Apis.getAllStories}?page=$page&size=$size&location=$location"),
          headers: header);
      log("Page: $page");

      var error = jsonDecode(response.body)['error'] ?? true;
      var message =
          jsonDecode(response.body)['message'] ?? 'Error when fetch data';

      if (response.statusCode == 200) {
        log("[${DateTime.now()}] $message PAGE $page", name: SERVICE);
        var result = jsonDecode(response.body)['listStory'];
        List<Story> parsing =
            result.map<Story>((json) => Story.fromJson(json)).toList();
        return ApiReturnValue(
            value: List.from(parsing), error: error, message: message);
      } else {
        log("[${DateTime.now()}] $message",
            error: "There is error fetch story", name: SERVICE);
        return ApiReturnValue(message: 'Internal Server Error', error: true);
      }
    } catch (e) {
      log("[${DateTime.now()}] $e",
          error: "There is error fetch story ygy", name: SERVICE);
      return ApiReturnValue(
          message: "There is Error when fetch story", error: true);
    }
  }

  static Future<ApiReturnValue> postImage(
      List<int> bytes, String fileName, String description, Map<String, double> location) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final uri = Uri.parse(Apis.postImage);
      var request = http.MultipartRequest('POST', uri);

      final multipartFile =
          http.MultipartFile.fromBytes("photo", bytes, filename: fileName);
      Map<String, String> fields = {"description": description, 'lat': location['latitude'].toString(), 'lon': location['longitude'].toString()};
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      };
      request.files.add(multipartFile);
      request.fields.addAll(fields);
      request.headers.addAll(headers);

      final http.StreamedResponse streamedResponse = await request.send();
      final int statusCode = streamedResponse.statusCode;

      final Uint8List responseList = await streamedResponse.stream.toBytes();
      final String responseData = String.fromCharCodes(responseList);

      var resp = json.decode(responseData);
      // var error = jsonDecode(response.body)['error'] ?? true;
      var message = resp['message'] ?? 'Error when fetch data';

      if (statusCode == 201) {
        final ApiReturnValue response =
            ApiReturnValue(error: resp['error'], message: resp['message']);
        return response;
      } else {
        log("[${DateTime.now()}] $message",
            error: "There is error fetch story", name: SERVICE);
        return ApiReturnValue(message: 'Internal Server Error', error: true);
      }
    } catch (e) {
      log("[${DateTime.now()}] $e",
          error: "There is error fetch story", name: SERVICE);
      return ApiReturnValue(
          message: "There is Error when fetch story", error: true);
    }
  }

  static Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }
}
