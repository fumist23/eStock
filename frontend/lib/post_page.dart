import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/component/appbar_design.dart';
import 'package:google_fonts/google_fonts.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return Scaffold(
      appBar: AppBarDesign(
        title: 'Post',
        useBackButton: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              children: [
                Expanded(flex: 1, child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey),
                    child: const Center(
                      child: Icon(Icons.photo_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
                  child: SizedBox(
                    height: 45,
                    child: CupertinoTextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      placeholder: 'Location',
                      keyboardType: TextInputType.multiline,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefix: const Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    height: 45,
                    child: CupertinoTextField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1000),
                      ],
                      placeholder: 'Comment',
                      keyboardType: TextInputType.multiline,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefix: const Icon(Icons.comment_outlined),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Share!',
                            style: GoogleFonts.pacifico(
                              fontSize: 20.0,
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(flex: 3, child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
