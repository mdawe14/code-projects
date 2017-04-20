# The purpose of this code is to open a genbank file and select certain entries, create, connect and populate a databse with the selected entries 



#!c:\strawberry\perl\bin\perl.exe

use strict;
use warnings;
use DBI;

my ($dataSourceName, $dbh, $userName, $password, $sth, $version, $dataBaseName);
my ($sqlCommand, $fileName1,$fileName2, $fileName3, $fileName4, $fileName5, $file, @records, @fields, @dateFields, $sqlDate, $rows, $tableName);
my ($id, $URL, $fields, $def, $acc, $origin, $aLine);


my $aURL = "https://www.ncbi.nlm.nih.gov/nuccore/NZ_LYDO01000004.1";
my $ceURL = "https://www.ncbi.nlm.nih.gov/nuccore/KP324830.1";
my $cURL = "https://www.ncbi.nlm.nih.gov/nuccore/FW584273.1";
my $oURL = "https://www.ncbi.nlm.nih.gov/nuccore/AY367363.2";
my $pURL =  "https://www.ncbi.nlm.nih.gov/nuccore/FO834906.1";

$dataBaseName = "bacteria";
$tableName = "cre";
$dataSourceName = "dbi:SQLite:dbname=bacteria.db";
$userName = $password = "";

$dbh = DBI->connect($dataSourceName, $userName, $password) or die $DBI::errstr;

$sqlCommand = <<"_END_";
CREATE TABLE $tableName (ID INTEGER PRIMARY KEY AUTOINCREMENT, 
URL TEXT NOT NULL,  
LOCUS TEXT NOT NULL,
DEF TEXT NOT NULL,
ACC TEXT NOT NULL,
ORIGIN TEXT NOT NULL);
_END_

$dbh->do("DROP TABLE IF EXISTS $tableName");
$dbh->do($sqlCommand);


$fileName1 = "aerogenes.txt";
$fileName2 = "Cephalosporin.txt";
$fileName3 = "cloacae.txt";
$fileName4 = "oxytoca.txt";
$fileName5 = "pneumoniae.txt";



open(FD, "< $fileName1") || die("Error opening file... $fileName1\n$!\n");
$/ = undef;
my $aerogenes = <FD>;
close(FD);
$/ = "\n";

open(FD, "< $fileName2") || die("Error opening file... $fileName2\n$!\n");
$/ = undef;
my $cephalosporin = <FD>;
close(FD);
$/ = "\n";

open(FD, "< $fileName3") || die("Error opening file... $fileName3\n$!\n");
$/ = undef;
my $cloacae = <FD>;
close(FD);
$/ = "\n";

open(FD, "< $fileName4") || die("Error opening file... $fileName4\n$!\n");
$/ = undef;
my $oxytoca = <FD>;
close(FD);
$/ = "\n";

open(FD, "< $fileName5") || die("Error opening file... $fileName5\n$!\n");
$/ = undef;
my $pneu = <FD>;
close(FD);
$/ = "\n";
 
my @records1 = split('\n', $aerogenes);
my @records2 = split('\n', $cephalosporin);
my @records3 = split('\n', $cloacae);
my @records4 = split('\n', $oxytoca);
my @records5 = split('\n', $pneu);

 my @result = "";
 
foreach $aLine(@records1) {
  if ($aLine =~ /LOCUS/) {
    $aerogenes =~ /LOCUS(.*)DEFINITION/s;
	push @result, $1;
	;
  } 
  elsif ($aLine =~ /DEFINITION/){
    $aerogenes =~ /DEFINITION(.*)ACCESSION/s;
	push @result, $1;
  }
  elsif ($aLine =~ /ACCESSION/){
  $aerogenes =~ /ACCESSION(.*)VERSION/s;
  push @result, $1;
  }
 elsif ($aLine =~ /ORIGIN/){
  $aerogenes =~ /ORIGIN(.*)/s;
  my $aOrigin = $1;
  $aOrigin =~ s/\s//g;
  $aOrigin =~ s/[0-9]//g;
  push @result, $aOrigin;
 }
}

my $ceLine;
foreach $ceLine(@records2) {
  if ($ceLine =~ /LOCUS/) {
    $cephalosporin =~ /LOCUS(.*)DEFINITION/s;
	push @result, $1;
  } 
  elsif ($ceLine =~ /DEFINITION/){
    $cephalosporin =~ /DEFINITION(.*)ACCESSION/s;
	push @result, $1;
  }
  elsif ($ceLine =~ /ACCESSION/){
  $cephalosporin =~ /ACCESSION(.*)VERSION/s;
  push @result, $1;
  }
 elsif ($ceLine =~ /ORIGIN/){
  $cephalosporin =~ /ORIGIN(.*)/s;
    my $ceOrigin = $1;
  $ceOrigin =~ s/\s//g;
  $ceOrigin =~ s/[0-9]//g;
  push @result, $ceOrigin;
 }
}

my $cLine;
foreach $cLine(@records3) {
  if ($cLine =~ /LOCUS/) {
    $cloacae =~ /LOCUS(.*)DEFINITION/s;
	push @result, $1;
  } 
  elsif ($cLine =~ /DEFINITION/){
    $cloacae =~ /DEFINITION(.*)ACCESSION/s;
	push @result, $1;
  }
  elsif ($cLine =~ /ACCESSION/){
  $cloacae =~ /ACCESSION(.*)VERSION/s;
  push @result, $1;
  }
 elsif ($cLine =~ /ORIGIN/){
  $cloacae =~ /ORIGIN(.*)/s;
  my $cOrigin = $1;
  $cOrigin =~ s/\s//g;
  $cOrigin =~ s/[0-9]//g;
  push @result, $cOrigin;
  
 }
}

my $oLine;
foreach $oLine(@records4) {
  if ($oLine =~ /LOCUS/) {
    $oxytoca =~ /LOCUS(.*)DEFINITION/s;
	push @result, $1;
  } 
  elsif ($oLine =~ /DEFINITION/){
    $oxytoca =~ /DEFINITION(.*)ACCESSION/s;
	push @result, $1;
  }
  elsif ($oLine =~ /ACCESSION/){
  $oxytoca =~ /ACCESSION(.*)VERSION/s;
  push @result, $1;
  }
 elsif ($oLine =~ /ORIGIN/){
  $oxytoca =~ /ORIGIN(.*)/s;
  my $oOrigin = $1;
  $oOrigin =~ s/\s//g;
  $oOrigin =~ s/[0-9]//g;
  push @result, $oOrigin;
 }
}

my $pLine;
foreach $pLine(@records5) {
  if ($pLine =~ /LOCUS/) {
    $pneu =~ /LOCUS(.*)DEFINITION/s;
	push @result, $1;
  } 
  elsif ($pLine =~ /DEFINITION/){
    $pneu =~ /DEFINITION(.*)ACCESSION/s;
	push @result, $1;
  }
  elsif ($pLine =~ /ACCESSION/){
  $pneu =~ /ACCESSION(.*)VERSION/s;
  push @result, $1;
  }
 elsif ($pLine =~ /ORIGIN/){
  $pneu =~ /ORIGIN(.*)/s;
  my $pOrigin = $1;
  $pOrigin =~ s/\s//g;
  $pOrigin =~ s/[0-9]//g;
  push @result, $pOrigin;
 }
}


$sqlCommand = qq(INSERT INTO $tableName (ID, URL, LOCUS, DEF, ACC, ORIGIN)  
								VALUES (1, "$aURL", "$result[1]", "$result[2]", "$result[3]", "$result[4]"));

$dbh->do($sqlCommand) or die $DBI::errstr;
$sqlCommand = qq(INSERT INTO $tableName (ID, URL, LOCUS, DEF, ACC, ORIGIN)
								VALUES ('2', "$ceURL", "$result[5]", "$result[6]", "$result[7]", "$result[8]"));
$dbh->do($sqlCommand) or die $DBI::errstr;
$sqlCommand = qq(INSERT INTO $tableName  (ID, URL, LOCUS, DEF, ACC, ORIGIN)  
								VALUES ('3', "$cURL", "$result[9]", "$result[10]", "$result[11]", "$result[12]"));
$dbh->do($sqlCommand) or die $DBI::errstr;
$sqlCommand = qq(INSERT INTO $tableName  (ID, URL, LOCUS, DEF, ACC, ORIGIN) 
								VALUES ('4', "$pURL", "$result[13]", "$result[14]", "$result[15]", "$result[16]"));
$dbh->do($sqlCommand) or die $DBI::errstr;
$sqlCommand = qq(INSERT INTO $tableName (ID, URL, LOCUS, DEF, ACC, ORIGIN)
								VALUES ('5', "$oURL", "$result[17]", "$result[18]", "$result[19]", "$result[20]"));
$dbh->do($sqlCommand) or die $DBI::errstr;								

$dbh->disconnect();					









