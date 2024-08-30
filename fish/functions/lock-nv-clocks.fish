function lock-nv-clocks
	for i in (nvidia-smi --query-gpu=index --format=csv,noheader,nounits)
		set --local max_gr (nvidia-smi \
			--query-gpu=clocks.max.gr \
			--format=csv,noheader,nounits \
			-i $i
		)
		nvidia-smi -lgc $max_gr -i $i
	end
end
