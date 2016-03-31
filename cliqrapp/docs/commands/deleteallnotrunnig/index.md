[cliqrapp](../../index.html)
# deleteallnotrunnig 

Stop all Errored,Canceled and Stopped jobs from deploymeent

## SYNOPSIS

    rerun cliqrapp:deleteallnotrunnig [--force <no>]

### OPTIONS

* [   [--force <no>]: to really delete all Errored jobs](../../options/force/index.html)

## README



## TESTS

Use the `stubbs:test` command to to run test plans.

    rerun stubbs:test -m cliqrapp -p deleteallnotrunnig

*Test plan sources*

* [deleteallnotrunnig-1](../../tests/deleteallnotrunnig-1.html)
  * it fails without a real test

## SCRIPT

To edit the command script for the cliqrapp:deleteallnotrunnig command, 
use the `stubbs:edit`
command. It will open the command script in your shell EDITOR.

    rerun stubbs:edit -m cliqrapp -c deleteallnotrunnig

*Script source*

* [script](script.html): `RERUN_MODULE_DIR/commands/deleteallnotrunnig/script`

## METADATA

* `NAME` = deleteallnotrunnig
* `DESCRIPTION` = "Stop all Errored,Canceled and Stopped jobs from deploymeent"
* `OPTIONS` = "force"

----

*Generated by stubbs:docs Thu Jul 30 18:20:12 GMT 2015*
