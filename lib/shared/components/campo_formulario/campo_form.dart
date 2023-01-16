import 'package:flutter/material.dart';

class CampoForm extends StatefulWidget {
  String? label;
  String? Function(String?)? validator;
  TextEditingController? controller;
  TextInputType? tipoTeclado;
  AutovalidateMode? validatemode;
  bool? obscure;

  CampoForm(
      {Key? key,
      this.label,
      this.validator,
      this.controller,
      this.tipoTeclado,
      this.validatemode,
      this.obscure})
      : super(key: key);

  @override
  State<CampoForm> createState() => _CampoFormState();
}

class _CampoFormState extends State<CampoForm> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (_) => setState(() {}),
      maxLength: 60,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.tipoTeclado,
      autovalidateMode: widget.validatemode!,
      obscureText: widget.obscure == true ? _isObscure : widget.obscure!,
      cursorColor: const Color.fromARGB(255, 197, 197, 197),
      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      decoration: InputDecoration(
        suffixIcon: widget.obscure == true
            ? widget.controller!.value.text.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: TextButton(
                      child: _isObscure
                          ? const Text(
                              "MOSTRAR",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141)),
                            )
                          : const Text(
                              "OCULTAR",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141)),
                            ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      onFocusChange: (_) {},
                    ),
                  )
                : null
            : null,
        errorStyle: const TextStyle(fontSize: 10),
        filled: true,
        fillColor: const Color.fromARGB(255, 91, 90, 90),
        labelText: widget.label,
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 197, 197, 197),
            fontSize: 16,
            height: 4,
            backgroundColor: Colors.transparent),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: Colors.green)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}
