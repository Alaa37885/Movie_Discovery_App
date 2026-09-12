abstract class GuestSessionState {}

class GuestSessionInitial extends GuestSessionState {}

class GuestSessionLoading extends GuestSessionState {}

class GuestSessionSuccess extends GuestSessionState {
  final String guestSessionId;

  GuestSessionSuccess(this.guestSessionId);
}

class GuestSessionFailure extends GuestSessionState {
  final String message;

  GuestSessionFailure(this.message);
}

class GuestRatingLoading extends GuestSessionState {}

class GuestRatingSuccess extends GuestSessionState {
  final String message;

  GuestRatingSuccess(this.message);
}

class GuestRatingFailure extends GuestSessionState {
  final String message;

  GuestRatingFailure(this.message);
}
