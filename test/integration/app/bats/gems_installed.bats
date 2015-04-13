#!/user/bin/env bats

RBENV_USER=vagrant

@test "bundler is installed" {
  run sudo su - $RBENV_USER -c 'which bundle'
  [ $status -eq 0 ]
}

@test "mailcatcher is installed" {
  run sudo su - $RBENV_USER -c 'which mailcatcher'
  [ $status -eq 0 ]
}
