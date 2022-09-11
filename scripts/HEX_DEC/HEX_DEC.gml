/// @desc 十六进制 转换 十进制
/// @param {string} str 输入一个 16进制 字符串
/// @returns {real} 返回一个 10进制 数字
function HEXtoDEC(str) {
	var temp = "";
	var j = 0;
	var res = 0;
	
	for(var i = string_length(str); i > 0; i--) {
		var t = string_char_at(str, i);
		var m = 0;
		switch(t) {
			case "0":
			case "1":
			case "2":
			case "3":
			case "4":
			case "5":
			case "6":
			case "7":
			case "8":
			case "9":
				m = real(t);
				break;
			case "A":
				m = 10;
				break;
			case "B":
				m = 11;
				break;
			case "C":
				m = 12;
				break;
			case "D":
				m = 13;
				break;
			case "E":
				m = 14;
				break;
			case "F":
				m = 15;
				break;
		}
		res += m * power(16, j);
		j++;
	}
	
	return res;
}

/// @desc 十进制 转换 十六进制
/// @param {real} num 输入一个 10进制 数字
/// @returns {string} 返回一个 16进制 字符串
function DECtoHEX(num) {
	if(num < 0) {
		return "ERROR!";
	}
	
	if(num == 0) {
		return "0";
	}
	
	var n = num, m; // n 表示 商，m 表示 余数
	var res = "";
	
	while(n != 0) {
		m = n % 16;
		n = floor(n / 16);
		
		if(m < 10) {
			res += string(m);
		} else {
			switch(m) {
				case 10:
					res += "A";
					break;
				case 11:
					res += "B";
					break;
				case 12:
					res += "C";
					break;
				case 13:
					res += "D";
					break;
				case 14:
					res += "E";
					break;
				case 15:
					res += "F";
					break;
			}
		}
	}
	
	var resFinal = "";
	for(var i = string_length(res); i > 0; i--) {
		resFinal += string_char_at(res, i);
	}
	
	return resFinal;
}

// show_message(DECtoHEX(114514));

// show_message(HEXtoDEC("1BF52"));

