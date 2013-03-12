#!/bin/sh
#
# Version 0.0.2 - Jan/2009
# Changes: added device verification
#
# by Thiago Varela - thiago@iplenix.com

iostat=`which iostat 2>/dev/null`
bc=`which bc 2>/dev/null`

function help {
echo -e "\n\tThis plugin shows the I/O usage of the specified disk, using the iostat external program.\n\tIt prints three statistics: util \n\n$0:\n\t-d <disk>\t\tDevice to be checked (without the full path, eg. sda)\n\t-c <busy>\tSets the CRITICAL level for busy\n\t-w <busy>\tSets the WARNING level for busy\n"
        exit -1
}

# Ensuring we have the needed tools:
( [ ! -f $iostat ] || [ ! -f $bc ] ) && \
        ( echo "ERROR: You must have iostat and bc installed in order to run this plugin" && exit -1 )

# Getting parameters:
while getopts "d:w:c:h" OPT; do
        case $OPT in
                "d") disk=$OPTARG;;
                "w") warning=$OPTARG;;
                "c") critical=$OPTARG;;
                "h") help;;
        esac
done

# Adjusting the three warn and crit levels:
crit_busy=$critical
warn_busy=$warning

# Checking parameters:
[ ! -b "/dev/$disk" ] && echo "ERROR: Device incorrectly specified" && help

( [ "$warn_busy" == "" ] || [ "$crit_busy" == "" ] ) &&
        echo "ERROR: You must specify all warning and critical levels" && help

( [[ "$warn_busy" -ge  "$crit_busy" ]] ) && \
  echo "ERROR: critical levels must be highter than warning levels" && help


# Doing the actual check:
busy=`$iostat -x $disk | grep $disk | awk '{print $12}'`

# Comparing the result and setting the correct level:
if ( [ "`echo "$busy >= $crit_busy" | bc`" == "1" ] ); then
        msg="CRITICAL"
        status=2
else if ( [ "`echo "$busy >= $warn_busy" | bc`" == "1" ] ); then
                msg="WARNING"
                status=1
     else
        msg="OK"
        status=0
     fi
fi

# Printing the results:
echo "$msg - I/O stats busy=$busy | 'busy'=$busy;"

# Bye!
exit $status
