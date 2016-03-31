# Generated by stubbs:add-option. Do not edit, if using stubbs.
# Created: Tue Apr 21 18:29:25 GMT 2015
#
#/ usage: cliqrapp:jobs [ --env_name <>] [ --appid <>] [ --quiet <no>] [ --status <active>] [ --getipfornode <>] [ --id <>] 

# _rerun_options_parse_ - Parse the command arguments and set option variables.
#
#     rerun_options_parse "$@"
#
# Arguments:
#
# * the command options and their arguments
#
# Notes:
# 
# * Sets shell variables for any parsed options.
# * The "-?" help argument prints command usage and will exit 2.
# * Return 0 for successful option parse.
#
rerun_options_parse() {

    while [ "$#" -gt 0 ]; do
        OPT="$1"
        case "$OPT" in
            --env_name) rerun_option_check $# $1; ENV_NAME=$2 ; shift ;;
            --appid) rerun_option_check $# $1; APPID=$2 ; shift ;;
            --quiet) rerun_option_check $# $1; QUIET=$2 ; shift ;;
            --status) rerun_option_check $# $1; STATUS=$2 ; shift ;;
            --getipfornode) rerun_option_check $# $1; GETIPFORNODE=$2 ; shift ;;
            --id) rerun_option_check $# $1; ID=$2 ; shift ;;
            # help option
            -|--*?)
                rerun_option_usage
                exit 2
                ;;
            # end of options, just arguments left
            *)
              break
        esac
        shift
    done

    # Set defaultable options.
    [ -z "$QUIET" ] && QUIET="$(rerun_property_get $RERUN_MODULE_DIR/options/quiet DEFAULT)"
    [ -z "$STATUS" ] && STATUS="$(rerun_property_get $RERUN_MODULE_DIR/options/status DEFAULT)"
    # Check required options are set

    # If option variables are declared exportable, export them.
    export ENV_NAME
    export APPID
    export QUIET
    export STATUS
    export GETIPFORNODE
    export ID
    #
    return 0
}


# If not already set, initialize the options variables to null.
: ${ENV_NAME:=}
: ${APPID:=}
: ${QUIET:=}
: ${STATUS:=}
: ${GETIPFORNODE:=}
: ${ID:=}


