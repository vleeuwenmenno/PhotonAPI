import 'latLng.dart';

class Address
{
	Address({
		this.coordinates,

		this.osm_key,
		this.osm_value,
		this.osm_type,

		this.name,
		
		this.country,

		this.street,
		this.housenumber,

		this.city,
		this.postcode,
		this.state
	});

	final LatLng coordinates;

	final String osm_key;
	final String osm_value;
	final String osm_type;

	final String name;

	final String country;

	final String street;
	final String housenumber;

	final String city;
	final String postcode;
	final String state;
}