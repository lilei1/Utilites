#   Install BAD_Mutations
It is hard to install bad_mutations with conda since there are several pieces which needs to be set up!

## Follow the installation from this [link](https://github.com/MorrellLAB/BAD_Mutations/blob/master/Manual/Installation.md)
All of this were relative to cori on NERSC

```
module load python/3.7-anaconda-2019.10(default)

git clone https://github.com/MorrellLAB/BAD_Mutations.git

cd ~/bscratch/software/BAD_Mutations 

conda env create -f Supporting/bad_mutations.yml

conda activate bad_mutations

mkdir -p \
     ${CONDA_PREFIX}/etc/conda/activate.d \
     ${CONDA_PREFIX}/etc/conda/deactivate.d
(/global/cscratch1/sd/llei2019/conda_envs/bad_mutations) 


touch \
     ${CONDA_PREFIX}/etc/conda/activate.d/env_vars.sh \
     ${CONDA_PREFIX}/etc/conda/deactivate.d/env_vars.sh
(/global/cscratch1/sd/llei2019/conda_envs/bad_mutations) 

vi ${CONDA_PREFIX}/etc/conda/activate.d/env_vars.sh
```



Then add the content into above file:

```
#!/bin/sh
export PASTA_TOOLS_DEVDIR="${CONDA_PREFIX}/bin"
```

```
vi ${CONDA_PREFIX}/etc/conda/deactivate.d/env_vars.sh
```

Then add the content into above file:

```
#!/bin/sh
unset PASTA_TOOLS_DEVDIR
```

activate the bad_mutations

```
conda deactivate

conda activate bad_mutations

```

Install mafft

```
conda install -c bioconda mafft -n bad_mutations

cd /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/lib/python3.7/site-packages 

mkdir bin

cd bin/

ln -s /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/mafft mafft

```

Install hmmer

```
conda install -c bioconda hmmer -n bad_mutations

cd /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/lib/python3.7/site-packages 

ln -s /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/hmmeralign hmmeralign

```

set the correct link for other pieces:


```
ln -s /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/opal.jar opal.jar

ln -s /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/fasttree fasttree

ln -s /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/raxml raxml

```

all of the setting should be like this:

```
ls /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/lib/python3.7/site-packages/bin/
total 20
lrwxrwxrwx 1 llei2019 llei2019 64 Jan 26 21:25 mafft -> /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/mafft
lrwxrwxrwx 1 llei2019 llei2019 69 Jan 26 21:26 hmmeralign -> /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/hmmeralign
lrwxrwxrwx 1 llei2019 llei2019 67 Jan 26 21:26 opal.jar -> /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/opal.jar
lrwxrwxrwx 1 llei2019 llei2019 67 Jan 26 21:27 fasttree -> /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/fasttree
lrwxrwxrwx 1 llei2019 llei2019 64 Jan 26 21:27 raxml -> /global/cscratch1/sd/llei2019/conda_envs/bad_mutations/bin/raxml

```

Then it should be OK and can be ready for testing!!!!