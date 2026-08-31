import 'package:dio/dio.dart';

void main() async {
final dio = Dio();


final headers = {
'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4',
'accept': 'application/json',
};

await testApi(
dio: dio,
name: 'NOW PLAYING',
url: 'https://api.themoviedb.org/3/movie/now_playing',
headers: headers,
);

await testApi(
dio: dio,
name: 'UPCOMING',
url: 'https://api.themoviedb.org/3/movie/upcoming',
headers: headers,
);

await testApi(
dio: dio,
name: 'TOP RATED',
url: 'https://api.themoviedb.org/3/movie/top_rated',
headers: headers,
);

await testApi(
dio: dio,
name: 'POPULAR',
url: 'https://api.themoviedb.org/3/movie/popular',
headers: headers,
);
}

Future<void> testApi({
required Dio dio,
required String name,
required String url,
required Map<String, String> headers,
}) async {
print('');
print('========================================');
print('             $name');
print('========================================');
print('API: $url');

try {
final response = await dio.get(
url,
options: Options(headers: headers),
);

final results = response.data['results'];

print('Status Code: ${response.statusCode}');
print('Number of Movies: ${results.length}');
print('');

for (var movie in results) {
print(
'ID: ${movie['id']} | '
'Title: ${movie['title']}',
);
}

print('========================================');
} catch (e) {
print('ERROR in $name');
print(e);
print('========================================');
}
}
