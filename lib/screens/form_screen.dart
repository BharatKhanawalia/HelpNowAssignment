// import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpnow_assignment/constants.dart';
import 'package:helpnow_assignment/models/form.dart';
import 'package:helpnow_assignment/models/form_service.dart';
import 'package:helpnow_assignment/screens/home_screen.dart';
import 'package:helpnow_assignment/widgets/rounded_button.dart';
import 'package:helpnow_assignment/widgets/rounded_input_field.dart';
import 'package:helpnow_assignment/widgets/text_field_container.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _productTypeFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _amountTypeFocusNode = FocusNode();

  DateTime pickedDate;

  var _formData = FormData();
  var _formService = FormService();

  bool dateSelected = false;

  PickedFile _imageFile;
  final picker = ImagePicker();
  @override
  void initState() {
    // _requestPermission(Permission.storage);
    pickedDate = DateTime.now();
    _formData.date = pickedDate;
    super.initState();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _mobileFocusNode.dispose();
    _amountFocusNode.dispose();
    _productTypeFocusNode.dispose();
    _amountTypeFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    var result = await _formService.saveForm(_formData);
    print(result);
    // saveVideo();
    // if (_imageFile != null) convertImage();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  _pickDate() async {
    _formData.date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    setState(() {
      dateSelected = true;
    });
    if (_formData.date == null) {
      setState(() {
        _formData.date = DateTime.now();
      });
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: kPrimaryColor,
                ),
                label: Text(
                  'Camera',
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  color: kPrimaryColor,
                ),
                label: Text(
                  'Gallery',
                  style: TextStyle(color: kPrimaryColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
    Navigator.of(context).pop();
  }

  // void convertImage() {
  //   File _image = File(_imageFile.path);
  //   List<int> imageBytes = _image.readAsBytesSync();
  //   print(imageBytes);
  //   String base64Image = base64Encode(imageBytes);
  //   setState(() {
  //     _formData.image = base64Image;
  //   });
  // }

  // Future<bool> saveVideo(
  //     // String url, String fileName
  //     ) async {
  //   Directory directory;
  //   try {
  //     if (await _requestPermission(Permission.storage)) {
  //       directory = await getExternalStorageDirectory();
  //       String newPath = "";
  //       print(directory);
  //       List<String> paths = directory.path.split("/");
  //       for (int x = 1; x < paths.length; x++) {
  //         String folder = paths[x];
  //         if (folder != "Android") {
  //           newPath += "/" + folder;
  //         } else {
  //           break;
  //         }
  //       }
  //       newPath = newPath + "/HelpNow";
  //       directory = Directory(newPath);
  //     } else {
  //       return false;
  //     }

  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }
  //     // if (await directory.exists()) {
  //     //   File saveFile = File(directory.path + "/$fileName");
  //     //   await dio.download(url, saveFile.path,
  //     //       onReceiveProgress: (value1, value2) {
  //     //     setState(() {
  //     //       progress = value1 / value2;
  //     //     });
  //     //   });
  //     //   if (Platform.isIOS) {
  //     //     await ImageGallerySaver.saveFile(saveFile.path,
  //     //         isReturnPathOfIOS: true);
  //     //   }
  //     //   return true;
  //     // }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return false;
  // }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    // final mediaHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            color: kWhite,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Add Entry",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: NotificationListener(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowGlow();
            return;
          },
          child: Center(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: kPrimaryColor,
                                  radius: 81,
                                  child: CircleAvatar(
                                    radius: 80,
                                    backgroundImage: _imageFile == null
                                        ? AssetImage(
                                            'assets/images/placeholder_dp.png')
                                        : FileImage(File(_imageFile.path)),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  right: 20,
                                  child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: ((builder) => bottomSheet()),
                                        );
                                      },
                                      child: Icon(Icons.camera_alt)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RoundedInputField(
                            backgroundColor: kPrimaryLightColor,
                            borderColor: kPrimaryColor,
                            textInputAction: TextInputAction.next,
                            focusNode: _nameFocusNode,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_mobileFocusNode);
                            },
                            hintText: 'Name *',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Name is required.';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              _formData.name = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RoundedInputField(
                            backgroundColor: kPrimaryLightColor,
                            borderColor: kPrimaryColor,
                            textInputAction: TextInputAction.next,
                            // prefix: Text('+91 '),
                            focusNode: _mobileFocusNode,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_productTypeFocusNode);
                            },
                            hintText: 'Mobile Number *',
                            validator: (value) {
                              if (value.isEmpty) {
                                _mobileFocusNode.requestFocus();
                                return 'Mobile number is required.';
                              }
                              if (value.length >= 1 && value.length < 10) {
                                _mobileFocusNode.requestFocus();
                                return 'Enter a valid mobile number';
                              }
                              if (double.parse(value) < 0) {
                                _mobileFocusNode.requestFocus();
                                return 'Enter a valid mobile number';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              _formData.mobile = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldContainer(
                            width: mediaWidth * 0.8,
                            backgroundColor: kPrimaryLightColor,
                            borderColor: kPrimaryColor,
                            child: DropdownButtonFormField<String>(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              value: null,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              focusNode: _productTypeFocusNode,
                              hint: Text('Product Type *'),
                              isExpanded: true,
                              onChanged: (String value) {
                                setState(() {
                                  _formData.productType = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Product Type is required';
                                }
                                return null;
                              },
                              items: <String>[
                                'Product',
                                'Service'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RoundedInputField(
                            backgroundColor: kPrimaryLightColor,
                            borderColor: kPrimaryColor,
                            textInputAction: TextInputAction.next,
                            focusNode: _amountFocusNode,
                            prefix: Text('₹   '),
                            hintText: 'Amount *',
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_amountTypeFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Amount is required.';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              _formData.amount = value;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldContainer(
                            width: mediaWidth * 0.8,
                            backgroundColor: kPrimaryLightColor,
                            borderColor: kPrimaryColor,
                            child: DropdownButtonFormField<String>(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              value: null,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              hint: Text('Payment Type *'),
                              isExpanded: true,
                              onChanged: (String value) {
                                setState(() {
                                  _formData.amountType = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Payment Type is required';
                                }
                                return null;
                              },
                              items: <String>[
                                'Cash',
                                'Online',
                                'Gpay'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              _pickDate();
                            },
                            child: TextFieldContainer(
                              vertical: 16,
                              width: mediaWidth * 0.8,
                              backgroundColor: kPrimaryLightColor,
                              borderColor: kPrimaryColor,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(!dateSelected
                                      ? 'Date *'
                                      : '${_formData.date.day}/${_formData.date.month}/${_formData.date.year}'),
                                  Icon(Icons.arrow_right),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    RoundedButton(
                      text: 'Submit',
                      primary: kBackgroundColor,
                      textColor: kWhite,
                      color: kPrimaryColor,
                      elevation: 10,
                      vertical: 20,
                      horizontal: 20,
                      width: mediaWidth * 0.5,
                      press: () {
                        _saveForm();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
