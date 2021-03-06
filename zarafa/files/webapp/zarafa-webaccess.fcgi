#################################################################################
# This is WebAccess only
#################################################################################

Alias /webaccess /usr/share/zarafa-webaccess

<Directory /usr/share/zarafa-webaccess>
    DirectoryIndex index.php
    Options -Indexes +FollowSymLinks
    AllowOverride Options

    Order allow,deny
    Allow from all

    # Uncomment to enhance security of WebApp by restricting cookies to only
    # be provided over HTTPS connections
    # php_flag session.cookie_secure on
    # php_flag session.cookie_httponly on
</Directory>

