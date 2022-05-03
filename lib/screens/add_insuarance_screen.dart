import 'package:csr/models/car.dart';
import 'package:csr/services/cars.dart';
import 'package:csr/services/insuarances.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddInsuaranceScreen extends StatefulWidget {
  const AddInsuaranceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-insuarance-screen';

  @override
  State<AddInsuaranceScreen> createState() => _AddInsuaranceScreenState();
}

class _AddInsuaranceScreenState extends State<AddInsuaranceScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final _textEditingControllerName = TextEditingController();
    final _textEditingControllerDate = TextEditingController();
    bool isLoading = false;

    final car = ModalRoute.of(context)?.settings.arguments as Car;

    void _createCar() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      setState(() {
        isLoading = true;
      });

      final _apiResponse =
          await Provider.of<Insuarances>(context, listen: false)
              .createInsuarance(car.id, _textEditingControllerName.text,
                  _textEditingControllerDate.text);

      setState(() {
        isLoading = false;
      });
      if (_apiResponse.error == null) {
        // _saveAndRedirectToHome(_apiResponse.data as User);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
        title: const Text('New Insuarance'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(car.name),
              TextFormField(
                controller: _textEditingControllerName,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (val) => val!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _textEditingControllerDate,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Expire Date',
                  // border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val!.isEmpty ? 'Expire date  is required' : null,
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
