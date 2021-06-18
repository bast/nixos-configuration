# You can override some default options with config.fish:
#
#  set -g theme_short_path yes

function fish_prompt
  set -l last_command_status $status
  set -l cwd
  echo -n \n

  if test "$theme_short_path" = 'yes'
    set cwd (basename (prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  set -l ahead    " (ahead)"
  set -l behind   " (behind)"
  set -l diverged " (diverged)"
  set -l dirty    " (modified)"
  set -l none     ""

  set -l normal_color     (set_color normal)
  set -l directory_color  (set_color $fish_color_quote 2> /dev/null; or set_color brown)
  set -l repository_color (set_color $fish_color_cwd 2> /dev/null; or set_color green)
  set -l hostname_color   (set_color red)
  set -l warning_color    (set_color --bold bryellow)

  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    end

    if set -q IN_NIX_SHELL
      echo -n -s $warning_color "[nix-shell] " $normal_color
    end
    echo -n -s $hostname_color (hostname): $directory_color $cwd $normal_color
    echo -n -s " on " $repository_color (git_branch_name) $normal_color

    if git_is_touched
      echo -n -s $dirty
    else
      echo -n -s (git_ahead $ahead $behind $diverged $none)
    end
  else
    echo -n -s $hostname_color (hostname): $directory_color $cwd $normal_color
  end

  echo -s \n "\$ "
end
