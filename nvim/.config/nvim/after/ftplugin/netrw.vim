nmap <buffer> l <CR>
nmap <buffer> h -
	
nmap <buffer> gf :lua require("telescope.builtin").find_files({ follow = true, hidden = true, no_ignore = true, no_ignore_parent = true })<CR>
