import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ContentShare extends StatefulWidget {
  @override
  _ContentShareState createState() => _ContentShareState();
}

class _ContentShareState extends State<ContentShare> {
  final TextEditingController _detay = TextEditingController();
  List<Asset> images = <Asset>[];
  List<String> imageUrls = <String>[];
  bool firstpress = true;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
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
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: 'Forum'),
        materialOptions: MaterialOptions(
          actionBarColor: '#abcdef',
          actionBarTitle: 'Beauty App',
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
        .child('Forum')
        .child('forum_' + fileName + '.jpg');
    var uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    var storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  // Future postPaylasim() async {
  //   var shareName = DateTime.now().microsecondsSinceEpoch.toString();
  //   var forum = FirebaseFirestore.instance.collection("Forum").doc(shareName);
  //   forum.set({
  //     'user': userID,
  //     'date': DateTime.now(),
  //     'detail': _detay.text,
  //     'name': fullName,
  //     'urls': [],
  //
  //   });
  //   FirebaseFirestore.instance.collection('Users').doc(userID).update({
  //     'shares': FieldValue.arrayUnion([shareName])
  //   });
  //   for (var imageFile in images) {
  //     postImage(imageFile).then((downloadUrl) {
  //       imageUrls.add(downloadUrl.toString());
  //       if (imageUrls.length == images.length) {
  //         forum.set({
  //           'user': userID,
  //           'date': DateTime.now(),
  //           'detail': _detay.text,
  //           'name': fullName,
  //           'urls': imageUrls,
  //
  //         }).then((_) {
  //           setState(() {
  //             images = [];
  //             imageUrls = [];
  //           });
  //         });
  //       }
  //     }).catchError((err) {
  //       print(err);
  //     });
  //     FirebaseFirestore.instance.collection('Users').doc(userID).update({
  //       'shares': FieldValue.arrayUnion([shareName])
  //     });
  //   }
  // }

  Future delay() async {
    await new Future.delayed(new Duration(milliseconds: 4000), () {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      //     (Route<dynamic> route) => true);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * 0.5,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff0d7377), Color(0xff0f3057)])),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              height: size.height,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Yeni Konu",
                                style: TextStyle(
                                  fontFamily: "ElYazisi",
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 2,
                                width: 50,
                                color: Colors.pink,
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: InkWell(
                              onTap: () async {
                                if (_detay.text.isEmpty) {
                                  await Fluttertoast.showToast(
                                      gravity: ToastGravity.TOP,
                                      backgroundColor: Color(0xffcd0a0a),
                                      msg: 'Lütfen boş konu göndermeyiniz.');
                                } else if (_detay.text.contains('  ')) {
                                  await Fluttertoast.showToast(
                                      gravity: ToastGravity.TOP,
                                      backgroundColor: Color(0xffcd0a0a),
                                      msg: 'Boş metin girmeyiniz.');
                                } else if (_detay.text.length < 2) {
                                  await Fluttertoast.showToast(
                                      gravity: ToastGravity.TOP,
                                      backgroundColor: Color(0xffcd0a0a),
                                      msg: 'Geçerli metin giriniz.');
                                } else if (firstpress) {
                                  firstpress = false;
                                  //await postPaylasim();
                                  setState(() {
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //     MaterialPageRoute(
                                    //         builder: (BuildContext context) =>
                                    //             loader()),
                                    //     (Route<dynamic> route) => true);
                                    delay();
                                  });
                                }
                              },
                              child: Container(
                                height: 44,
                                width: 44,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: Color(0xfff1f3f8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc()
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: snapshot.data['userPhoto'] ==
                                                    "" ||
                                                snapshot.data['userPhoto'] ==
                                                    null
                                            ? Image.asset(
                                                "assets/images/user.jpg",
                                                height: 50,
                                                width: 50,
                                              )
                                            : Image.network(
                                                snapshot.data['userPhoto'],
                                                fit: BoxFit.cover,
                                                width: 50,
                                                height: 50,
                                              ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        maxLines: 10,
                                        minLines: 2,
                                        keyboardType: TextInputType.text,
                                        controller: _detay,
                                        style: TextStyle(
                                            color: Colors.black,
                                            decorationColor: Colors.white,
                                            fontSize: 19),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          focusColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          hintText: "Neler oluyor?",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
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
                                        "${images.length}/3",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(child: buildGridView()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
