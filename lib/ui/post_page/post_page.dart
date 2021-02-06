import 'package:education/models/Student.dart';
import 'package:education/ui/post_page/post_page_model.dart';
import 'package:education/ui/post_page/posts_page_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostPageModel _postPageModel = PostPageModel();
  final PostPageServices _postPageServices = PostPageServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: FutureBuilder(
          future: _postPageServices.getAllStudent(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(50, 168, 82, .5),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.green,
                              ),
                              Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '@username',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('Seviye',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              Icon(Icons.share),
                              Row(
                                children: [Icon(Icons.star), Text('(15)')],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            child: Image.network(
                                'https://lh3.googleusercontent.com/6yhnZ_AjXZms_nqtlmSLNyQKAXJlZdsFpz_sg17jrnz0uwL7rMYmPQcO9MAqySxShCqFqNAqP6UvWjme2lLpebtdl0iMG_jYFymR=w1296-v1'),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(snapshot.data[index].fullname),
                                    Text(snapshot.data[index].age.toString()),
                                    Text(snapshot.data[index].classOfStudent
                                        .toString()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(snapshot.data[index].explanation),
                                    Icon(
                                      snapshot.data[index].approvalStatus
                                          ? Icons.verified
                                          : Icons.verified_outlined,
                                      color: snapshot.data[index].approvalStatus
                                          ? Colors.green
                                          : Colors.red,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('YOK'),
              );
            }
          },
        ),
      ),
    );
  }
}
