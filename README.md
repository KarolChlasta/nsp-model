# nsp-model
Models used in Neural Simulation Pipeline

# How to clone model repository with this git module
git clone https://github.com/KarolChlasta/nsp-code.git --recurse-submodules

# Command how to add submodule manually
git submodule add https://karolchlasta@github.com/KarolChlasta/nsp-model.git

git submodule add https://github.com/KarolChlasta/genesis-2.4.git

# How to pull the repo with submodule updates
git pull --recurse-submodules
# How to update the repo with submodule

1) to refresh the submodules in nsp-code, from the parent directory (ecs-server) run:
````
cd nsp-code
cd ecs-server

cd nsp-model

git fetch

git status

git pull

cd ..

git status

git add nsp-model

git commit -m "Update to submodule nsp-model"

git push

git status
```
