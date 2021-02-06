import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/app/colors/colors.dart';
import 'package:education/app/constants.dart';
import 'package:education/models/Student.dart';
import 'package:education/services/authentication.dart';
import 'package:education/ui/home_page/share_student_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shimmer/shimmer.dart';

class ShareContent extends StatefulWidget {
  @override
  _ShareContentState createState() => _ShareContentState();
}

class _ShareContentState extends State<ShareContent> {
  ShareStudentModel model = ShareStudentModel();

  Authentication user = Authentication();
  List<Asset> images = <Asset>[];
  List<String> imageUrls = <String>[];
  bool firstpress = true;

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 5,
        shrinkWrap: true,
        children: List.generate(images.length, (index) {
          var asset = images[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AssetThumb(
              asset: asset,
              width: 200,
              height: 200,
            ),
          );
        }),
      ),
    );
  }

  Future<void> loadAssets() async {
    var resultList = <Asset>[];
    var error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: 'Student Detail'),
        materialOptions: MaterialOptions(
          actionBarColor: '#abcdef',
          actionBarTitle: 'F4R Education App',
          allViewTitle: 'Tüm Fotoğraflar',
          useDetailsView: false,
          selectCircleStrokeColor: '#000000',
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future<dynamic> postImage(Asset imageFile) async {
    var fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance
        .ref()
        .child('Students')
        .child('student' + fileName + '.jpg');
    var uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    var storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  Future postPaylasim() async {
    var db = Student(
        model.user.toString(),
        DateTime.now(),
        DateTime.now(),
        model.studentName.text,
        model.studentPhone.text,
        model.studentTC.text.isNotEmpty
            ? model.studentTC.text
            : 'Bilgi Verilmedi',
        int.parse(model.studentAge.text),
        model.studentAddress.text,
        imageUrls,
        false,
        '',
        [],
        0,
        [],
        int.parse(model.studentClass.text),
        model.explanation.text,
        []);
    var shareName = DateTime.now().microsecondsSinceEpoch.toString();
    var studentInfo =
        FirebaseFirestore.instance.collection('Students').doc(shareName);
    await studentInfo.set(db.toMap());
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(db.publisher)
        .update({
      'listOfPost': FieldValue.arrayUnion([shareName])
    });
    for (var imageFile in images) {
      await postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images.length) {
          studentInfo.set(db.toMap()).then((_) {
            setState(() {
              images = [];
              imageUrls = [];
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(db.publisher)
          .update({
        'listOfPost': FieldValue.arrayUnion([shareName])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.3,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [ColorTable.swatch4, ColorTable.swatch6])),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: size.height,
            child: Column(
              children: [
                customAppBar(context),
                Expanded(
                  child: Container(
                    height: Constants.getHeight(context),
                    width: Constants.getWidth(context),
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Öğrenci Bildir',
                            style: TextStyle(
                              fontFamily: 'ElYazisi',
                              color: ColorTable.swatch6,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              height: 2, width: 50, color: ColorTable.swatch5),
                          userInput(model.studentName, 'Öğrenci Adı',
                              TextInputType.text, 50),
                          userInput(model.studentPhone, 'Telefon Numarası',
                              TextInputType.number, 11),
                          userInput(
                              model.studentTC,
                              'TC Kimlik Numarası (İsteğe Bağlı)',
                              TextInputType.number,
                              11),
                          userInput(model.studentAge, 'Yaşı',
                              TextInputType.number, 2),
                          userInput(model.studentAddress, 'Adresi',
                              TextInputType.text, 80),
                          userInput(model.studentClass, 'Sınıf',
                              TextInputType.number, 2),
                          userInput(model.explanation, 'Açıklama',
                              TextInputType.text, 400),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    loadAssets();
                                  },
                                  child: Container(
                                    height: 44,
                                    width: 44,
                                    child: Icon(FontAwesomeIcons.image,
                                        color: Colors.blueGrey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    '${images.length}/4',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          images.isEmpty
                              ? SizedBox()
                              : Container(child: buildGridView()),
                          SizedBox(height: Constants.getHeight(context) * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              shareButton(),
                            ],
                          ),
                          SizedBox(height: Constants.getHeight(context) * 0.05)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget shareButton() {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: ColorTable.swatch4,
          highlightColor: ColorTable.swatch6,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(20)),
          ),
        ),
        InkWell(
          onTap: () async {
            if (firstpress) {
              setState(() {
                firstpress = false;
              });
              await postPaylasim();
            }
          },
          child: Container(
              alignment: Alignment.center,
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(FontAwesomeIcons.check, color: Colors.white)),
        ),
      ],
    );
  }

  Widget customAppBar(BuildContext context) {
    return Container(
      height: Constants.getHeight(context) * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: GestureDetector(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  Widget userInput(_controller, text, textInputType, length) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: _controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(length),
        ],
        cursorColor: ColorTable.swatch6,
        autofocus: false,
        keyboardType: textInputType,
        style: TextStyle(fontSize: 15.0, color: ColorTable.swatch6),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: Color(0xff435189)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
