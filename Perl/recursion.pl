#The Purpose of this code is to (A) recursively search through a binary tree and (B)to recursviley solve the Fibonacci sequence.  

Part A
#!/home/account/software/bin/perl


#if low > high than $rv = 0
#if value < $arrayRef ->[mid]
# $rv = -1
# recursiveBinarySearch($arrayRef, $value)
#  else {
#    $rv = -1
#recursiveBinarySearch($arrayRef, $value);

#recursiveBinarySearch($arrayRef, $value)
use strict;
use warnings;

sub recursiveBinarySearch($$);
my (@array1, @array2, $rv);
@array1 = (898, 0, 13, 27, -451, 9, 77, 123101, -2, 18);
@array1 = sort {$a <=> $b} @array1;
@array2 = qw(Apple IBM Unix Fibonacci perl bioInformatics Seneca);
@array2 = sort {$a cmp $b} @array2;

#print "@array1 \n";
#print "@array2 \n";
 #test number search
$rv = recursiveBinarySearch(\@array1, 77);
print "binary search complete... Item ", ($rv == -1) ? "NOT " : "", "FOUND. Index: $rv\n";
$rv = recursiveBinarySearch(\@array1, 999);
print "binary search complete... Item ", ($rv == -1) ? "NOT " : "", "FOUND. Index: $rv\n";

# test string search
$rv = recursiveBinarySearch(\@array2, "unknown");
print "binary search complete... Item ", ($rv == -1) ? "NOT " : "", "FOUND. Index: $rv\n";
$rv = recursiveBinarySearch(\@array2, "Apple");
print "binary search complete... Item ", ($rv == -1) ? "NOT " : "", "FOUND. Index: $rv\n";




sub recursiveBinarySearch($$) {
   my ($arrayRef, $value) = @_;
   my ($low, $high, $mid, $rv, $index);
   $low = 0;
   $high = scalar(@{$arrayRef}-1);
   $rv = 0;
   $mid = int(scalar(@{$arrayRef}-1) / 2);
   my $currentKey = $arrayRef ->[$mid];

  
   if ((grep(/$value/, @$arrayRef)) <= 0){
    $rv = -1; 
   }
   if($value gt $arrayRef->[$mid] && $rv == 0) {
    $rv = recursiveBinarySearch([@$arrayRef[$mid+1..$#$arrayRef]], $value) + $mid +1;
   }
   elsif ($value lt $arrayRef->[$mid] && $rv == 0) {
  $rv = recursiveBinarySearch([@$arrayRef[0..$mid-1]], $value);
   }
   elsif ($value eq $currentKey) {
      $rv = $mid; 
   }
    
   return $rv;
}
#-----------------------------------------------------------------------
Part B
#!/home/account/software/bin/perl

use strict;
use warnings;

sub recursiveFibonacci($);

my @sampleValues = (5, 6, 8, 10);
my $var;

foreach (@sampleValues) {
   print "recursiveFibonacci($_) = ";
   foreach $var (0..$_) {
      print recursiveFibonacci($var);
       print ", " unless $var == $_;
   }
   print "\n";
}

sub recursiveFibonacci($) {

   my $number = shift;
   if ($number == 0 || $number ==1) {
       return $number; 
   }

   else {
      return recursiveFibonacci($number - 1) + recursiveFibonacci($number - 2); 
   }   
}


