function rsync-code-repo
	if set -q ALCHEMISTS_HOME
		rsync -avz --delete \
			--exclude='.git' \
			--exclude='**/__pycache__' \
			$ALCHEMISTS_HOME/ \
			yuyangh@heart.cs.uchicago.edu:/data/yuyangh/alchemists
	else
    	echo "ALCHEMISTS_HOME is not set!"
	end
end
