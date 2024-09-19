set use_sing_box $argv[1]
set proxy_addr ""

if test $use_sing_box = "1"
	set proxy_addr "http://127.0.0.1:20122"
end

set --export http_proxy $proxy_addr
set --export https_proxy $proxy_addr
