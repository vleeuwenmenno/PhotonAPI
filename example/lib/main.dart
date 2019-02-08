import 'package:PhotonAPI/photonApi.dart';
import 'package:PhotonAPI/address.dart';
import 'package:PhotonAPI/latLng.dart';

void main(List<String> args) async
{
	PhotonAPI api = new PhotonAPI("http://photon.komoot.de/api/");
	List<Address> output = await api.resolve("Maerelaan 26");

	print(output);
}