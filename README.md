# nsp-model
Models used in Neural Simulation Pipeline
# how to add submodule
git submodule add https://karolchlasta@github.com/KarolChlasta/nsp-model.git

git submodule add https://github.com/KarolChlasta/genesis-2.4.git
# how to pull the repo with submodule updates
git pull --recurse-submodules
# how to update the repo with submodule
1) to refresh the submodules in nsp-code, from the parent directory run:
cd nsp-model
git fetch
git status
git pull
cd ..
git status
git add nsp-model
git commit -m "update submodule 1"
git push
git status
