import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_clone/features/global/theme/style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback? onTap;
  final bool isRequestProcessing;
  const CustomTextField(
      {Key? key,
      required this.textEditingController,
      this.onTap,
      required this.isRequestProcessing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          bottom: 28,
          left: size.width < 789 ? 28 : 150,
          right: size.width < 789 ? 28 : 150),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: colorDarkGray),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 90,
                        ),
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          controller: textEditingController,
                          maxLines: 10,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: "Open AI prompt",
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            if (textEditingController.text.isNotEmpty &&
                                onTap != null) {
                              onTap!();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    isRequestProcessing == true
                        ? Container(
                            height: 40,
                            child: Image.asset("assets/loading_response.gif"))
                        : InkWell(
                            onTap: textEditingController.text.isEmpty
                                ? null
                                : onTap,
                            child: Icon(
                              Icons.send,
                              color: textEditingController.text.isEmpty
                                  ? Colors.grey.withOpacity(.4)
                                  : Colors.grey,
                            ),
                          ),
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
