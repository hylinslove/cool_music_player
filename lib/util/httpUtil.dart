import 'dart:io';
import 'dart:convert';

class HttpUtil {

  static  get(String url,{ String path, Map<String, String> param }) async {
    var httpClient = HttpClient();
    Map<String, dynamic> result;

    try {
      Uri uri;
      if (param!=null && param.length>0) {
        uri = new Uri.http(url, path, param);
      } else {
        uri = Uri.parse(url);
      }

      var request = await httpClient.getUrl(uri);
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var jsonString = await response.transform(utf8.decoder).join();
//        print(jsonString);

        result = json.decode(jsonString);

        result.putIfAbsent('msg',()=>"success");

      } else {
        print('error ${response.statusCode}');
        result = {'msg': '网络连接失败'};
      }
      return result;

    } catch (error) {
      print('error $error');
      result = {'msg': 'error: $error'};
      return result;
    }
  }

  static  post(String url,{ Map<String, String> param }) async {
    var httpClient = HttpClient();
    Map<String, dynamic> result;

    try {
      var request = await httpClient.postUrl(Uri.parse(url));
      var response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        var jsonString = await response.transform(utf8.decoder).join();
//        print(jsonString);

        result = json.decode(jsonString);

        result.putIfAbsent('msg',()=>"success");

      } else {
        result = {'msg': '网络连接失败'};
      }
      return result;

    } catch (error) {
      print('error $error');
      result = {'msg': 'error: $error'};
      return result;
    }
  }

}