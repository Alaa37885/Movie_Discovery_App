# Movie NTI - Movie Discovery App 🎬

A professional Flutter application built to explore the latest movies, search for favorites, and manage a personal watchlist. This project was developed as part of the **NTI (National Telecommunication Institute)** training program.

## 🚀 Overview

This app provides a seamless experience for movie enthusiasts to discover trending films, view detailed information including cast and reviews, and keep track of movies they want to watch. It leverages the **TMDB API** for real-time data and follows modern Flutter development best practices.

## ✨ Features

- **Dynamic Home Screen**: 
  - Featured movie carousel using `carousel_slider`.
  - Categorized movie tabs: Now Playing, Upcoming, Top Rated, and Popular.
- **Advanced Search**: 
  - Real-time search functionality.
  - Detailed search results including genre, runtime, and release year fetched dynamically.
- **Movie Details**: 
  - High-quality backdrop and poster displays.
  - Comprehensive metadata: Runtime, Genre, and Release Year.
  - Dynamic tabs for **About Movie**, **User Reviews**, and **Cast Members**.
- **Watchlist Management**: 
  - Ability to add/remove movies from a personal watchlist.
  - Persistent-like state management for saved films.
- **Responsive UI**: Dark-themed, modern design tailored for a premium feel.

## 🛠️ Tech Stack & Tools

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Flutter BLoC / Cubit](https://pub.dev/packages/flutter_bloc) for clean separation of concerns.
- **Networking**: [Dio](https://pub.dev/packages/dio) for robust HTTP requests and API handling.
- **Data Modeling**: Custom JSON serialization for complex API responses.
- **UI Components**: `carousel_slider`, `google_fonts`, and custom widgets.
- **API**: [The Movie Database (TMDB)](https://www.themoviedb.org/documentation/api)

## 🏗️ Detailed Architecture

This project follows a **Feature-First Architecture** (also known as a Layered Feature approach). This design ensures that the codebase is modular, easy to navigate, and scalable.

### 📁 Folder Structure Overview

The code is organized into three main pillars: `core`, `features`, and `main.dart`.

#### 1. Core Layer (`lib/core/`)
This layer contains code that is shared across the entire application. It is independent of any specific feature.
- **Network**: Contains `DioClient` and API constants. It provides a centralized way to handle HTTP requests, timeouts, and headers (like TMDB Bearer Tokens).
- **Theme**: Defines the `AppTheme` (Dark Mode), colors, and typography used globally.

#### 2. Features Layer (`lib/features/`)
Each feature is a self-contained module representing a specific functional area of the app. This project uses a **Simplified Presentation-Data** split within each feature.

**Feature Internal Structure:**
- **`data/models/`**: Contains **Data Transfer Objects (DTOs)** for JSON serialization.
- **`presentation/screens/`**: High-level UI components (Pages).
- **`presentation/widgets/`**: Reusable UI components specific to the feature.
- **`presentation/cubits/`**: The **Business Logic Component (BLoC)** layer managing state and API calls.

#### 3. Navigation & Flow
- **`lib/features/nav/`**: Handles the `BottomNavigationBar` logic, allowing the user to switch between Home, Search, and Watchlist while maintaining state.

### 🔄 Data Flow (The Journey of a Request)

1.  **User Action**: The user interacts with the UI (e.g., searches for a movie).
2.  **Cubit Trigger**: The UI calls a method in the `Cubit`.
3.  **State Change**: The Cubit emits a `LoadingState`.
4.  **Network Request**: The Cubit uses `Dio` to call the TMDB API.
5.  **Data Parsing**: raw JSON is converted into a `Model`.
6.  **Success/Error State**: The Cubit emits a `SuccessState` with data or a `FailureState` with an error.
7.  **UI Update**: `BlocBuilder` detects the new state and rebuilds the UI.

## ⚙️ Setup & Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/movie_nti_aug.git
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **API Configuration**:
   The app uses TMDB. Ensure your API Bearer Token is correctly configured.

4. **Run the app**:
   ```bash
   flutter run
   ```

## Developed with 
    A'laa Omar Hamed


