sealed class AuthFailure {}

class CancelledByUser extends AuthFailure {}

class InvalidCredential extends AuthFailure {}

class AccountExistWithDifferentCredential extends AuthFailure {}

class EmailAlreadyInUse extends AuthFailure {}

class SessionExpired extends AuthFailure {}

class ServerError extends AuthFailure {}
