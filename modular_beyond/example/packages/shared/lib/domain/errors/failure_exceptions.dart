class FailureException implements Exception {}

class InvalidSearchText extends FailureException {}

class EmptyList extends FailureException {}

class ErrorSearch extends FailureException {}

class DatasourceResultNull extends FailureException {}
