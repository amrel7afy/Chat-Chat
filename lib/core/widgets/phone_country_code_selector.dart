import 'package:new_chat_with_me/core/theming/my_colors.dart';
import 'package:new_chat_with_me/core/widgets/vertical_and_horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constants/methods.dart';
import '../../../../../core/theming/styles.dart';

class PhoneCountryCodeSelector extends StatefulWidget {
  final Color? backGroundColor;
  const PhoneCountryCodeSelector({super.key, this.backGroundColor});

  @override
  State<PhoneCountryCodeSelector> createState() => _PhoneCountryCodeSelectorState();
}

class _PhoneCountryCodeSelectorState extends State<PhoneCountryCodeSelector> {
  Country selectedCountry = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Egypt',
    example: 'Egypt',
    displayName: 'Egypt',
    displayNameNoCountryCode: 'EG',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(

      borderRadius: BorderRadius.circular(20),
      onTap: () {
        showCountryPicker(
          context: context,
          onSelect: (Country country) {
            setState(() {
              selectedCountry = country;
            });
          },countryListTheme:CountryListThemeData(
          backgroundColor: widget.backGroundColor??Colors.white,
            bottomSheetHeight: getHeight(context) * .7)

        );
      },
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: SizedBox(
          width: 80.w,
          child: Row(
            children: [
              Text(
                selectedCountry.flagEmoji,
                style: MyTextStyles.font20Weight700,
              ),
               const HorizontalSpacer(8),
              const Icon(FontAwesomeIcons.chevronDown,size: 15.6,color: MyColors.kPrimaryColor,),
               const HorizontalSpacer(16.3),
              SizedBox(height :24.h,child: const VerticalDivider())
            ],
          ),
        ),
      ),
    );
  }
}
