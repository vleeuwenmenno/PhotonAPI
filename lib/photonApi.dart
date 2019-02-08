library PhotonAPI;

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PhotonAPI
{
	void Request(String query)
	{
		HttpClient()
			.getUrl(Uri.parse('http://photon.komoot.de/api/?q=' + Uri.encodeComponent(query)))
			.then((request) => request.close())
			.then((response) => response.transform(Utf8Decoder()).listen(print));
	}
}