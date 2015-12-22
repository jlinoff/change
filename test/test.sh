#!/bin/bash

# ================================================================
# Functions
# ================================================================
function error() {
    echo "ERROR: $*"
    exit 1
}

function failed() {
    local Tid="$1"
    shift
    (( Failed++ ))
    printf '%s: failed' $Tid
    if (( $# )) ; then
        local msg="$*"
        printf ' - %s' "$msg"
    fi
    printf '\n'
}

function passed() {
    local Tid="$1"
    shift
    (( Passed++ ))
    printf '%s: passed' $Tid
    if (( $# )) ; then
        local msg="$*"
        printf ' - %s' "$msg"
    fi
    printf '\n'
}

# ================================================================
# Main
# ================================================================
Program=../change
Failed=0
Passed=0

[ -f $Program ] || error "program does not exist: $Program"
[ -x $Program ] || error "program is not executable: $Program"

# Test #01
Id=test01
if [ -f "$Id.txt" ] ; then
    if [ -f "$Id.ok" ] ; then
        rm -rf $Id
        mkdir -p $Id
        $Program -v -p $Id/ foo FOO $Id.txt >$Id/stdout 2>$Id/stderr
        st=$?
        if (( $st )) ; then
            failed "$Id" "program failed with status $st: $Program"
        else
            diff $Id.ok $Id/$Id.txt >$Id/$Id.diff
            st=$?
            if (( $st == 0 )) ; then
                passed "$Id"
                rm -rf $Id  # everything passed, cleanup
            else
                failed "$Id" "diff failed, see $Id/$Id.diff"
            fi
        fi
    else
        failed "$Id" "missing $Id.ok"
    fi
else
    failed "$Id" "missing $Id.txt"
fi

# Test #02
Id=test02
if [ -f "$Id.txt" ] ; then
    if [ -f "$Id.ok" ] ; then
        rm -rf $Id
        mkdir -p $Id
        $Program -v -p $Id/ '\bfoo\b' FOO $Id.txt >$Id/stdout 2>$Id/stderr
        st=$?
        if (( $st )) ; then
            failed "$Id" "program failed with status $st: $Program"
        else
            diff $Id.ok $Id/$Id.txt >$Id/$Id.diff
            st=$?
            if (( $st == 0 )) ; then
                passed "$Id"
                rm -rf $Id  # everything passed, cleanup
            else
                failed "$Id" "diff failed, see $Id/$Id.diff"
            fi
        fi
    else
        failed "$Id" "missing $Id.ok"
    fi
else
    failed "$Id" "missing $Id.txt"
fi

# Test #03
Id=test03
if [ -f "$Id.txt" ] ; then
    if [ -f "$Id.ok" ] ; then
        rm -rf $Id
        mkdir -p $Id
        $Program -v -p $Id/ 'foo\.' 'FOO.' $Id.txt >$Id/stdout 2>$Id/stderr
        st=$?
        if (( $st )) ; then
            failed "$Id" "program failed with status $st: $Program"
        else
            diff $Id.ok $Id/$Id.txt >$Id/$Id.diff
            st=$?
            if (( $st == 0 )) ; then
                passed "$Id"
                rm -rf $Id  # everything passed, cleanup
            else
                failed "$Id" "diff failed, see $Id/$Id.diff"
            fi
        fi
    else
        failed "$Id" "missing $Id.ok"
    fi
else
    failed "$Id" "missing $Id.txt"
fi

# Test #04
Id=test04
if [ -f "$Id.txt" ] ; then
    if [ -f "$Id.ok" ] ; then
        rm -rf $Id
        mkdir -p $Id
        $Program -v -p $Id/ '\b(foo)([a-z])' '\1.\2' $Id.txt >$Id/stdout 2>$Id/stderr
        st=$?
        if (( $st )) ; then
            failed "$Id" "program failed with status $st: $Program"
        else
            diff $Id.ok $Id/$Id.txt >$Id/$Id.diff
            st=$?
            if (( $st == 0 )) ; then
                passed "$Id"
                rm -rf $Id  # everything passed, cleanup
            else
                failed "$Id" "diff failed, see $Id/$Id.diff"
            fi
        fi
    else
        failed "$Id" "missing $Id.ok"
    fi
else
    failed "$Id" "missing $Id.txt"
fi

# Summary
(( Total = Passed + Failed ))
printf '\n'
printf 'Summary\n'
printf '   Passed: %2d\n' $Passed
printf '   Failed: %2d\n' $Failed
printf '   Total:  %2d\n' $Total
printf '\n'

