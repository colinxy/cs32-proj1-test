#! /bin/sh

# immediate exit on failure of any command
set -e

# exit code explanation
# 1 : read the instructions more carefully
# 2 : compilation error, either compilation fails,
#     or succeeds when not supposed to
# 3 : output error

function expect_fail {
    echo "$1 is expected to fail, but succeeds"
    echo -e "\nCOMPILATION ERROR"
    exit 2
}

function expect_succeed {
    echo "$1 is expected to succeed, but fails"
    echo -e "\nCOMPILATION ERROR"
    exit 2
}

current_dir=$(pwd)
parent_dir=${current_dir%/*}
# echo $current_dir $parent_dir

echo "Is \`$parent_dir' your project directory?"
read -p "[y/n]: " -n 1 -r
echo
if [ "$REPLY" != 'y' ]; then
    echo -e "\nrequirement not met, exiting test"
    exit 1
fi


declare -a files=(
    "Arena.cpp"
    "Arena.h"
    "Game.cpp"
    "Game.h"
    "globals.h"
    "History.cpp"
    "History.h"
    "Player.cpp"
    "Player.h"
    "Robot.cpp"
    "Robot.h"
    "utilities.cpp"
)

# only use back up
for f in "${files[@]}"; do
    cp ../"$f" ./test
done

# testing begins

# compilation that should work
echo
echo "The following compilation should work"
echo
make -s arena_h          || expect_succeed arena_h
echo "arena_h compiles"
make -s arena_player_h   || expect_succeed arena_player_h
echo "arena_player_h compiles"
make -s history_h        || expect_succeed history_h
echo "history_h compiles"
make -s multi_h          || expect_succeed multi_h
echo "multi_h compiles"
make -s player_arena_g_h || expect_succeed player_arena_g_h
echo "player_arena_g_h compiles"
make -s player_arena_h   || expect_succeed player_arena_h
echo "player_arena_h compiles"
make -s player_h         || expect_succeed player_h
echo "player_h compiles"
make -s robot_h          || expect_succeed robot_h
echo "robot_h compiles"

make -s arena_history_player_g_h || expect_succeed arena_history_player_g_h
echo "arena_history_player_g_h compiles"

# compilation that should fail
echo
echo "The following compilation should fail"
echo

make -s history_FAIL_h         2>/dev/null && expect_fail history_FAIL_h
echo "history_FAIL_h fails to compile"

make -s player_arena_FAIL_h    2>/dev/null && expect_fail player_arena_FAIL_h
echo "player_arena_FAIL_h fails to compile"

make -s robot_player_g_FAIL_h  2>/dev/null && expect_fail robot_player_g_FAIL_h
echo "robot_player_g_FAIL_h fails to compile"

# output test
# expected output is stored in expected_output.txt
expected=expected_output.txt

# actual output is stored in /tmp/get.output
output=/tmp/get.output
./arena_history_player_g_h.out > $output

diff $output $expected >/dev/null 2>/dev/null; exit_code=$?
if [ $exit_code != 0 ]; then
    echo "expected output:"
    cat $expected
    echo "got:"
    cat $output
    echo -e "\nOUTPUT ERROR"
    exit 3
fi


# executable/object file clean up
echo
make -s clean

# clean up
for f in "${files[@]}"; do
    rm test/"$f"
done

echo
echo "****** All Tests Passed ******"
