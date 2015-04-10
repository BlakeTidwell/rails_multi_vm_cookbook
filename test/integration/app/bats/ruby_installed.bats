#!/usr/bin/env bats

@test "ruby is installed" {
  run sudo su - vagrant -c 'which ruby'
  [ $status -eq 0 ]
}

@test "ruby version is correct" {
  run sudo su - vagrant -c 'ruby -v | grep 2.2.1'
  [ $status -eq 0  ]
}
