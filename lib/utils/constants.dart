enum DbKeys {
  photodb('photo_db', 'photos');

  const DbKeys(this.name, this.collection);
  final String name, collection;
}

enum ErrorTypes {
  generic(
    'Hmmm, we hit a snag. Please try again later or reach out to our support team for assistance.',
  );

  const ErrorTypes(this.name);
  final String name;
}
