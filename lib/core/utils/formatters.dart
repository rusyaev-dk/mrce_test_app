
final class PhoneFormatter {
  static const String _countryCode = "+998";

  static String? toE164(String input) {
    final String digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;

    // Remove leading "00" (international prefix) if present.
    final String trimmed = digits.startsWith('00')
        ? digits.substring(2)
        : digits;

    // Cases:
    // 1) Already with country code: 998 + 9 digits => length 12.
    if (trimmed.startsWith('998') && trimmed.length == 12) {
      return '+$trimmed';
    }

    // 2) National format: exactly 9 digits (e.g., "901234567").
    if (trimmed.length == 9 && !_startsWithCountryCode(trimmed)) {
      return '+998$trimmed';
    }

    // 3) If user typed "998" + more/less digits -> invalid shape.
    // 4) Any other shape -> invalid.
    return null;
  }

  static bool _startsWithCountryCode(String s) => s.startsWith(_countryCode);
}


final class DateTimeFormatter {
  static DateTime parse(Object? raw) {
    // Accepts DateTime, ISO-8601 String, or Unix epoch (int seconds or milliseconds).
    if (raw is DateTime) return raw;
    if (raw is String && raw.isNotEmpty) {
      // Preserves Z/offset. Use .toUtc() if you want to normalize.
      return DateTime.parse(raw);
    }
    if (raw is int) {
      // Heuristic: >= 1e12 => milliseconds since epoch, else seconds.
      final bool isMillis = raw >= 1000000000000;
      return DateTime.fromMillisecondsSinceEpoch(
        isMillis ? raw : raw * 1000,
        isUtc: true,
      );
    }
    throw FormatException('Unsupported date value: $raw');
  }
}