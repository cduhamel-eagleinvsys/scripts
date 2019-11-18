#!/bin/bash

bug=114397_maxfee
workspack_dir=CodeReview

eventfiles=(
)

bindfiles=(
    estar_fee_bind.dat
    sl_det_report.dat
)

sqlfiles=(
    packageFee.sql
    packageFeeBody.sql
    packageSLDetailReportsBody.sql
)

#################################################

patchdir=/cygdrive/c/dev/Patches
enginedir=/cygdrive/c/dev/$workspack_dir/star_engine
patchname=$patchdir/patch_bug_$bug.diff

function dodiff {
    # Save array name and then copy contents
    local array_string="$1[*]"
    local files=(${!array_string})
    
    for f in ${files[*]}
    do
        tf diff /format:unified $f >> $patchname
    done
}

function runscript {
    # Take a backup
    if [ -f $patchname ]
    then
        echo Saving backup file to: $patchname.bkp
        mv $patchname $patchname.bkp
    fi

    # Build patch file by directory

    # Events
    cd $enginedir/metadata/events/star/
    dodiff eventfiles

    # Bind
    cd $enginedir/metadata/bind/star/
    dodiff bindfiles

    # Store procedures
    cd $enginedir/sql/estar
    dodiff sqlfiles
}

#################################################

echo Diff file name: $patchname
runscript
echo Done
