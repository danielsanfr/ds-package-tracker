function getIcon(situation) {
	var curerntSituation = new String();
	curerntSituation = situation;
	curerntSituation = curerntSituation.toLowerCase();
	if (curerntSituation.indexOf("postado", 0) != -1)
		return "asset:///images/stt_external_moving.png";
	else if (curerntSituation.indexOf("em tr", 0) != -1)
		return "asset:///images/stt_external_moving.png";
	else if (curerntSituation.indexOf("encaminhado", 0) != -1)
		return "asset:///images/stt_in_transit.png";
	else if (curerntSituation.indexOf("saiu para entrega", 0) != -1)
		return "asset:///images/stt_out_for_delivery.png";
	else if (curerntSituation.indexOf("entrega efetuada", 0) != -1)
		return "asset:///images/stt_delivered.png";
	else if (curerntSituation.indexOf("aguardando retirada", 0) != -1)
		return "asset:///images/stt_waiting.png";
	else if (curerntSituation.indexOf("conferido", 0) != -1)
		return "asset:///images/stt_conferred.png";
	else if (curerntSituation.indexOf("recebido", 0) != -1)
		return "asset:///images/stt_conferred.png";
	else if (curerntSituation.indexOf("no informat", 0) != -1)
		return "asset:///images/stt_no_informations.png";
	else if (curerntSituation.indexOf("com numera", 0) != -1)
		return "asset:///images/stt_no_informations.png";
	else if (curerntSituation.indexOf("tribut", 0) != -1)
		return "asset:///images/stt_taxed.png";
	else if (curerntSituation.indexOf("taxa", 0) != -1)
		return "asset:///images/stt_taxed.png";
//	else if (curerntSituation.indexOf("", 0) != -1)
//		return "asset:///images/";
//	else if (curerntSituation.indexOf("", 0) != -1)
//		return "asset:///images/";
//	else if (curerntSituation.indexOf("", 0) != -1)
//		return "asset:///images/";
	return "asset:///images/stt_no_informations.png";
}
function getColor(situation) {
	var curerntSituation = new String();
	curerntSituation = situation;
	curerntSituation = curerntSituation.toLowerCase();
	if (curerntSituation.indexOf("postado", 0) != -1)
		return Color.Yellow;
	else if (curerntSituation.indexOf("em tr", 0) != -1)
		return Color.Yellow;
	else if (curerntSituation.indexOf("encaminhado", 0) != -1)
		return Color.Blue;
	else if (curerntSituation.indexOf("saiu para entrega", 0) != -1)
		return Color.Blue;
	else if (curerntSituation.indexOf("entrega efetuada", 0) != -1)
		return Color.Green;
	else if (curerntSituation.indexOf("aguardando retirada", 0) != -1)
		return Color.Red;
	else if (curerntSituation.indexOf("conferido", 0) != -1)
		return Color.Yellow;
	else if (curerntSituation.indexOf("recebido", 0) != -1)
		return Color.Yellow;
	else if (curerntSituation.indexOf("no informat", 0) != -1)
		return Color.Black;
	else if (curerntSituation.indexOf("com numera", 0) != -1)
		return Color.Black;
	else if (curerntSituation.indexOf("tribut", 0) != -1)
		return Color.Black;
	else if (curerntSituation.indexOf("taxa", 0) != -1)
		return Color.Black;
//	else if (curerntSituation.indexOf("", 0) != -1)
//		return "asset:///images/";
//	else if (curerntSituation.indexOf("", 0) != -1)
//		return "asset:///images/";
//	else if (curerntSituation.indexOf("", 0) != -1)
//		return "asset:///images/";
//	else if (curerntSituation.indexOf("", 0) != -1)
//		return "asset:///images/";
//	else if (curerntSituation.indexOf("", 0) != -1)
//		return "asset:///images/";
	return Color.Black;
}