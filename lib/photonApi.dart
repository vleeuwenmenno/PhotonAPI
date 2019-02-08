library PhotonAPI;

import 'dart:core';
import 'dart:io';
import 'dart:convert';

import 'address.dart';
import 'latLng.dart';

class PhotonAPI
{
	final String host;

	PhotonAPI(this.host);

	Future<List<Address>> resolve(String query) async
	{
		String jsonString = "";
		List<Address> aList = new List<Address>();
		print("Resolving query '${query}' using get request => '${host}?q=${query}'");

		var request = await HttpClient().getUrl(Uri.parse('${host}?q=${query}'));
		var response = await request.close(); 

		await for (var contents in response.transform(Utf8Decoder())) 
		{
			jsonString = contents;
		}

		dynamic json = jsonDecode(jsonString);

		for (dynamic map in json['features'])
		{
			Address a;

			double lat = map['geometry']['coordinates'][0];
			double lng = map['geometry']['coordinates'][1];

			String osm_key = map['properties']['osm_key'];
			String osm_value = map['properties']['osm_value'];
			String osm_type = map['properties']['osm_type'];

			String name = map['properties']['name'];

			String country = map['properties']['country'];

			String street = map['properties']['street'];
			String housenumber = map['properties']['housenumber'];

			String city = map['properties']['city'];
			String postcode = map['properties']['postcode'];
			String state = map['properties']['state'];

			LatLng latLng = new LatLng(lat, lng);
			
			a = new Address(
				osm_key: osm_key,
				osm_value: osm_value,
				osm_type: osm_type,

				name: name,

				country: country,

				street: street,
				housenumber: housenumber,

				city: city,
				postcode: postcode,
				state: state,

				coordinates: latLng
			);

			aList.add(a);
		}

		return aList;
	}
}