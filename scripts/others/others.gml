function DebugMes(str) {
	str = string(str);
	show_debug_message(object_get_name(object_index) + "-" + string(id) + ": " + str);
}

