#!/usr/bin/env bats

load test_helper

@test "ruby is installed" {
  run sudo su - $RBENV_USER -c 'which ruby'
  [ $status -eq 0 ]
}

@test "ruby version is correct" {
  run sudo su - $RBENV_USER -c 'ruby -v | grep 2.2.1'
  [ $status -eq 0  ]
}

