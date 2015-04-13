##
# Backup Generated: my_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t my_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Backup::Model.new(:my_backup, 'Description for my_backup') do

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = :all
    db.username           = "inruumwcchgcef"
    db.password           = "1uT9yokMJ71jfFUh0k26zLw1E6"
    db.host               = "ec2-54-225-239-184.compute-1.amazonaws.com"
    db.port               = 5432
    db.socket             = "/tmp/pg.sock"
  end

  store_with SFTP do |server|
    server.username = 'rails'
    server.password = 'AWqkn4LKP3'
    server.ip       = '95.85.36.126'
    server.port     = 22
    server.path     = '~/backups/'
    server.keep     = 5

    # Additional options for the SSH connection.
    # server.ssh_options = {}
  end

end