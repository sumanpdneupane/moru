import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moru/utils/CustomColors.dart';

class ResubmitPhotosDialog {
  ResubmitPhotosDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.close),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Text("Please resubmit your photos"),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 290,
                width: MediaQuery.of(context).size.width * 0.5,
                child: DottedBorder(
                  color: Colors.black,
                  strokeWidth: 0.5,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.upload),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Select a photo or drag and drop here"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "JPG, PNG or PDF, file size no more than 10MB",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 36,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: CustomColors.primarycolor)),
                          child: Center(child: Text("Select Photo")),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColors.primarycolor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Cancel"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: CustomColors.primarycolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Upload",
                          style: GoogleFonts.syne(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
