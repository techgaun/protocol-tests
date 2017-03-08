#!/usr/bin/expect

set evt_arg [lindex $argv 1]

if { $evt_arg eq "" } {
  set evt_arg "status"
}

set count [lindex $argv 0]

spawn wscat -c ws://localhost:4000/socket/websocket?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InNhbWFyLmFjaGFyeWErc3RhZ2VAYnJpZ2h0ZXJneS5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6InNhbWFyLmFjaGFyeWErc3RhZ2VAYnJpZ2h0ZXJneS5jb20iLCJhcHBfbWV0YWRhdGEiOnsiZGV2aWNlcyI6WzFdLCJyb2xlIjoiZGV2aWNlIn0sImlzcyI6Imh0dHBzOi8vY2FzYS1pcS5hdXRoMC5jb20vIiwic3ViIjoiYXV0aDB8NTg3NzAxZTVhY2JiYTQ2NDZhOWM3YjI2IiwiYXVkIjoiMzZQM3g5ajNOVkk1Mzczejl1RjVZSWhjWlNNWFZGV2siLCJleHAiOjE0ODg5NDk3NjUsImlhdCI6MTQ4ODkxMzc2NX0.mOkG4gvyJySezCj-ix35mDlTm4wIPThpD2w-znUnYfA

expect "*"

for {set i 0} {$i < $count} {incr i 1} {
  send "$evt_arg\n"
  expect "*response:*"
}
