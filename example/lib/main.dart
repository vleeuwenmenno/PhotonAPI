import 'package:PhotonAPI/photonApi.dart';
import 'package:PhotonAPI/address.dart';

void main(List<String> args) async
{
	PhotonAPI api = new PhotonAPI("http://photon.komoot.de/api/");
	List<Address> addresses = await api.resolve(
											query: "Zeestraat", 
											verbose: true,
											lang: "en"
										);

	print("Resolve multi output: ");
	for (Address a in addresses)
	{
		print("${a.name} ${a.housenumber}, ${a.city} ${a.postcode}"); 
	}

	Address a = await api.resolveSingle(
									query: "Zijlweg", 
									verbose: true,
									lang: "en"
								);

	print("Resolve single output: ");
	print("${a.street} ${a.housenumber}, ${a.city} ${a.postcode}"); 
}