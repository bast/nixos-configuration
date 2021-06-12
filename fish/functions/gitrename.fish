function gitrename
    for file in (git grep -l $argv[1])
        sed -i "s/$argv[1]/$argv[2]/g" $file
    end
end
