$(document).ready(function() {
	$("#e3").change(function() {
		if ($(this).val() == "") {
			$("#e2").val("");
		} else if ($(this).val() == "direct") {
			$("#e2").val("");
			$("#e2").focus("");
		} else {
			$("#e2").val($(this).val());
		}
	});
});