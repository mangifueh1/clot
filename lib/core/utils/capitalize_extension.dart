extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return '';
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String toTitleCase() {
    if (isEmpty) {
      return '';
    }
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.capitalizeFirst())
        .join(' ');
  }
}