#!/usr/bin/bash

logfile='resubmit.log'
counterfile='resubmit.count'
outfile='mom6.err'

# Define errors from which a resubmit is appropriate
declare -a errors=("DT found with multiple inconsistent definitions", 
                   "Segmentation fault: address not mapped to object")

resub=false
for error in "${errors[@]}"
do
  if grep -q ${error} ${outfile}
  then
     echo "Error found: ${error}" >> ${logfile}
     resub=true
     break
  else
     echo "Error not found: ${error}" >> ${logfile}
  fi
done

if ! ${resub}
then
  echo "Error not eligible for resubmission" >> ${logfile}
  exit 0
fi

if [ -f "${counterfile}" ]
then
  PAYU_N_RESUB=$(cat ${counterfile})
else
  echo "Reset resubmission counter" >> ${logfile}
  PAYU_N_RESUB=3
fi

echo "Resubmission counter: ${PAYU_N_RESUB}" >> ${logfile}

if [[ "${PAYU_N_RESUB}" -gt 0 ]]
then
  # Sweep and re-run
  ${PAYU_PATH}/payu sweep >> ${logfile}
  ${PAYU_PATH}/payu run -n ${PAYU_N_RUNS} >> ${logfile}
  # Decrement resub counter and save to counter file
  ((PAYU_N_RESUB=PAYU_N_RESUB-1)) 
  echo "${PAYU_N_RESUB}" > ${counterfile}
else
  echo "Resubmit limit reached ... " >> ${logfile}
  rm ${counterfile}
fi

