#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m docker -p delete-jenkins [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "delete-jenkins"

# ------------------------------
# Replace this test. 
it_fails_without_a_real_test() {
    exit 1
}
# ------------------------------

