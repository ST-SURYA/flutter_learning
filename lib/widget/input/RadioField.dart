import 'package:flutter/material.dart';

class RadioFormField<T> extends FormField<T> {
  RadioFormField({
    Key? key,
    required List<FormFieldOption<T>> options,
    T? initialValue,
    required String? Function(T?) validator,
    void Function(T?)? onChanged,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
          key: key,
          initialValue: initialValue,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<T> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Horizontal radio buttons row
                Row(
                  children: [
                    ...options.map((option) {
                      return Row(
                        children: [
                          Radio<T>(
                            value: option.value,
                            groupValue: state.value,
                            onChanged: (value) {
                              state.didChange(value);
                              if (onChanged != null) {
                                onChanged(value);
                              }
                            },
                          ),
                          Text(option.label),
                        ],
                      );
                    }).toList(),
                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      state.errorText ?? '',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        );
}

class FormFieldOption<T> {
  final T value;
  final String label;

  FormFieldOption({required this.value, required this.label});
}
