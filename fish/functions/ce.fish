function ce
    eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    if not test -d env
        conda env create --prefix ./env --file environment.yml
    end
    conda activate ./env
end
