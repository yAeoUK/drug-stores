class GenericException implements Exception {
  final ExceptionCode code;
  final dynamic info;

  GenericException({this.code = ExceptionCode.unknown, this.info});

  @override
  String toString() {
    return '$runtimeType: ${code.value}';
  }

  String get message {
    switch (runtimeType) {
      case NotFoundException:
        return '${code.value}: $info\nis not found.';
      case NotUniqueException:
        return '${code.value}: $info\nalready exists.';
      case NotPositiveException:
        return '${code.value}: must be greater greater than 0';
      case NullEmptyException:
        return '${code.value}\nmust not be null or empty.';
      case LengthException:
        return '${code.value} must be $info letters or shorter.';
      case MinimumLengthException:
        return '${code.value} must be $info letters or longer.';
      case RemovalException:
        return code == ExceptionCode.category
            ? 'Cannot be removed;\nthis category contains notes.'
            : 'Cannot be removed';
      default:
        return 'Unknown error occurred.';
    }
  }
}

class NotFoundException extends GenericException {
  NotFoundException({required ExceptionCode code, required String target})
      : assert(target.isNotEmpty),
        super(code: code, info: target);
}

class NotUniqueException extends GenericException {
  NotUniqueException({required ExceptionCode code, required String value})
      : assert(value.isNotEmpty),
        super(code: code, info: value);
}

class NotPositiveException extends GenericException {
  NotPositiveException({required ExceptionCode code, required String value})
      : assert(int.parse(value) > 0),
        super(code: code, info: value);
}

class NullEmptyException extends GenericException {
  NullEmptyException({required ExceptionCode code}) : super(code: code);
}

class LengthException extends GenericException {
  LengthException({required ExceptionCode code, required int max})
      : assert(max > 0),
        super(code: code, info: max);
}

class MinimumLengthException extends GenericException {
  MinimumLengthException({required ExceptionCode code, required int min})
      : assert(min > 0),
        super(code: code, info: min);
}

class RemovalException extends GenericException {
  RemovalException({required ExceptionCode code}) : super(code: code);
}

enum ExceptionCode {
  unknown,
  userId,
  username,
  password,
  message,
  category,
  categoryId,
  categoryName,
  note,
  noteId,
  noteTitle,
}

extension ExceptionCodeValue on ExceptionCode {
  String get value {
    switch (this) {
      case ExceptionCode.category:
        return 'Category';
      case ExceptionCode.categoryId:
        return 'Category ID';
      case ExceptionCode.categoryName:
        return 'Category name';
      case ExceptionCode.note:
        return 'Note';
      case ExceptionCode.noteId:
        return 'Note ID';
      case ExceptionCode.noteTitle:
        return 'Note title';
      case ExceptionCode.userId:
        return 'User Id';
      case ExceptionCode.username:
        return 'Username';
      case ExceptionCode.password:
        return 'Password';
      case ExceptionCode.message:
        return 'Message';
      default:
        return 'Unknown';
    }
  }
}
