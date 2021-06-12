function _perm
    find . -type f -not -perm /111 -exec chmod $argv[1] {} \;
    find . -type f      -perm /111 -exec chmod $argv[2] {} \;
    find . -type d                 -exec chmod $argv[2] {} \;
end
