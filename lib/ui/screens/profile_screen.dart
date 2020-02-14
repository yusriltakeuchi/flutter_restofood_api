import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: ProfileBody()
        ),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        //Bagian headers
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          color: Colors.orange,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(60),
                    image: DecorationImage(
                      image: NetworkImage("https://source.unsplash.com/800x800/?user")
                    )
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Yusril Rapsanjani",
                  style: TextStyle(
                    fontSize: 25, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Text(
                    "Seorang pria dengan dedikasi tinggi dan haus akan ilmu baru",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15, 
                      color: Colors.white, 
                    ),
                  ),
                )
              ],
            ),
          )
        ),

        //Bagian field login
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 1,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Biodata",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Asal Kota: Jakarta\nUmur: 21\nHobby: Programming, Watching Movie",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )


      ],
    );
  }
}