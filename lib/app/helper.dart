


import 'package:education/models/User.dart' as usr;

class Helper {

   static  List<String> UserIconLevel(usr.User user){
     print(user.point);
      var level =<String,String>{'Gönüllü':'assets/user_icon/volunteer1.png','Bağışçı':'assets/user_icon/volunteer2.png','Cömert':'assets/user_icon/volunteer3.png',
        'Profuse':'assets/user_icon/volunteer4.png','Efsane':'assets/user_icon/volunteer5.png'};
    List<String> list;
    if(user.point>=0 && user.point<100){
        list = [level.keys.elementAt(0),level.values.elementAt(0)];
      }
    else if(user.point>=100 && user.point<500){
        list = [level.keys.elementAt(1),level.values.elementAt(1)];
    }
    else if(user.point>=500 && user.point<1000){
      list = [level.keys.elementAt(2),level.values.elementAt(2)];
    }
    else if(user.point>=1000 && user.point<1500){
      list = [level.keys.elementAt(3),level.values.elementAt(3)];
    }
    else if(user.point>=1500){
      list = [level.keys.elementAt(4),level.values.elementAt(4)];
    }
      return list;
  }
}