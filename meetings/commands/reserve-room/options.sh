# Generated by stubbs:add-option. Do not edit, if using stubbs.
# Created: Tue Mar 29 10:08:49 PDT 2016
#
#/ usage: meetings:reserve-room  --capacity <100> 

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

    while (( "$#" > 0 ))
    do
        OPT="$1"
        case "$OPT" in
            --capacity) rerun_option_check $# $1; CAPACITY=$2 ; shift ;;
            # help option
            -|--*?) echo >&2 "unrecognized option: $OPT"
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
    [[ -z "$CAPACITY" ]] && CAPACITY="$(rerun_property_get $RERUN_MODULE_DIR/options/capacity DEFAULT)"
    # Check required options are set
    [[ -z "$CAPACITY" ]] && { echo >&2 "missing required option: --capacity" ; return 2 ; }
    # If option variables are declared exportable, export them.
    export CAPACITY
    #
    return 0
}


# If not already set, initialize the options variables to null.
: ${CAPACITY:=}


