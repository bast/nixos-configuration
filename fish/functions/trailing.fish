# removes trailing whitespace in file $argv
function trailing
    sed --in-place 's/[[:space:]]\+$//' $argv
end
