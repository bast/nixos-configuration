function ve
    if not test -d venv
        python -m venv venv
    end
    source venv/bin/activate.fish
    if test -e requirements.txt
        python -m pip install --upgrade pip
        python -m pip install -r requirements.txt
    end
end
