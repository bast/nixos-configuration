function untab
    set temp_file (mktemp)
    expand $argv > $temp_file
    mv $temp_file $argv
end
