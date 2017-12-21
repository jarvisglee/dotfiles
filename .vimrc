# vi (hjkl) Navigation
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# vi Mode
set-window-option -g mode-keys vi

# Pane and Window Indexing
set -g base-index 1
setw -g pane-base-index 1

# Terminal Colors
set -g default-terminal "screen-256color"

# Default Directories
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
