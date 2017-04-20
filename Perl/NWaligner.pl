#Oath:

#Student Assignment Submission Form
#==================================
#I/we declare that the attached assignment is wholly my/our
#own work in accordance with Seneca Academic Policy.  No part of this
#assignment has been copied manually or electronically from any
#other source (including web sites) or distributed to other students.

#Name(s): Melanie Dawe               Student ID(s): 129089157

#---------------------------------------------------------------


use strict;
use warnings; 

my ($s1, $s2, $m, $n, @NWTable, $gapScore, $match, $mismatch, $x, $y, $i, $j);
$s1 = "ACTGATTCA";
$s2 = "ACGCATCA";
#print "$s1 \n";
#print "$s2 \n";
$m = length($s1);
#print "$m \n" ;
$n = length($s2);
#print "$n \n";

$NWTable[0][0] = 0;

$gapScore = -2; 

$match = 1;
$mismatch = -1;


# Create Matrix 
for($x = 1; $x < $m +1; $x++){
   $NWTable[0][$x] = $gapScore * $x;   
}

for($y = 1; $y < $n+1; $y++){  
     $NWTable[$y][0] = $gapScore*$y;	 	 
}

maxScore(@NWTable);
displayTable(@NWTable); 


#prints last digit 
print "$NWTable[$n][$m] \n";

# Calculate Max Score
sub maxScore {	 

for($y=1; $y <= $n; $y++) {
   for($x = 1; $x <= $m; $x++){
    
	#calculate match/mismatch/diagonal
	my ($left, $up, $diag);
	
	 $up = $NWTable[$y-1][$x] + $gapScore;
	 $left = $NWTable[$y][$x-1] + $gapScore;
	 
	 my $sequence1 = substr($s1, ($x - 1), 1);
	 my $sequence2 = substr($s2, ($y -1), 1);
	 
	 if($sequence1 eq $sequence2) {
	    $diag = $NWTable[$y-1][$x-1] + $match;
	 }
	 else {
	    $diag = $NWTable[$y-1][$x-1] + $mismatch;
	 }
	 #choose and display max score
	 if ($diag >= $up && $diag >= $left){
	    $NWTable[$y][$x] = $diag;
		#print $diag;
	 }
	 elsif ($up >= $diag && $up >= $left){
	    $NWTable[$y][$x] = $up;
		#print $up;
	 }
	 elsif ($left >= $diag && $left >= $up) {
	    $NWTable[$y][$x] = $left;
		#print $left;
	 }
	  
   }
  }
 }
 
 #Display completed table with max scores
 sub displayTable{
    my @arrayMatrix = @_;
	for ($i = 0; $i <= $#arrayMatrix; $i++){
	   for (my $j = 0; $j <= $#{$arrayMatrix[0]}; $j++){
	      print "$arrayMatrix[$i][$j] ";
	   }
	   print "\n";
	}
 }
 

 
 
  
 

