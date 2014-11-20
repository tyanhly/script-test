apt-get -y install htop git nmap php5 php5-cli python-pip debian-builder python-dev tmux fbcat fbi sshfs
#pip install git+https://github.com/paulj/echo-streamserver-python
#pip install cython git+git://github.com/surfly/gevent.git#egg=gevent
pip install gevent
#pip install greenlet

echo "
set-option -g prefix C-a

#unbind [ # copy mode bound to escape key
unbind j
unbind C-b # unbind default leader key
unbind '\"' # unbind horizontal split
unbind %   # unbind vertical split

bind-key -n C-h select-pane -L
bind-key -n C-j select-pane -D
bind-key -n C-k select-pane -U
bind-key -n C-l select-pane -R

bind-key -n C-up prev
bind-key -n C-left prev

#next pane
bind-key -n C-right next
bind-key -n C-down next

# new split in current pane (horizontal / vertical)
bind-key -n C-[ split-window -v # split pane horizontally
bind-key -n C-] split-window -h # split pane vertically
" >  ~/.tmux.conf

tmux source-file ~/.tmux.conf
