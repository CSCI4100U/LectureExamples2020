

String twoDigits(int value) {
  String result = '';
  if (value < 10) {
    result += '0';
  }
  return result + value.toString();
}

String toDateString(int year, int month, int day) {
  return year.toString() + '/' + twoDigits(month) + '/' + twoDigits(day);
}

String toTimeString(int hour, int minute) {
  return twoDigits(hour) + ':' + twoDigits(minute);
}

String getWeekdayNameByIndex(int index) {
  if (index == 1) {
    return 'monday';
  } else if (index == 2) {
    return 'tuesday';
  } else if (index == 3) {
    return 'wednesday';
  } else if (index == 4) {
    return 'thursday';
  } else if (index == 5) {
    return 'friday';
  } else if (index == 6) {
    return 'saturday';
  } else {
    return 'sunday';
  }
}

String notNull(String nullable) {
  return nullable == null ? '' : nullable;
}
