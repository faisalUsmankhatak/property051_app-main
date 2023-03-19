extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now().subtract(const Duration(days: 1));
    final difference = date2.difference(this);
    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);
    var days = diff.inDays;
    if (days >= 1) {
      if (days > 7) {
        var weeks = (days / 7).floor();
        if (weeks > 4) {
          var months = (weeks / 4).floor();
          if (months == 1)
            return ('$months month ago');
          else {
            return ('$months months ago');
          }
        } else {
          if (weeks == 1)
            return ('$weeks week ago');
          else {
            return ('$weeks weeks ago');
          }
        }
      } else {
        if (days == 1) {
          return ('$days day ago');
        } else {
          return ('$days day(s) ago');
        }
      }
    } else if (diff.inHours >= 1) {
      return ('${diff.inHours} hour(s) ago');
    } else if (diff.inMinutes >= 1) {
      return ('${diff.inMinutes} minute(s) ago');
    } else if (diff.inSeconds >= 1) {
      return ('${diff.inSeconds} second(s) ago');
    } else {
      return ('just now');
    }
  }
}
