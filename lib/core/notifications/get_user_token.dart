import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

import '../utils/constants.dart';

class PushNotificationService {
  static Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "loct-app",
      "private_key_id": "b160bab50aae326ffc5dfba10bd87b189caf0bf4",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCtSYe+adXmSFNr\nF4mzKiwalYYhbGMHb0VjMzDbVA8m4J8Uw8Bc6cC6+N3SN6V6vuwjmtZ0mSJtaNas\nAloYm9am14VyVILxGisxUzZRJbITR10uHSt7gakaSVDa/hsJGiY+etXuOrYHu4D7\npIhI+ZAesQgaKZ9cCGYK3zJW9GHhtmkF4GdDzsGh6Xv38ALjBGVggMipzZ31p2RK\nldY3V9E1tsucsTIgNpoIGkwyiEQnIlABB0ELqBap6vBdsTd4Z2j+fiIlVDSFmELL\nUw+cLzuh4q9Xv/BWOaj4Uazr9hkRWcUvdoA5rxWyMbFsMvlgAUlknm5CX4d7WJcA\ns0Paai7fAgMBAAECggEACsA/Hb8vOCRQmJpTPrxlFBkmwzgYRMPQiEEKzPDAJ+dT\nt1QVwS33eSIrkPlG2QCzYdofaAiALE2O1AkpUdGJVbyVWOyJWzAGcf75pbsy+yM4\nUr4YjocS2MCntY6CWuQ2bzXrw+X8mSo27GXe1rg1CtJs8EKY0nrq6c3DL8XltL0k\nP7qRCr4rq74jgpCXEIla85uute/cqxJmVdnL2LqTOvlnApVy07ed9QBl6b7xI0DF\n5XPs4nsCe8UZalEucsFuyfTHhzRDidg3hNIQzv7M5P/sQ33wzdTV4Mq/S5kwoRsc\nbGIimcrOv/A/BlnMlPl1Xep4G1tzt+WwzsCboh7K0QKBgQDiBJMVqW8G7/y1Z0tN\npsY9MvBvkEmRv/JsGeGFoOX1qg5BEa/mYhjWtCtR5Wl4lMBKxwerb5iNlhXYYvLL\nj0K6RD67fsIHTaefvrwe2mRkjQXtkeJyH3kbusG/EM8u7RpgUyw2Gz7bWHWU5IB2\njtXwHWX4dlqI8uLQDOfXpQ8fAwKBgQDERkGPOPWtOg8S1GIeTzsKho0N0nWnigHy\nARjyHOc4QLHcRHWvZlIKj5kqxbMzsn+qbCBtyukRhzQXIn9phawT4bBCgxLyyKPd\nSS80Lz5RXVeT2R5TCXFdadj1Y79EKEsiZ8bkACDc3oUmEATubpHT90UtRtJOSGcg\nNA1BeZQr9QKBgCkzokiBoZ7HIu9CzER0kZDYd2IvEGpEboHsWeNNSH53KLAN9F3w\nJg0FvRvp0UdM/pzjGW/UISA2avcOWqpnDEf+Zt0xJ1fDfTouwAZz03dNCfab8IbT\nW/WFHwqgmtQ4HuXOY7HdV6EOyCiDWzPBqBhkk5EuqiRq+pPotl7mVRJXAoGAREbk\nW3xHCmGeCMDU+RI6yaiQvPQvdX6uuo7jLKYdURZASQ2PmtqPQ5k8gQKRGjTH8HL4\nvPjPJwfPeRTJGd4kRC5IcHrERqzBRCNHRnIAzbEY3Be1UtGAHCzMCmEOkhkqOee7\n6miZBfxqeRktffv8wq3L5Lo0QoMxTKSOz+4JO1kCgYBo52P5ALtsPi5vSqFwDwPb\n933I+mGtvnox9zRb+kI/gg0XXUXx7Qr++c5GdeSLq4h439bqVsAtwCT0zwHgRDfK\n8lBAfUhdvfIRuHHplQ4oUT4xowYKFBXJwo5IAj5Jz6gWj8w+ZSBiGWN/Yj/yJb+K\nR1HMCcZW20GDhLAy37FXMg==\n-----END PRIVATE KEY-----\n",
      "client_email": "locs-app@loct-app.iam.gserviceaccount.com",
      "client_id": "102833969850639286937",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/locs-app%40loct-app.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes, client);

    client.close();

    return credentials.accessToken.data;
  }

  static Future<void> sendNotificationToSelectedUser({required String deviceToken, required String title, required String body}) async {
    final String serverAccessToken = await getAccessToken();
    String endpointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/loct-app/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'token': deviceToken,
        'notification': {
          'title': title,
          'body': body,
        }
      }
    };

    final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessToken'
        },
        body: jsonEncode(message));

    if (response.statusCode == 200) {
      print('Notification Sent Successfully');
    } else {
      print('Notification Not Sent ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  static Future<void> sendNotificationToAllUsers({ required String title, required String body}) async {
    final String serverAccessToken = await getAccessToken();
    String endpointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/loct-app/messages:send';

    final Map<String, dynamic> message = {
      'message': {
        'topic': kTopic,
        'notification': {
          'title': title,
          'body': body,
        }
      }
    };

    final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessToken'
        },
        body: jsonEncode(message));

    if (response.statusCode == 200) {
      print('Notification Sent Successfully');
    } else {
      print('Notification Not Sent ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
