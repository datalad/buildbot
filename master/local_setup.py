# local configuration for datalad buildbot

master_url = "http://smaug.datalad.org:8080/"
slave_port = 9989

# Passwords for buildslaves
# These are all private for the production slaves, so we get them out of
# version control in secret_passwords.py
slave_passes = {}

