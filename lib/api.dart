// A function that converts a response body into a List<Order>.
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:upstash_mobile/post/models/post.dart';

final String GET_POSTS =
    "https://5vafvrk8kj.execute-api.us-east-1.amazonaws.com/dev/posts";
List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

Future<List<Post>> fetchPosts(http.Client client) async {
  final response = await client
      .get(Uri.parse(GET_POSTS));

  return compute(parsePosts,response.body);
}