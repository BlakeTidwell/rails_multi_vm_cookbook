#!/usr/bin/env bats

load test_helper

@test "foreman is installed" {
  run sudo su - $RBENV_USER -c 'which foreman'
  [ $status -eq 0 ]
}

