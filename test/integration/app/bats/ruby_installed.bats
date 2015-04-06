#!/usr/bin/env bats

@test "ruby is installed" {
  run which ruby
    [ "$status" -eq 0  ]
}

@test "ruby version is correct" {
  run ruby -v
    [ "$status" == *"2.2.1"*  ]
}