import 'package:csr/services/cars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);
  static const routeName = '/add-car-screen';

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final _textEditingControllerName = TextEditingController();
    final _textEditingControllerPlateNo = TextEditingController();
    bool isLoading = false;

    void _createCar() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      setState(() {
        isLoading = true;
      });

      final _apiResponse = await Provider.of<Cars>(context, listen: false)
          .createCar(_textEditingControllerName.text,
              _textEditingControllerPlateNo.text);

      setState(() {
        isLoading = false;
      });
      if (_apiResponse.error == null) {
        // _saveAndRedirectToHome(_apiResponse.data as User);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Created successfully'),
        ));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${_apiResponse.error}'),
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New List'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _textEditingControllerName,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Car Name',
                ),
                validator: (val) =>
                    val!.isEmpty ? 'Name of car is required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _textEditingControllerPlateNo,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Plate Number',
                  // border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val!.isEmpty ? 'Plate number is required' : null,
                onFieldSubmitted: (_) => _createCar(),
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: _createCar,
                      child: const Text('Create ')),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
