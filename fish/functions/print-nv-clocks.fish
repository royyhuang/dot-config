function print-nv-clocks
    nvidia-smi --query-gpu=index,timestamp,power.draw,clocks.sm,clocks.mem,clocks.gr,clocks.max.sm,clocks.max.mem,clocks.max.gr --format=csv
end

