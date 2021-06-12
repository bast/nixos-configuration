function perm600
    find . -type f -exec chmod 600 {} \;
    find . -type d -exec chmod 700 {} \;
end
