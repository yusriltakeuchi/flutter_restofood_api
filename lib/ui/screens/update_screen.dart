import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restofood_sqlite/core/models/foods_mdl.dart';
import 'package:restofood_sqlite/core/services/foods_services.dart';
import 'package:restofood_sqlite/ui/widgets/custom_textfield.dart';

class UpdateScreen extends StatelessWidget {
  FoodModel foodModel;
  UpdateScreen({this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Update Food"),
      ),
      body: UpdateFood(
        foodModel: foodModel,
      ),
    );
  }
}

class UpdateFood extends StatefulWidget {
  FoodModel foodModel;
  UpdateFood({this.foodModel});

  @override
  _UpdateFoodState createState() => _UpdateFoodState();
}

class _UpdateFoodState extends State<UpdateFood> {
  File image;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var fullDescriptionController = TextEditingController();
  var priceController = TextEditingController();

  void imagePick() async {
    var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        image = _image;
      });
    }
  }

  void updateMakanan() async {
    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty
      && fullDescriptionController.text.isNotEmpty && priceController.text.isNotEmpty
    ) {
      FoodModel foodModel = FoodModel(
        title: titleController.text,
        description: descriptionController.text,
        fullDescription: fullDescriptionController.text,
        price: int.parse(priceController.text),
        image: image != null ? base64Encode(image.readAsBytesSync()) : widget.foodModel.image
      );

      var result = await FoodsServices.update(foodModel, widget.foodModel.id);

      //Jika sukses insert
      if (result) {
        Fluttertoast.showToast(
          msg: "Berhasil mengupdate makanan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0
        );

        Future.delayed(Duration(
          seconds: 1
        ), () {
          Navigator.pushNamedAndRemoveUntil(context, "/home", (Route<dynamic> routes) => false);
        });
        
      } else {
        Fluttertoast.showToast(
          msg: "Gagal mengupdate makanan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Silahkan isi semua bagian",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  void loadFood() {
    setState(() {
      titleController.text = widget.foodModel.title;
      descriptionController.text = widget.foodModel.description;
      fullDescriptionController.text = widget.foodModel.fullDescription;
      priceController.text = widget.foodModel.price.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadFood();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              child: InkWell(
                onTap: () => imagePick(),
                child: image == null ? 
                  Icon(Icons.add_photo_alternate, color: Colors.orange, size: 100,) :
                  Image.file(image, width: 100, height: 100,),
              ),
            ),
          ),

          SizedBox(height: 20),
          CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.text,
            controller: titleController,
            hintText: "Nama Makanan",
          ),
        
          SizedBox(height: 10),
          CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.text,
            controller: descriptionController,
            hintText: "Deskripsi",
          ),

          SizedBox(height: 10),
          CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.multiline,
            controller: fullDescriptionController,
            hintText: "Full Deskripsi",
          ),

          SizedBox(height: 10),
          CustomTextField(
            action: TextInputAction.done,
            type: TextInputType.number,
            controller: priceController,
            hintText: "Harga",
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () => updateMakanan(),
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text(
                "Update Makanan",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}