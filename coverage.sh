#!/bin/bash
this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $this_dir

# git configuration
dashboard_git_url="https://github.com/Kitware/Danesfield.git"
dashboard_git_branch="master"
# conda base environment path
conda_source_dir=~/miniconda3

source ${conda_source_dir}/etc/profile.d/conda.sh

# clean files and clone repo
rm -rf ./Danesfield ./htmlcov
git clone --recursive -b ${dashboard_git_branch} -- ${dashboard_git_url}
cd ./Danesfield

if [ $1 != "--skip" ] && [ $1 != "-s" ]
then
    # install dependencies
    conda env create -f deployment/conda/conda_env.yml
    conda env update -f deployment/conda/conda_env.yml
    conda activate core3d-dev
    conda install -y coverage
    conda install -y -c conda-forge lark
    pip install -e .
else
    conda activate core3d-dev
    pip install -e .
fi

# set coverage targets to all files in ./danesfield and ./tools
#   excluding danesfield/geon_fitting/tf_ops because of python 2 code
find . -type d \( -path "./danesfield*" -or -path "./tools*" \) \
    -not -path "./danesfield/geon_fitting/tf_ops*" \
    | tr '\n' ',' | \
    coverage run --source $(</dev/stdin) -m pytest ./tests
coverage html # generate htmlcov report
coverage report # terminal coverage report

mv ./htmlcov ..
