import 'package:lucid_validation/lucid_validation.dart';
import 'package:result_dart/result_dart.dart';

import 'package:marshaller/utils/exceptions/exceptions.dart';

extension LucidValidatorExtension<T extends Object> on LucidValidator<T> {
  AsyncResult<T> validateResult(T entity) async {
    final result = validate(entity);
    if (result.isValid) {
      return Success(entity);
    }
    final firstError = result.exceptions.first;
    return Failure(InvalidException(firstError.message, firstError.key));
  }
}
