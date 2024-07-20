import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWalkingCount extends StatefulWidget {
  const InputWalkingCount({super.key});

  @override
  State<InputWalkingCount> createState() => _InputWalkingCountState();
}

class _InputWalkingCountState extends State<InputWalkingCount> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  int phoneNumber = 0;
  String place = '';
  int walkingCount = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "이만큼 걸었어요!",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Form(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  renderTextFormField(
                    label: '이름 (함께한 분들도 같이 적어주세요)',
                    onSaved: (val) {
                      setState(() {
                        name = val;
                      });
                    },
                    validator: (val) {
                      if (val.length < 1) {
                        return '이름을 입력해주세요.';
                      }
                      return null;
                    },
                  ),
                  renderTextFormField(
                    isNumberType: true,
                    label: '전화번호 뒷자리',
                    onSaved: (val) {
                      setState(() {
                        phoneNumber = int.tryParse(val) ?? 0;
                      });
                    },
                    validator: (val) {
                      if (val.length < 4) {
                        return '전화번호 뒷자리는 4자리 입력해주세요.';
                      }
                      return null;
                    },
                  ),
                  renderTextFormField(
                    label: '사역지',
                    onSaved: (val) {
                      setState(() {
                        place = val;
                      });
                    },
                    validator: (val) {
                      return null;
                    },
                  ),
                  renderTextFormField(
                    isNumberType: true,
                    label: '걸음 수',
                    onSaved: (val) {
                      setState(() {
                        walkingCount = int.tryParse(val) ?? 0;
                      });
                    },
                    validator: (val) {
                      if (val.length < 1) {
                        return '걸음 수는 꼭 입력해주세요.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  renderButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  renderTextFormField({
    bool isNumberType = false,
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        TextFormField(
          keyboardType:
              isNumberType ? TextInputType.number : TextInputType.none,
          inputFormatters: isNumberType
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onSaved: onSaved,
          validator: validator,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  renderButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2f72ba),
      ),
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        if (_formKey.currentState!.validate()) {
          // save validated values
          _formKey.currentState?.save();

          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('저장완료!'),
            ),
          );
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          widthFactor: double.infinity,
          child: Text(
            '저장하기',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  renderValues() {
    return Column(
      children: [
        Text('name: $name'),
        Text('phoneNumber: $phoneNumber'),
        Text(
          'place: $place',
        ),
        Text(
          'walkingCount: $walkingCount',
        ),
      ],
    );
  }
}
