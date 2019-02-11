library PhotonAPI;

import 'dart:core';
import 'dart:io';
import 'dart:convert';

import 'address.dart';
import 'latLng.dart';

import 'package:http/http.dart' as http;

class PhotonAPI
{
	final String host;

	DateTime _lastRequest;

	PhotonAPI(this.host)
	{
		_lastRequest = DateTime.now().subtract(new Duration(milliseconds: 1000));
	}

	Future<Address> resolveSingle({String query, String lang = "en", Duration cooldown = const Duration(seconds: 1), bool verbose = false}) async
	{
		if (DateTime.now().millisecondsSinceEpoch - _lastRequest.millisecondsSinceEpoch > cooldown.inMilliseconds)
		{
			_lastRequest = DateTime.now();
			dynamic json;

			print("Resolving query '${query}' using get request => '${host}?q=${query}&lang=${lang}&limit=1'");

			http.Response s = await _fetchPost("${host}?q=${query}&lang=${lang}&limit=1");

			if (verbose)
			{
				print("JSON>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
				print(s.body);
				print("JSON^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
			}

			try
			{
				json = jsonDecode(s.body);
			}
			catch (e)
			{
				print("WARNING: Failed to parse photon json output.");
				return null;
			}

			if (json != null)
			{
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

					print("Resolved query \"${a.street} ${a.housenumber}, ${a.city} ${a.postcode}\"");
					return a;
				}


				print("Did not resolve query. :(");
				return null;
			}
		}
		else
			print("WARNING: Cooldown, your latest request was less than the cooldown duration. (${DateTime.now().millisecondsSinceEpoch - _lastRequest.millisecondsSinceEpoch}/${cooldown.inMilliseconds}ms)");
	
		return null;
	}

	Future<List<Address>> resolve({String query, String lang = "en", Duration cooldown = const Duration(seconds: 1), bool verbose = false}) async
	{
		if (DateTime.now().millisecondsSinceEpoch - _lastRequest.millisecondsSinceEpoch > cooldown.inMilliseconds)
		{
			_lastRequest = DateTime.now();
			dynamic json;
			List<Address> aList = new List<Address>();

			print("Resolving query '${query}' using get request => '${host}?q=${query}&lang=${lang}'");

			http.Response s = await _fetchPost("${host}?q=${query}&lang=${lang}");

			if (verbose)
			{
				print("JSON>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
				print(s.body);
				print("JSON^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
			}

			try
			{
				json = jsonDecode(s.body);
			}
			catch (e)
			{
				print("WARNING: Failed to parse photon json output.");
				return null;
			}

			if (json != null)
			{
				for (dynamic map in json['features'])
				{
					Address a;

					double lat = map['geometry']['coordinates'][1];
					double lng = map['geometry']['coordinates'][0];

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

				print("Resolved query with ${aList.length} entries");

				return aList;
			}
		}
		else
			print("WARNING: Cooldown, your latest request was less than the cooldown duration. (${DateTime.now().millisecondsSinceEpoch - _lastRequest.millisecondsSinceEpoch}/${cooldown.inMilliseconds}ms)");
	
		return null;
	}

	Future<http.Response> _fetchPost(String url) {
		return http.get(url);
	}
}