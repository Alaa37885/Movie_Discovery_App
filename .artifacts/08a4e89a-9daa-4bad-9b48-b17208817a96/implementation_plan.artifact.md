# Fix Navigation and Consolidate Movie Models

The goal is to resolve the type mismatch issue when navigating to `MovieDetailsScreen` and to improve the overall code quality by refactoring the repetitive movie grid logic.

## Proposed Changes

### 1. Data Models Consistency
Ensure all movie-related models use a single, unified `MovieModel` class to avoid type mismatch errors.

#### [MODIFY] [popular_model.dart](file:///C:/Development/NTI-Sessions/movie_nti_aug_26/lib/models/popular_model.dart)
- Ensure it imports and uses `MovieModel` from `movies_model.dart`.
- (Already mostly done, but will verify and clean up).

### 2. Cubit Refactoring
Unify the success states of all movie cubits to return `List<MovieModel>`. This makes the UI logic consistent.

#### [MODIFY] [popular_state.dart](file:///C:/Development/NTI-Sessions/movie_nti_aug_26/lib/cubits/popular_cubit/popular_state.dart)
- Change `PopularSuccess` to accept `List<MovieModel>` instead of `PopularResponse`.

#### [MODIFY] [popular_cubit.dart](file:///C:/Development/NTI-Sessions/movie_nti_aug_26/lib/cubits/popular_cubit/popular_cubit.dart)
- Update `getPopular` to emit `PopularSuccess` with `popularResponse.results`.

### 3. UI Refactoring
Refactor `home_screen.dart` to remove duplication and fix navigation for all tabs.

#### [MODIFY] [home_screen.dart](file:///C:/Development/NTI-Sessions/movie_nti_aug_26/lib/screens/home_screen.dart)
- Create a reusable `MovieGridView` widget.
- Implement navigation (`onTap`) for all movie items in all tabs.
- Clean up commented-out code and unused variables.

## Verification Plan

### Manual Verification
- Run the app and navigate to each of the 4 tabs (Now Playing, Upcoming, Top Rated, Popular).
- Tap on a movie in each tab and verify it navigates to the `MovieDetailsScreen` without errors.
- Verify the carousel also navigates to the details screen (optional, but recommended).
