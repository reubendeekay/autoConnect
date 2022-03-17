import 'package:flutter/material.dart';
import 'package:mechanic/helpers/cached_image.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/models/service_model.dart';

class ServiceTile extends StatefulWidget {
  final ServiceModel service;
  const ServiceTile(this.service, {Key? key}) : super(key: key);
  @override
  _ServiceTileState createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      constraints: const BoxConstraints(minHeight: 70),
      child: Column(
        children: [
          Expanded(
              child: Row(
            children: [
              SizedBox(
                width: size.width * 0.25,
                child: widget.service.imageUrl != null
                    ? cachedImage(
                        widget.service.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        widget.service.imageFile!,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.service.serviceName!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.service.price!,
                    style: const TextStyle(color: kPrimaryColor),
                  ),
                ],
              ))
            ],
          )),
          const Divider()
        ],
      ),
    );
  }
}
