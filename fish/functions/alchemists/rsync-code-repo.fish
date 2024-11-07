function rsync-code-repo
	if set -q ALCHEMIST_HOME
		rsync -avz --delete \
			--exclude='**/__pycache__' \
			--exclude="**/.Trash*" \
			$ALCHEMIST_HOME/ \
			yuyangh@heart.cs.uchicago.edu:/data/yuyangh/alchemists
	else
    	echo "ALCHEMIST_HOME is not set!"
	end
end
