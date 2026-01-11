final class PhoneFormatter {
  static String? toE164(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;

    // Remove leading 00 (international call prefix)
    if (digits.startsWith('00')) {
      digits = digits.substring(2);
    }

    // Case 1: already full Uzbekistan number in E.164 digits-only format
    // 998 + 9 digits = 12 digits total
    if (digits.startsWith('998') && digits.length == 12) {
      return '+$digits';
    }

    // Case 2: local national number (9 digits)
    // must NOT start with "998"
    if (digits.length == 9 && !digits.startsWith('998')) {
      return '+998$digits';
    }

    // Any other case -> invalid
    return null;
  }
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
