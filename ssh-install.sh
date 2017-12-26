ssh-keygen -t rsa -b 4096 -C dom@islovely.co -f ~/.ssh/id_rsa \
&& eval "$(ssh-agent -s)" \
&& ssh-add ~/.ssh/id_rsa \
&& rm ~/ssh-install.sh
