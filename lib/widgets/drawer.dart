import 'package:flutter/material.dart';
import 'package:gradient_maker/constants.dart';
import 'package:gradient_maker/global.dart';
import 'package:gradient_maker/main.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double minVerticalPadding = h * 0.022;
    double webiconW = 25;
    double webFont = 15;
    return Container(  margin: EdgeInsets.symmetric(vertical: topbarH),
      child: Drawer(
         shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
            ),
        // backgroundColor: Colors.white,
        width: 200,
        child: Container(
        
          // color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.transparent,
            // image: DecorationImage(
            //     image: AssetImage('assets/bg1.jpg'), fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: h * 0.06,
              ),
       
         
             
              InkWell(
                onTap: () {
                  launch(C.playstorelink);
                },
                child: ListTile(
                  minVerticalPadding: minVerticalPadding,
                  leading: Image.asset(
                    'assets/playstore.png',
                    width: webiconW,
                  ),
                  title: Text(
                    'Play Store',
                    style: TextStyle(color: Colors.black, fontSize: webFont),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launch(C.linkedinlink);
                },
                child: ListTile(
                  minVerticalPadding: minVerticalPadding,
                  leading: Image.asset(
                    'assets/linkedin.png',
                    width: webiconW,
                  ),
                  title: Text(
                    'Linked In',
                    style: TextStyle(color: Colors.black, fontSize: webFont),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launch(C.youtubevideolink);
                },
                child: ListTile(
                  minVerticalPadding: minVerticalPadding,
                  leading: Image.asset(
                    'assets/youtube.png',
                    width: webiconW,
                  ),
                  title: Text(
                    'YouTube',
                    style: TextStyle(color: Colors.black, fontSize: webFont),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launch("https://github.com/sdycode");
                },
                child: ListTile(
                  minVerticalPadding: minVerticalPadding,
                  leading: Image.asset(
                    'assets/git.png',
                    width: webiconW,
                  ),
                  title: Text(
                    'Github',
                    style: TextStyle(color: Colors.black, fontSize: webFont),
                  ),
                ),
              ),
          
            Divider(),
            InkWell(
                onTap: () {
                  launch(C.linkedinlink);
                },
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text("Source Code", style: TextStyle(fontWeight: FontWeight.w600),),Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("https://github.com/sdycode/Gradient_Maker",
                 textAlign: TextAlign.center,
                    ),
                  )],
                )
               
              ),
               Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("Developed By", style: TextStyle(fontWeight: FontWeight.w500),),Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Shubham Yeole",
             textAlign: TextAlign.center,
             style: TextStyle(fontWeight: FontWeight.w900),
                ),
              )],
            )
            ],
          ),
        ),
      ),
    );
  }
}
