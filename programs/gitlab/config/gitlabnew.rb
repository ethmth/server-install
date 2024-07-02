# Disable the built-in Postgres
postgresql['enable'] = false

# Fill in the connection details for database.yml
gitlab_rails['db_adapter'] = 'postgresql'
gitlab_rails['db_encoding'] = 'utf8'
gitlab_rails['db_host'] = 'host.docker.internal'
gitlab_rails['db_port'] = 5432
gitlab_rails['db_username'] = 'postgres'
gitlab_rails['db_password'] = 'password'

nginx['listen_port'] = 80
nginx['listen_https'] = false
