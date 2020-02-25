import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:restofood_api/core/models/city_model.dart';
import 'package:restofood_api/core/services/auth_services.dart';
import 'package:restofood_api/core/services/city_services.dart';
import 'package:restofood_api/core/utils/toast_utils.dart';
import 'package:restofood_api/ui/widgets/input_field.dart';
import 'package:restofood_api/ui/widgets/primary_button.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: RegisterBody()
        ),
      ),
    );
  }
}

class RegisterBody extends StatefulWidget {

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var emailController = TextEditingController();
  var namaController = TextEditingController();
  var nikController = TextEditingController();
  var tanggalController = TextEditingController();
  var alamatController = TextEditingController();
  var jenisKelaminController = TextEditingController();
  var kotaController = TextEditingController();

  List<CityModel> cityList;
  File image;

  void register() async {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty
      && confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty
      && namaController.text.isNotEmpty && nikController.text.isNotEmpty 
      && tanggalController.text.isNotEmpty && alamatController.text.isNotEmpty
      && jenisKelaminController.text.isNotEmpty && kotaController.text.isNotEmpty
      && image != null
    ) {

      if (passwordController.text == confirmPasswordController.text) {
        //call aPI Register
        Map<String, dynamic> data = {
          "username": usernameController.text,
          "password": passwordController.text,
          "email": emailController.text,
          "nama": namaController.text,
          "nik": nikController.text,
          "tanggal_lahir": tanggalController.text,
          "alamat": alamatController.text,
          "image": await MultipartFile.fromFile(image.path),
          "jenis_kelamin": jenisKelaminController.text,
          "kota": kotaController.text
        };

        ToastUtils.show("Mencoba Mendaftar");
        var response = await AuthServices.register(data);
        if (response.status == 201) {
          ToastUtils.show(response.message);
          Navigator.pop(context);
        } else {
          ToastUtils.show(response.message);
        }

      } else {
        ToastUtils.show("Password tidak sama");
      }
    } else {
      ToastUtils.show("Silahkan isi semua field");
    }
  }

  void pickTanggal() {
    showMaterialDatePicker(
      context: context,
      selectedDate: DateTime.now(),
      onChanged: (value) {
        tanggalController.text = DateFormat('yyyy-MM-dd').format(value);
      },
    );
  }

  void pickGender() {
    List<String> genderList = <String>[
      'Laki-Laki',
      'Perempuan',
    ];

    showMaterialRadioPicker(
      context: context,
      title: "Pilih Gender",
      items: genderList,
      onChanged: (value) {
        jenisKelaminController.text = value;
      },
    );
  }

  void pickCity() {
    if (cityList != null) {
      showMaterialScrollPicker(
        context: context,
        title: "Pilih Kota",
        items: cityList.map((x) => x.name).toList(),
        onChanged: (value) {
          kotaController.text = value;
        },
      );
    }
  }

  void pickImage() async {
    var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        image = _image;
      });
    }
  }

  void getCity() async {
    cityList = new List<CityModel>();
    var _city = await CityServices.getAll();
    setState(() {
      cityList = _city;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getCity();
  }
  @override
  Widget build(BuildContext context) {

    //Jika masih proses ambil data city
    if (cityList == null) {
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    ),
                  ),
                ),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 35, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () => pickImage(),
                  child: image == null 
                    ? Icon(Icons.account_circle, size: 70, color: Colors.white)
                    : Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        image: DecorationImage(
                          image: ExactAssetImage(image.path)
                        )
                      ),
                    )
                )
              ],
            ),
          )
        ),

        //Bagian field Register
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: <Widget>[
              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: usernameController,
                hintText: "Username",
              ),
              SizedBox(height: 10),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: passwordController,
                hintText: "Password",
                secureText: true,
              ),
              SizedBox(height: 15),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                secureText: true,
              ),
              SizedBox(height: 15),
              
              InputField(
                action: TextInputAction.done,
                type: TextInputType.emailAddress,
                controller: emailController,
                hintText: "Email Address",
              ),
              SizedBox(height: 10),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: namaController,
                hintText: "Nama Lengkap",
              ),
              SizedBox(height: 10),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.number,
                controller: nikController,
                hintText: "NIK",
              ),
              SizedBox(height: 10),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: tanggalController,
                hintText: "Tanggal",
                readOnly: true,
                onTap: () => pickTanggal(),
              ),
              SizedBox(height: 10),

              InputField(
                action: TextInputAction.newline,
                type: TextInputType.multiline,
                controller: alamatController,
                hintText: "Alamat",
              ),
              SizedBox(height: 10),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: jenisKelaminController,
                readOnly: true,
                hintText: "Jenis Kelamin",
                onTap: () => pickGender(),
              ),
              SizedBox(height: 10),

              InputField(
                action: TextInputAction.done,
                type: TextInputType.text,
                controller: kotaController,
                readOnly: true,
                hintText: "Kota",
                onTap: () => pickCity(),
              ),
              SizedBox(height: 10),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: PrimaryButton(
                  color: Colors.orange,
                  text: "REGISTER",
                  onClick: () => register(),
                ),
              ),
              SizedBox(height: 30),
              
            ],
          ),
        )


      ],
    );
  }
}