#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m docker -p open-jenkins [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "open-jenkins"

# ------------------------------
# Replace this test. 
it_fails_without_a_real_test() {
    exit 1
}
# ------------------------------

