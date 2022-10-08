function rangeZeroNine(x) {

    if ((x < 0) || (x > 9 )) {
        print "window error: room must be between 0 and 9"
        return 0;
    }
    return 1;

}

function testAlarm() {
    if (alarm == 1) {
        print "window error: alarm enabled"
        return 0;
    }
    return 1;

}

function checkCoolerOn(x) {
    if (window[x] == 18 || window[x] == 19 || window[x] == 20 || window[x] == 21 || window[x] == 22 || window[x] == 23 || window[x] == 24 || window[x] == 25 || window[x] == 26 ) {
        print "window error: cooler " x " enabled"
        return 0;
    }
    return 1;
}

function checkWindowOpen(x) {
    if (window[x] == openWin ) {
        print "window error: " x " already opened"
        return 0;
    }
    return 1;
}

function checkWindowClose(x) {
    if (window[x] == closeWin || window[x] == 18 || window[x] == 19 || window[x] == 20 || window[x] == 21 || window[x] == 22 || window[x] == 23 || window[x] == 24 || window[x] == 25 || window[x] == 26) {
        print "window error: " x " already closed"
        return 0;
    }
    return 1;
}

function checkAlarmOn() {
    if (alarm == 1) {
        print "alarm error: already enabled"
        return 0;
    }
    return 1;
}

function checkAlarmOff() {
    if (alarm == 0) {
        print "alarm error: already disabled"
        return 0;
    }
    return 1;
}

function checkAlarmWinOp() {

    i = 0;

    while ((window[i] != openWin) && (i < 10) ) {
        i++
    };

    if (window[i] == openWin) {
        print "alarm error: window " i " opened"
        return 0;
    }
    return -1;
}

function checkAlarmCoolOn() {

    i = 0;

    while (((window[i] != 18) && (window[i] != 19) && (window[i] != 20) && (window[i] != 21) && (window[i] != 22) && (window[i] != 23) && (window[i] != 24) && (window[i] != 25) && (window[i] != 26)) && (i < 10) ) {
        i++
    };

    if (i < 10) {
        print "alarm error: cooler " i " enabled"
        return 0;
    }

    return -1;
}

function checkCoolTemp(x) {
    if (x < 18 || x > 26) {
        print "cooler error: temp must be between 18 and 26"
        return 0;
    }
    return 1;
}

function checkCoolRangeWin(x) {

    if ((x < 0) || (x > 9 )) {
        print "cooler error: room must be between 0 and 9"
        return 0;
    }
    return 1;

}

function checkCoolAlarm() {

    if (alarm == 1) {
        print "cooler error: alarm enabled"
        return 0;
    }
    return 1;

}

function checkCoolWinOp(x) {

    if (window[x] == openWin) {
        print "cooler error: window " x " opened"
        return 0;
    }
    return -1;
}

function checkCoolOn(x) {

    if (window[x] == closeWin || window[x] == openWin) {
        print "cooler error: " x " already off"
        return 0;
    }

    return -1;
}


BEGIN { 

    closeWin = "  ";
    openWin = "\\/";
    alarm = 1;
    
    for (i = 0; i<10; i++) {
    window [i] = closeWin
    }

}



/^stat$/ {
    print alarm"["window [0]"]["window [1]"]["window [2]"]["window [3]"]["window [4]"]["window [5]"]["window [6]"]["window [7]"]["window [8]"]["window [9]"]";;
    next;
    } 

/^window [0-9]+ close$/ {

    if ((rangeZeroNine($2) == 1) && (testAlarm() == 1) && (checkWindowClose($2) == 1)) {

    print "success: window " $2 " closed"
    window [$2] = closeWin;

    }
    next;
    } 

/^window [0-9]+ open$/ {

    if ((rangeZeroNine($2) == 1) && testAlarm() && (checkCoolerOn($2) == 1) && (checkWindowOpen($2) == 1)) {

    window [$2] = openWin;
    print "success: window " $2 " opened"
    }

    next;
    } 


/^cooler [0-9]+ -*[0-9]+C$/ {

    if ((checkCoolRangeWin($2) == 1) && (checkCoolTemp($3 + 0) == 1) && (checkCoolAlarm() == 1) && (checkCoolWinOp($2) == -1)) {
    window [$2] = ($3 + 0)
    print "success: cooler " $2 " set to " ($3 + 0)
    }

    next;
    } 

/^cooler [0-9]+ off$/ {

    if ((checkCoolRangeWin($2) == 1) && (checkCoolAlarm() == 1) &&  (checkCoolOn($2) == -1)) {
    window[$2]= closeWin
    print "success: cooler " $2 " disabled"
    }

    next;
    } 

/^alarm on$/ {
    if ((checkAlarmOn() == 1) && (checkAlarmWinOp() == -1) && (checkAlarmCoolOn() == -1)) {
    print "success: alarm enabled"
    alarm = 1;
    }
    next;
}

/^alarm off$/ {

    if (checkAlarmOff() == 1) {
    print "success: alarm disabled"
    alarm = 0;
    }
    next;
}

/^\s*$|(#.*)/ {
    print $0
    next;
}

// {
    print "error: unknown command"
    next;
}

END {

}