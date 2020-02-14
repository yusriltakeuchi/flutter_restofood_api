import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restofood_api/core/models/foods_mdl.dart';
import 'package:restofood_api/core/services/food_services.dart';
import 'package:restofood_api/core/utils/toast_utils.dart';
import 'package:restofood_api/ui/widgets/custom_textfield.dart';

class UpdateScreen extends StatelessWidget {
  FoodModel foodModel;
  UpdateScreen({this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Update Food", style: TextStyle(color: Colors.white)),
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

  void updateFoods() async {
    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty
    && fullDescriptionController.text.isNotEmpty && priceController.text.isNotEmpty
    && image != null
    ) {
       
      var foodData = FoodModel(
        title: titleController.text,
        description: descriptionController.text,
        fullDescription: fullDescriptionController.text,
        price: int.parse(priceController.text),
        imageFile: await MultipartFile.fromFile(image.path)
      );

      FoodResponse response = await FoodServices.updateFood(foodData, widget.foodModel.id);
      if (response.status == 200) {
        ToastUtils.show(response.message);
        Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (Route<dynamic> routes) => false);
      } else {
        ToastUtils.show(response.message);
      }
    } else {
      ToastUtils.show("Silahkan isi semua field");
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
              onPressed: () => updateFoods(),
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