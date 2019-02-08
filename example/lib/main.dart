import 'package:PhotonAPI/photonApi.dart';
import 'package:PhotonAPI/address.dart';

void main(List<String> args) async
{
	PhotonAPI api = new PhotonAPI("http://photon.komoot.de/api/");
	List<Address> addresses = await api.resolve(query: "Zijlweg");

	print("Resolve output: ");
	for (Address a in addresses)
	{
		print("${a.street} ${a.housenumber}, ${a.city} ${a.postcode}"); 
	}
}