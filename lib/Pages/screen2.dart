import 'package:flutter/material.dart';
import 'package:wifi_hd_camera_app/Pages/screen3.dart';

class Country_list extends StatefulWidget {
  const Country_list({super.key});

  @override
  State<Country_list> createState() => _Country_listState();
}

class _Country_listState extends State<Country_list> {
  List<String> countryNames = [
    'Afghanistan',
    'Algeria',
    'Angola',
    'Argentina',
    'Australia',
    'Azerbaijan',
    'Bangladesh',
    'Belarus',
    'Belgium',
    'Benin',
    'Bolivia',
    'Brazil',
    'Burkina Faso',
    'Burundi',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Cuba',
    'Czech Republic',
    'DR Congo',
    'Dominican Republic',
    'Ecuador',
    'Egypt',
    'Ethiopia',
    'France',
    'Germany',
    'Ghana',
    'Greece',
    'Guatemala',
    'Guinea',
    'Haiti',
    'Honduras',
    'Hungary',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Israel',
    'Italy',
    'Ivory Coast',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Mali',
    'Mexico',
    'Morocco',
    'Mozambique',
    'Myanmar (Burma)',
    'Nepal',
    'Netherlands',
    'Niger',
    'Nigeria',
    'North Korea',
    'Pakistan',
    'Papua New Guinea',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Romania',
    'Russia',
    'Rwanda',
    'Saudi Arabia',
    'Senegal',
    'Somalia',
    'South Africa',
    'South Korea',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Turkey',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uzbekistan',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
  ];

  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: const Text("Select Your Country or Region"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: countryNames.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => gender()));
                },
                title: Text(
                  countryNames[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Radio<String>(
                  activeColor: Colors.blue,
                  value: countryNames[index],
                  groupValue: selectedCountry,
                  onChanged: (value) {
                    setState(() => selectedCountry = value);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
