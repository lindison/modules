[docker](../../index.html)
# startjenkins 

Starts Jenkins container

## SYNOPSIS

    rerun docker:startjenkins 

### OPTIONS



## README



## TESTS

Use the `stubbs:test` command to to run test plans.

    rerun stubbs:test -m docker -p startjenkins

*Test plan sources*

* [startjenkins-1](../../tests/startjenkins-1.html)
  * it fails without a real test

## SCRIPT

To edit the command script for the docker:startjenkins command, 
use the `stubbs:edit`
command. It will open the command script in your shell EDITOR.

    rerun stubbs:edit -m docker -c startjenkins

*Script source*

* [script](script.html): `RERUN_MODULE_DIR/commands/startjenkins/script`

## METADATA

* `NAME` = startjenkins
* `DESCRIPTION` = "Starts Jenkins container"
* `OPTIONS` = 

----

*Generated by stubbs:docs Tue Mar 29 19:10:50 PDT 2016*

