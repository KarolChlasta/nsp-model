# nsp-model
Models used in Neural Simulation Pipeline

#how to pull the repo with submodule updates
git pull --recurse-submodules
# how to update the repo with submodule
1) to refresh the submodules in nsp-code, from the parent directory run:
cd parent directore in repo
git submodule update --init;
cd submodule-directory;
git pull;
cd ..;
git add submodule-directory;
now you can git commit and git push
