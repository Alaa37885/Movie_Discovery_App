class ApiConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  
  // TODO: Replace with your actual API Key or Token from TMDB dashboard
  static const String bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYmYwNzRjYzk3MzE0YmRiMWZmM2VlMmQ3NWUwNWY0ZiIsIm5iZiI6MTc2MTM5NzAxOS4xMDgsInN1YiI6IjY4ZmNjOTFiYzQzZDA1OTllMjkzODUwNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lzdT9GXoMtzophhJo7yb5wZ0MviXwdxUh7Lo1kVT1N4";

  static Map<String, String> get headers => {
    "Authorization": "Bearer $bearerToken",
    "accept": "application/json",
  };
}

