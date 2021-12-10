import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindgo_form/mobile.dart';
import 'package:mindgo_form/model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  var _autoValidate;
  InputBorder inputBorderDecoration = const OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xff04764E)));
  InputBorder errorInputBorderDecoration =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.red));
  final _formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormState>();
  final TextEditingController _productController = TextEditingController();

  FormModel newForm = FormModel(
      name: 'name',
      email: 'email',
      phone: 'phone',
      companyName: 'companyName',
      products: []);

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  void _saveForm() {
    _formKey.currentState!.save();
  }

  @override
  void dispose() {
    _productController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(13),
                child: SizedBox(
                  child: Image(image: AssetImage('assets/logo.png')),
                ),
              ),
              Form(
                key: _formKey,
                autovalidateMode: _autoValidate,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'please enter your full name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          newForm.name = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: inputBorderDecoration,
                          focusedBorder: inputBorderDecoration,
                          errorBorder: errorInputBorderDecoration,
                          focusedErrorBorder: errorInputBorderDecoration,
                          labelText: 'Name',
                          labelStyle: const TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateEmail(value),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          newForm.email = value!;
                        },
                        decoration: InputDecoration(
                          enabledBorder: inputBorderDecoration,
                          focusedBorder: inputBorderDecoration,
                          errorBorder: errorInputBorderDecoration,
                          focusedErrorBorder: errorInputBorderDecoration,
                          labelText: 'Email',
                          labelStyle: const TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone number';
                          } else if (value.length < 8) {
                            return 'Enter valid phone number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          newForm.phone = value!;
                        },
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          enabledBorder: inputBorderDecoration,
                          focusedBorder: inputBorderDecoration,
                          errorBorder: errorInputBorderDecoration,
                          focusedErrorBorder: errorInputBorderDecoration,
                          labelText: 'Phone',
                          labelStyle: const TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your Company Name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          newForm.companyName = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          enabledBorder: inputBorderDecoration,
                          focusedBorder: inputBorderDecoration,
                          errorBorder: errorInputBorderDecoration,
                          focusedErrorBorder: errorInputBorderDecoration,
                          labelText: 'Company name',
                          labelStyle: const TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13),
                      child: TextFormField(
                        validator: (value) {
                          if (newForm.products.isEmpty) {
                            return 'please enter at least 1 product';
                          }
                          return null;
                        },
                        controller: _productController,
                        decoration: InputDecoration(
                          suffix: TextButton(
                            onPressed: () {
                              if (_productController.text == '') {
                                return;
                              }
                              setState(() {
                                newForm.products
                                    .insert(0, _productController.text);
                                _productController.text = '';
                              });
                            },
                            child: const Text(
                              'Add',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          enabledBorder: inputBorderDecoration,
                          focusedBorder: inputBorderDecoration,
                          errorBorder: errorInputBorderDecoration,
                          focusedErrorBorder: errorInputBorderDecoration,
                          labelText: 'Products',
                          labelStyle: const TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff04764E), width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: ListView.builder(
                          itemCount: newForm.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(newForm.products[index]),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    newForm.products.removeAt(index);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, left: 15, bottom: 15),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: GenerateButton(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton GenerateButton() {
    return ElevatedButton(
      child: const Text('Generate PDF'),
      style: ElevatedButton.styleFrom(primary: const Color(0xff04764E)),
      onPressed: () async {
        _autoValidate = AutovalidateMode.onUserInteraction;
        FocusScope.of(context).unfocus();
        _saveForm();

        ////// Generating the Pdf :
        PdfDocument document = PdfDocument();
        final page = document.pages.add();
        page.graphics.drawImage(PdfBitmap(await _readImage('logo.png')),
            const Rect.fromLTRB(10, 70, 500, 190));
        page.graphics.drawString('Hello .. ${newForm.name}',
            PdfStandardFont(PdfFontFamily.timesRoman, 50));

        PdfGrid grid = PdfGrid();
        grid.columns.add(
          count: 2,
        );

        grid.style = PdfGridStyle(
            font: PdfStandardFont(PdfFontFamily.helvetica, 19),
            cellPadding: PdfPaddings(left: 7, right: 3, top: 2, bottom: 2));
        grid.headers.add(1);
        PdfGridRow header = grid.headers[0];
        header.cells[0].value = 'Information';
        PdfGridRow row = grid.rows.add();
        row.cells[0].value = 'Name';
        row.cells[1].value = newForm.name;

        row = grid.rows.add();
        row.cells[0].value = 'Email';
        row.cells[1].value = newForm.email;

        row = grid.rows.add();
        row.cells[0].value = 'Phone';
        row.cells[1].value = newForm.phone;

        row = grid.rows.add();
        row.cells[0].value = 'Company';
        row.cells[1].value = newForm.companyName;

        row = grid.rows.add();
        row.cells[0].value = 'Products';
        row.cells[1].value = newForm.products.toString();

        grid.draw(
          page: document.pages.add(),
          bounds: const Rect.fromLTWH(0, 0, 0, 0),
        );
        List<int> bytes = document.save();
        document.dispose();

        await saveAndLaunchFile(bytes, 'Mindgo.pdf');
      },
    );
  }

  Future<Uint8List> _readImage(String name) async {
    final data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
