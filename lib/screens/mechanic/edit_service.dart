import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/helpers/my_loader.dart';
import 'package:mechanic/models/service_model.dart';
import 'package:mechanic/providers/auth_provider.dart';
import 'package:mechanic/providers/mechanic_provider.dart';
import 'package:provider/provider.dart';

class EditServiceScreen extends StatefulWidget {
  const EditServiceScreen({Key? key, required this.service}) : super(key: key);
  final ServiceModel service;

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  String? name, price;
  File? imageFile;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mechanicId =
        Provider.of<AuthProvider>(context, listen: false).mechanic!.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Service'),
        backgroundColor: kPrimaryColor,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
                child: Column(children: [
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width,
                    child: Image.network(
                      widget.service.imageUrl!,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300]),
                    child: TextFormField(
                        initialValue: widget.service.serviceName!,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter the name of the service';
                          }

                          return null;
                        },
                        maxLength: null,
                        maxLines: null,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            labelText: 'Name of service',
                            helperStyle: const TextStyle(color: kPrimaryColor),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 1)),
                            border: InputBorder.none),
                        onChanged: (text) => {
                              setState(() {
                                name = text;
                              })
                            }),
                  ),
                  Container(
                    width: size.width,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300]),
                    child: TextFormField(
                        initialValue: widget.service.price!,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter the name of the service';
                          }

                          return null;
                        },
                        maxLength: null,
                        maxLines: null,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            labelText: 'Price of service',
                            helperStyle: const TextStyle(color: kPrimaryColor),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kPrimaryColor, width: 1)),
                            border: InputBorder.none),
                        onChanged: (text) => {
                              setState(() {
                                price = text;
                              })
                            }),
                  ),
                  const Spacer(),
                  Container(
                      height: 48,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: RaisedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await Provider.of<MechanicProvider>(context,
                                    listen: false)
                                .editService(
                                    ServiceModel(
                                      id: widget.service.id,
                                      imageFile: imageFile,
                                      price: price ?? widget.service.price,
                                      serviceName:
                                          name ?? widget.service.serviceName,
                                    ),
                                    mechanicId!,
                                    widget.service);
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: const Text('Service edited'),
                                backgroundColor: kPrimaryColor,
                              ),
                            );
                          } catch (e) {
                            print(e);
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        color: kPrimaryColor,
                        child: isLoading
                            ? MyLoader()
                            : const Text(
                                'Save Changes',
                                style: TextStyle(color: Colors.white),
                              ),
                      ))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
