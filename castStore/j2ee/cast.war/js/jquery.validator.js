jQuery.fn.extend({
	validator: function (options) {
		return this.each(function() {
			new jQuery.validator(this, options);
		});
	}
});

jQuery.validator = function (_obj, _options) {

	var curVal = _options.obj.value.toLowerCase();	
	var origVal = _options.obj.value;  													
	
	var val = check(curVal, _options);
	
	$(_obj).children(".passVerif").text("")
	$(_obj).children(".passVerif").removeClass().addClass("passVerif");
	
	if (val == 1) {
		$(_obj).children(".passVerif:eq(0)").text("faible").addClass("pwdRed");		
	} else if (val == 2) {
		$(_obj).children(".passVerif:eq(0)").addClass("pwdOrange");
		$(_obj).children(".passVerif:eq(1)").text("moyen").addClass("pwdOrange");
		
	} else if (val == 3) {
		$(_obj).children(".passVerif:eq(0)").addClass("pwdGreen");
		$(_obj).children(".passVerif:eq(1)").addClass("pwdGreen");
		$(_obj).children(".passVerif:eq(2)").text("fort").addClass("pwdGreen");
	} 
			 				 	
	
	function check(curVal, _options) {	
		
		if (!origVal) { return 0; }
		
		for (i = 0; i < _options.param.length; i++) {			
			var substr = $("#"+_options.param[i]).val().replace(/\@(\S)+$/, "").toLowerCase();					
			if (substr && curVal.indexOf(substr) != -1) {												
				return 1; 				
			}
		}			 
			 
		if (/^([a-zàâçèéêëîïôùûüÿ])+$/.test(curVal)) {		
			return 1;
		} else if (/[a]{6,}|[b]{6,}|[c]{6,}|[d]{6,}|[e]{6,}|[f]{6,}|[g]{6,}|[h]{6,}|[i]{6,}|[j]{6,}|[k]{6,}|[l]{6,}|[m]{6,}|[n]{6,}|[o]{6,}|[p]{6,}|[q]{6,}|[r]{6,}|[s]{6,}|[t]{6,}|[u]{6,}|[v]{6,}|[w]{6,}|[x]{6,}|[y]{6,}|[z]{6,}|[à]{6,}|[â]{6,}|[ç]{6,}|[è]{6,}|[é]{6,}|[ê]{6,}|[ë]{6,}|[î]{6,}|[ï]{6,}|[ô]{6,}|[ù]{6,}|[û]{6,}|[ü]{6,}|[ÿ]{6,}/.test(curVal)){
			return 1;
		}							
		
		var alphabet = new Array();
		alphabet[0] = "qwertyuiopasdfghjklzxcvbnm";
		alphabet[1] = "1234567890";
		alphabet[2] = "azertyuiopqsdfghjklmwxcvbn";
		
		for (i = 0; i < alphabet.length; i++) {
			for(j = 0; j < alphabet[i].length - 5; j++) {
				if (curVal.indexOf(alphabet[i].substr(j, 5)) != -1) {
					return 1;
				}
			}
		}						
								
		if (origVal.length < 6) {			
			return 1;
		} else if (!/[0-9A-ZÀÂÇÈÉÊËÎÏÔÙÛÜŸ]/.test(origVal)) {
			return 1;
		} else {		
			var numbers = origVal.replace(/[\D]/g, "");			
			var largechar = origVal.replace(/[^A-ZÀÂÇÈÉÊËÎÏÔÙÛÜŸ]/g, "");						
			if (numbers.length > 1 && largechar.length > 1 && origVal.length >= 8) {
				return 3;
			} else if (numbers.length > 0 && largechar.length > 0) {
				return 2
			} else {
				return 1;
			}			
		}
		
			
		
		return 0;
	} 
}