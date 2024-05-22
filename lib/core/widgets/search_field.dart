
import 'package:flutter/material.dart';



 Widget defaultFormField({required String hint,
  required Icon prefixIcon,
  required TextInputType textInputType,
   String? Function(String?)? validate,
  bool obscureText=false,
   IconData? suffixIcon,
   int?maxLines,
   TextEditingController?textEditingController,

  VoidCallback? suffixPressed
})=>TextFormField(

   keyboardType: textInputType,
   validator: validate,
   obscureText: obscureText,
   controller: textEditingController,
   maxLines:maxLines ,
   decoration: InputDecoration(
     contentPadding: const EdgeInsets.symmetric(horizontal: 18,),

    // prefixIconColor: MyColors.kBackGroundColor,
       hintStyle: const TextStyle(
         fontSize: 16,

       ),
       hintText: hint,
       suffixIcon: IconButton(
         onPressed: suffixPressed,
         icon: Icon(
             suffixIcon
         ),
       ),
       prefixIcon:prefixIcon,
         // color: primaryColor,
     border: InputBorder.none

        ),
 );

class DefaultFormField extends StatelessWidget {
   final String? hint;
   final Icon? prefixIcon;
   final TextInputType textInputType;
   final String? Function(String?)? validate;
   final bool? obscureText;
   final Icon? suffixIcon;
   final VoidCallback? suffixPressed;
   final Function(String?)? onSubmitted;
   final Widget?label;
   const DefaultFormField({
    super.key,
     this.hint,
     this.label,
     this.suffixPressed,
     this.prefixIcon,this.onSubmitted,required this.textInputType,this.validate,this.suffixIcon, this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmitted,
      keyboardType: textInputType,
      validator: validate,
      obscureText: obscureText??false,
      decoration: InputDecoration(
        label: label,
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),

          ),
    );
  }


}