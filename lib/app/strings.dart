class StringConstants{
  static String getDate(DateTime dateTime){
    return '${dateTime.day<10 ? '0${dateTime.day}':dateTime.day}'
        '.${dateTime.month<10 ? '0${dateTime.month}':dateTime.month}'
        '.${dateTime.year}  '
        '${dateTime.hour<10 ? '0${dateTime.hour}':dateTime.hour}:'
        '${dateTime.minute<10 ? '0${dateTime.minute}':dateTime.minute}';
  }
}