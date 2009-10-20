# Setup a bridgepdx user

# Create user
account_manager.add_user 'northbay'

# Grant web server rights to user's group
account_manager.add_groups_to_user(['northbay'], 'www-data')

mkdir_p("/var/www/northbay") && chown("northbay", "northbay", "/var/www/northbay", :recursive => true)