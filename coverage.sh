#!/bin/bash
this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd $this_dir

dashboard_git_url="https://github.com/Kitware/Danesfield.git"
dashboard_git_branch="master"
git_branch_new="-b ${dashboard_git_branch}"
conda_source_dir=~/miniconda3

source ${conda_source_dir}/etc/profile.d/conda.sh

rm -rf ./Danesfield ./htmlcov
git clone --recursive ${git_branch_new} -- ${dashboard_git_url}
cd ./Danesfield

conda env create -f deployment/conda/conda_env.yml
conda env update -f deployment/conda/conda_env.yml
conda activate core3d-dev
conda install -y coverage
pip install -e .

# set coverage sources to all directories (default is to only include directories with __init__.py)
# excluding danesfield/geon_fitting/tf_ops because of python 2 usage
find ./danesfield -type d \
    -not -name __pycache__ \
    -not -path "./danesfield/geon_fitting/tf_ops*" \
    | tr '\n' ',' | \
    coverage run --source $(</dev/stdin) -m pytest ./tests
coverage html # generate htmlcov report
coverage report # terminal coverage report

mv ./htmlcov ..
