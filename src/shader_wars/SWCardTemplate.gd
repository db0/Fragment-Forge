extends Card

func check_play_costs() -> bool:
	var ret := true
	if properties.get("Time", 0) > cfc.NMAP.board.counters.get_counter("time"):
		ret = false
	if properties.get("skill_req", 0) > cfc.NMAP.board.counters.get_counter("skill"):
		ret = false
	if properties.get("cred_req", 0) > cfc.NMAP.board.counters.get_counter("cred"):
		ret = false
	if properties.get("motivation_req", 0) > cfc.NMAP.board.counters.get_counter("motivation"):
		ret = false
	return(ret)

func common_move_scripts(new_container: Node, old_container: Node) -> void:
	if new_container == cfc.NMAP.board and old_container == cfc.NMAP.hand:
		cfc.NMAP.board.counters.mod_counter("time", -properties.get("Time",0))
		cfc.NMAP.board.counters.mod_counter("cred", -properties.get("Cred",0))
