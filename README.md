The userscripts hook for an error script is now available on gadi under `conda/analysis3-20.01`.

This repo contains a test `MOM6` configuration which implements automatic resubmission after 
defined errors.

In `config.yaml` script is defined to run on error and a command to remove the resubmit 
counter file when a run is successful:

https://github.com/aidanheerdegen/mom6_error_test/blob/master/config.yaml#L28-L30

The `error` userscript is `resub.sh`:

https://github.com/aidanheerdegen/mom6_error_test/blob/master/resub.sh

The outfile variable to is model dependent and may need to be changed:

https://github.com/aidanheerdegen/mom6_error_test/blob/master/resub.sh#L5

The allowable error messages from which graceful recovery and automatic resubmissions
is possible is set here:

https://github.com/aidanheerdegen/mom6_error_test/blob/master/resub.sh#L5

and will almost certainly need to changed.

The maximum number of consecutive resubmissions is set here:

https://github.com/aidanheerdegen/mom6_error_test/blob/master/resub.sh#L7
