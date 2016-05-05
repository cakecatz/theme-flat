function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function _is_git_dirty
  set -l show_untracked (git config --bool bash.showUntrackedFiles)
  set untracked ''
  if [ "$theme_display_git_untracked" = 'no' -o "$show_untracked" = 'false' ]
    set untracked '--untracked-files=no'
  end
  echo (command git status -s --ignore-submodules=dirty $untracked ^/dev/null)
end

function _hostname
  echo -n (hostname -s)
end

function _username
  echo -n $USER
end

function _current_dir
  echo -n (prompt_pwd)
end

function fish_prompt
  set -l default_bg (set_color -b normal)
  set -l gray (set_color -b 34495e)
  set -l cyan (set_color -b 2980b9)
  set -l magenta (set_color -b DB0A5B)
  set -l green (set_color -b 16A085)

  set hostname "$gray "(_hostname)" $default_bg"
  set username "$cyan "(_username)" $default_bg"
  set current_dir "$magenta "(_current_dir)" $default_bg"

  if [ (_git_branch_name) ]
    set git_info ' '(_git_branch_name)' '
    if [ (_is_git_dirty) ]
      set -l dirty "⚡ "
      set git_info "$git_info$dirty"
    end
  end

  set git_info "$green$git_info$default_bg"

  echo $hostname$username$current_dir$git_info' -> '
end
