#!/usr/bin/perl
#
# Generate a reset password for various HP StorageWorks devices
# Algorithm liberally taken from https://community.spiceworks.com/topic/114512-hp-autoloader-1-8-g2-magazine-password-issue
#
# This script requires the date from the device itself. The resulting code is only valid while
# the date and hour have not changed.

use strict;

if($#ARGV != 3 or lc($ARGV[0]) eq "-h" || lc($ARGV[0]) eq "--help") {
	print "Usage: $0 [year] [month] [day] [hour]\n";
	exit(1);
}

my ($year, $month, $day, $hour) = @ARGV;

my $subtotal = ($hour * 1001) + ($day * 101) + $month + $year;

my $subtotal2 = $subtotal * 123;

if($subtotal2 > 99999999) {
	print "Password: 44122333\n";
	exit;
}

my $adminpw;

for(my$i=0; $i<length($subtotal2); $i++) {
	my $num = substr($subtotal2, $i, 1);

	if($num == 0) {
		$adminpw .= "1";
	}
	elsif($num == 9) {
		$adminpw .= "1";
	}
	elsif($num > 4) {
		$adminpw .= ($num-4);
	}
	else {
		$adminpw .= $num;
	}
}

if(length($adminpw) < 8) {
	$adminpw = 1 x (8 - length($adminpw)) . $adminpw;
}

print $adminpw."\n";
