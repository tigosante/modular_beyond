abstract class I18nService {
  /// Translate using the key and arguments.
  /// The [args] matcher is %s.
  ///
  /// [key] is the key to be translated
  ///
  /// [args] is the list of string to be replaced in the key.
  /// Is optional and can be empty []
  ///
  /// ```
  /// // File en-us.json -> {"hello_user": "Hello %s"}
  /// service.i18n('hello_user', ['John']); -> // 'Hello John'
  /// ```
  ///
  String i18n(String key, [List<String> args]);

  /// Translate using a map of keys and arguments.
  ///
  /// Indicated for cases where the text is very large or has repeated values.
  ///
  /// [key] is the key to be translated
  ///
  /// [data] can't be empty
  ///
  /// ```
  /// service.i18nMap('description', {
  ///   'name': 'Lorem Ipsum',
  ///   'start_year': '1500s',
  ///   'year_of_popularization': '1960s',
  /// });
  /// ```
  ///
  // ignore: lines_longer_than_80_chars
  /// **{{name}}** is simply dummy text of the printing and typesetting industry.
  /// **{{name}}** has been the industry's standard dummy text ever since the
  /// **{{start_year}}**, when an unknown printer took a galley of type and
  /// scrambled it to make a type specimen book. It has survived not only
  /// five centuries, but also the leap into electronic typesetting, remaining
  // ignore: lines_longer_than_80_chars
  /// essentially unchanged. It was popularised in the **{{year_of_popularization}}**
  // ignore: lines_longer_than_80_chars
  /// with the release of Letraset sheets containing **{{name}}** passages, and more
  /// recently with desktop publishing software like Aldus PageMaker including
  /// versions of **{{name}}**.
  ///
  String i18nMap(String key, Map<String, String> data);
}
