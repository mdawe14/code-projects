#!c:\strawberry\perl\bin\perl.exe
# This is a Perl/Tk GUI app that will retrieve, process and display genbank data from NCBI.   

use strict;

use warnings;
use Bio::DB::GenBank;
use Bio::Restriction::EnzymeCollection ;
use Bio::Restriction::Analysis;
use Bio::SeqIO;
use Bio::Seq::RichSeq;
use LWP::Simple;  
use Email::Send;
use Email::Send::Gmail;
use Email::Simple::Creator;
use Tk;
;

require Tk::Dialog;
require Tk::ROText;

#Create GUI using perl TK 

my $sampleGenbank = <<'_END_';
LOCUS       SCU49845     5028 bp    DNA             PLN       21-JUN-1999
DEFINITION  Saccharomyces cerevisiae TCP1-beta gene, partial cds, and Axl2p
            (AXL2) and Rev7p (REV7) genes, complete cds.
ACCESSION   U49845
VERSION     U49845.1  GI:1293613
KEYWORDS    .
SOURCE      Saccharomyces cerevisiae (baker's yeast)
  ORGANISM  Saccharomyces cerevisiae
            Eukaryota; Fungi; Ascomycota; Saccharomycotina; Saccharomycetes;
            Saccharomycetales; Saccharomycetaceae; Saccharomyces.
REFERENCE   1  (bases 1 to 5028)
  AUTHORS   Torpey,L.E., Gibbs,P.E., Nelson,J. and Lawrence,C.W.
  TITLE     Cloning and sequence of REV7, a gene whose function is required for
            DNA damage-induced mutagenesis in Saccharomyces cerevisiae
  JOURNAL   Yeast 10 (11), 1503-1509 (1994)
  PUBMED    7871890
REFERENCE   2  (bases 1 to 5028)
  AUTHORS   Roemer,T., Madden,K., Chang,J. and Snyder,M.
  TITLE     Selection of axial growth sites in yeast requires Axl2p, a novel
            plasma membrane glycoprotein
  JOURNAL   Genes Dev. 10 (7), 777-793 (1996)
  PUBMED    8846915
REFERENCE   3  (bases 1 to 5028)
  AUTHORS   Roemer,T.
  TITLE     Direct Submission
  JOURNAL   Submitted (22-FEB-1996) Terry Roemer, Biology, Yale University, New
            Haven, CT, USA
FEATURES             Location/Qualifiers
     source          1..5028
                     /organism="Saccharomyces cerevisiae"
                     /db_xref="taxon:4932"
                     /chromosome="IX"
                     /map="9"
     CDS             <1..206
                     /codon_start=3
                     /product="TCP1-beta"
                     /protein_id="AAA98665.1"
                     /db_xref="GI:1293614"
                     /translation="SSIYNGISTSGLDLNNGTIADMRQLGIVESYKLKRAVVSSASEA
                     AEVLLRVDNIIRARPRTANRQHM"
     gene            687..3158
                     /gene="AXL2"
     CDS             687..3158
                     /gene="AXL2"
                     /note="plasma membrane glycoprotein"
                     /codon_start=1
                     /function="required for axial budding pattern of S.
                     cerevisiae"
                     /product="Axl2p"
                     /protein_id="AAA98666.1"
                     /db_xref="GI:1293615"
                     /translation="MTQLQISLLLTATISLLHLVVATPYEAYPIGKQYPPVARVNESF
                     TFQISNDTYKSSVDKTAQITYNCFDLPSWLSFDSSSRTFSGEPSSDLLSDANTTLYFN
                     VILEGTDSADSTSLNNTYQFVVTNRPSISLSSDFNLLALLKNYGYTNGKNALKLDPNE
                     VFNVTFDRSMFTNEESIVSYYGRSQLYNAPLPNWLFFDSGELKFTGTAPVINSAIAPE
                     TSYSFVIIATDIEGFSAVEVEFELVIGAHQLTTSIQNSLIINVTDTGNVSYDLPLNYV
                     YLDDDPISSDKLGSINLLDAPDWVALDNATISGSVPDELLGKNSNPANFSVSIYDTYG
                     DVIYFNFEVVSTTDLFAISSLPNINATRGEWFSYYFLPSQFTDYVNTNVSLEFTNSSQ
                     DHDWVKFQSSNLTLAGEVPKNFDKLSLGLKANQGSQSQELYFNIIGMDSKITHSNHSA
                     NATSTRSSHHSTSTSSYTSSTYTAKISSTSAAATSSAPAALPAANKTSSHNKKAVAIA
                     CGVAIPLGVILVALICFLIFWRRRRENPDDENLPHAISGPDLNNPANKPNQENATPLN
                     NPFDDDASSYDDTSIARRLAALNTLKLDNHSATESDISSVDEKRDSLSGMNTYNDQFQ
                     SQSKEELLAKPPVQPPESPFFDPQNRSSSVYMDSEPAVNKSWRYTGNLSPVSDIVRDS
                     YGSQKTVDTEKLFDLEAPEKEKRTSRDVTMSSLDPWNSNISPSPVRKSVTPSPYNVTK
                     HRNRHLQNIQDSQSGKNGITPTTMSTSSSDDFVPVKDGENFCWVHSMEPDRRPSKKRL
                     VDFSNKSNVNVGQVKDIHGRIPEML"
     gene            complement(3300..4037)
                     /gene="REV7"
     CDS             complement(3300..4037)
                     /gene="REV7"
                     /codon_start=1
                     /product="Rev7p"
                     /protein_id="AAA98667.1"
                     /db_xref="GI:1293616"
                     /translation="MNRWVEKWLRVYLKCYINLILFYRNVYPPQSFDYTTYQSFNLPQ
                     FVPINRHPALIDYIEELILDVLSKLTHVYRFSICIINKKNDLCIEKYVLDFSELQHVD
                     KDDQIITETEVFDEFRSSLNSLIMHLEKLPKVNDDTITFEAVINAIELELGHKLDRNR
                     RVDSLEEKAEIERDSNWVKCQEDENLPDNNGFQPPKIKLTSLVGSDVGPLIIHQFSEK
                     LISGDDKILNGVYSQYEEGESIFGSLF"
ORIGIN
        1 gatcctccat atacaacggt atctccacct caggtttaga tctcaacaac ggaaccattg
       61 ccgacatgag acagttaggt atcgtcgaga gttacaagct aaaacgagca gtagtcagct
      121 ctgcatctga agccgctgaa gttctactaa gggtggataa catcatccgt gcaagaccaa
      181 gaaccgccaa tagacaacat atgtaacata tttaggatat acctcgaaaa taataaaccg
      241 ccacactgtc attattataa ttagaaacag aacgcaaaaa ttatccacta tataattcaa
      301 agacgcgaaa aaaaaagaac aacgcgtcat agaacttttg gcaattcgcg tcacaaataa
      361 attttggcaa cttatgtttc ctcttcgagc agtactcgag ccctgtctca agaatgtaat
      421 aatacccatc gtaggtatgg ttaaagatag catctccaca acctcaaagc tccttgccga
      481 gagtcgccct cctttgtcga gtaattttca cttttcatat gagaacttat tttcttattc
      541 tttactctca catcctgtag tgattgacac tgcaacagcc accatcacta gaagaacaga
      601 acaattactt aatagaaaaa ttatatcttc ctcgaaacga tttcctgctt ccaacatcta
      661 cgtatatcaa gaagcattca cttaccatga cacagcttca gatttcatta ttgctgacag
      721 ctactatatc actactccat ctagtagtgg ccacgcccta tgaggcatat cctatcggaa
      781 aacaataccc cccagtggca agagtcaatg aatcgtttac atttcaaatt tccaatgata
      841 cctataaatc gtctgtagac aagacagctc aaataacata caattgcttc gacttaccga
      901 gctggctttc gtttgactct agttctagaa cgttctcagg tgaaccttct tctgacttac
      961 tatctgatgc gaacaccacg ttgtatttca atgtaatact cgagggtacg gactctgccg
     1021 acagcacgtc tttgaacaat acataccaat ttgttgttac aaaccgtcca tccatctcgc
     1081 tatcgtcaga tttcaatcta ttggcgttgt taaaaaacta tggttatact aacggcaaaa
     1141 acgctctgaa actagatcct aatgaagtct tcaacgtgac ttttgaccgt tcaatgttca
     1201 ctaacgaaga atccattgtg tcgtattacg gacgttctca gttgtataat gcgccgttac
     1261 ccaattggct gttcttcgat tctggcgagt tgaagtttac tgggacggca ccggtgataa
     1321 actcggcgat tgctccagaa acaagctaca gttttgtcat catcgctaca gacattgaag
     1381 gattttctgc cgttgaggta gaattcgaat tagtcatcgg ggctcaccag ttaactacct
     1441 ctattcaaaa tagtttgata atcaacgtta ctgacacagg taacgtttca tatgacttac
     1501 ctctaaacta tgtttatctc gatgacgatc ctatttcttc tgataaattg ggttctataa
     1561 acttattgga tgctccagac tgggtggcat tagataatgc taccatttcc gggtctgtcc
     1621 cagatgaatt actcggtaag aactccaatc ctgccaattt ttctgtgtcc atttatgata
     1681 cttatggtga tgtgatttat ttcaacttcg aagttgtctc cacaacggat ttgtttgcca
     1741 ttagttctct tcccaatatt aacgctacaa ggggtgaatg gttctcctac tattttttgc
     1801 cttctcagtt tacagactac gtgaatacaa acgtttcatt agagtttact aattcaagcc
     1861 aagaccatga ctgggtgaaa ttccaatcat ctaatttaac attagctgga gaagtgccca
     1921 agaatttcga caagctttca ttaggtttga aagcgaacca aggttcacaa tctcaagagc
     1981 tatattttaa catcattggc atggattcaa agataactca ctcaaaccac agtgcgaatg
     2041 caacgtccac aagaagttct caccactcca cctcaacaag ttcttacaca tcttctactt
     2101 acactgcaaa aatttcttct acctccgctg ctgctacttc ttctgctcca gcagcgctgc
     2161 cagcagccaa taaaacttca tctcacaata aaaaagcagt agcaattgcg tgcggtgttg
     2221 ctatcccatt aggcgttatc ctagtagctc tcatttgctt cctaatattc tggagacgca
     2281 gaagggaaaa tccagacgat gaaaacttac cgcatgctat tagtggacct gatttgaata
     2341 atcctgcaaa taaaccaaat caagaaaacg ctacaccttt gaacaacccc tttgatgatg
     2401 atgcttcctc gtacgatgat acttcaatag caagaagatt ggctgctttg aacactttga
     2461 aattggataa ccactctgcc actgaatctg atatttccag cgtggatgaa aagagagatt
     2521 ctctatcagg tatgaataca tacaatgatc agttccaatc ccaaagtaaa gaagaattat
     2581 tagcaaaacc cccagtacag cctccagaga gcccgttctt tgacccacag aataggtctt
     2641 cttctgtgta tatggatagt gaaccagcag taaataaatc ctggcgatat actggcaacc
     2701 tgtcaccagt ctctgatatt gtcagagaca gttacggatc acaaaaaact gttgatacag
     2761 aaaaactttt cgatttagaa gcaccagaga aggaaaaacg tacgtcaagg gatgtcacta
     2821 tgtcttcact ggacccttgg aacagcaata ttagcccttc tcccgtaaga aaatcagtaa
     2881 caccatcacc atataacgta acgaagcatc gtaaccgcca cttacaaaat attcaagact
     2941 ctcaaagcgg taaaaacgga atcactccca caacaatgtc aacttcatct tctgacgatt
     3001 ttgttccggt taaagatggt gaaaattttt gctgggtcca tagcatggaa ccagacagaa
     3061 gaccaagtaa gaaaaggtta gtagattttt caaataagag taatgtcaat gttggtcaag
     3121 ttaaggacat tcacggacgc atcccagaaa tgctgtgatt atacgcaacg atattttgct
     3181 taattttatt ttcctgtttt attttttatt agtggtttac agatacccta tattttattt
     3241 agtttttata cttagagaca tttaatttta attccattct tcaaatttca tttttgcact
     3301 taaaacaaag atccaaaaat gctctcgccc tcttcatatt gagaatacac tccattcaaa
     3361 attttgtcgt caccgctgat taatttttca ctaaactgat gaataatcaa aggccccacg
     3421 tcagaaccga ctaaagaagt gagttttatt ttaggaggtt gaaaaccatt attgtctggt
     3481 aaattttcat cttcttgaca tttaacccag tttgaatccc tttcaatttc tgctttttcc
     3541 tccaaactat cgaccctcct gtttctgtcc aacttatgtc ctagttccaa ttcgatcgca
     3601 ttaataactg cttcaaatgt tattgtgtca tcgttgactt taggtaattt ctccaaatgc
     3661 ataatcaaac tatttaagga agatcggaat tcgtcgaaca cttcagtttc cgtaatgatc
     3721 tgatcgtctt tatccacatg ttgtaattca ctaaaatcta aaacgtattt ttcaatgcat
     3781 aaatcgttct ttttattaat aatgcagatg gaaaatctgt aaacgtgcgt taatttagaa
     3841 agaacatcca gtataagttc ttctatatag tcaattaaag caggatgcct attaatggga
     3901 acgaactgcg gcaagttgaa tgactggtaa gtagtgtagt cgaatgactg aggtgggtat
     3961 acatttctat aaaataaaat caaattaatg tagcatttta agtataccct cagccacttc
     4021 tctacccatc tattcataaa gctgacgcaa cgattactat tttttttttc ttcttggatc
     4081 tcagtcgtcg caaaaacgta taccttcttt ttccgacctt ttttttagct ttctggaaaa
     4141 gtttatatta gttaaacagg gtctagtctt agtgtgaaag ctagtggttt cgattgactg
     4201 atattaagaa agtggaaatt aaattagtag tgtagacgta tatgcatatg tatttctcgc
     4261 ctgtttatgt ttctacgtac ttttgattta tagcaagggg aaaagaaata catactattt
     4321 tttggtaaag gtgaaagcat aatgtaaaag ctagaataaa atggacgaaa taaagagagg
     4381 cttagttcat cttttttcca aaaagcaccc aatgataata actaaaatga aaaggatttg
     4441 ccatctgtca gcaacatcag ttgtgtgagc aataataaaa tcatcacctc cgttgccttt
     4501 agcgcgtttg tcgtttgtat cttccgtaat tttagtctta tcaatgggaa tcataaattt
     4561 tccaatgaat tagcaatttc gtccaattct ttttgagctt cttcatattt gctttggaat
     4621 tcttcgcact tcttttccca ttcatctctt tcttcttcca aagcaacgat ccttctaccc
     4681 atttgctcag agttcaaatc ggcctctttc agtttatcca ttgcttcctt cagtttggct
     4741 tcactgtctt ctagctgttg ttctagatcc tggtttttct tggtgtagtt ctcattatta
     4801 gatctcaagt tattggagtc ttcagccaat tgctttgtat cagacaattg actctctaac
     4861 ttctccactt cactgtcgag ttgctcgttt ttagcggaca aagatttaat ctcgttttct
     4921 ttttcagtgt tagattgctc taattctttg agctgttctc tcagctcctc atatttttct
     4981 tgccatgact cagattctaa ttttaagcta ttcaatttct ctttgatc
//
_END_


my $instructions = <<'_END_';
1. Enter an Accession number of interest
2. If you would simply like to disaply the GenBank page select "DISPLAY"
3. If you would like to cleave a subset of your data select "CLEAVE" insert the subset of the sequence you would like to study
and enter the restrction enzyme sequence in "sequence", you may also load a sequence from your local machine
4. If you would like to align your data with a sequence select "PWSA" insert the subset of the sequence you would like to study
and enter the comparison sequence in "sequence", you may also load a sequence from your local machine
5.  If you would like your data sent to you enter a valid email address
6. Select "Process" 

_END_
# Main Window
my $mw = new MainWindow;
$mw->geometry("1000x600");
$mw->resizable(0, 0); # do not allow window to be resized
$mw->title("BIF724 Project....");

# add help menu (with 2 options) to window
$mw->configure(-menu => my $menubar = $mw->Menu);
my $help = $menubar->cascade(-label => 'Help');
$help->command(-label=>'Version',
               -command=>sub { $mw->Dialog(-title=>'Project Version...', -text =>'Version 0.2'.' '.'Date: 2017-04-10',
                                           -default_button=>'OK')->Show( ); });
$help->command(-label=>'About',
               -command=>sub { $mw->Dialog(-title=>'About...', -text => $instructions,
                                           -default_button=>'OK')->Show( ); });

# main window widgets
my $accTitle  = $mw->Label(-text=>"Enter NCBI accession number...")->place(-x=>80, -y=>5);
my $accLabel  = $mw->Label(-text=>"Accession:")->place(-x=>10, -y=>25);
my $accEntry  = $mw->Entry( )->place(-x=>80, -y=>25);
my $query     = $mw->Label(-text=>"Query Subrange...")->place(-x=>300, -y=>5);
my $fromLabel = $mw->Label(-text=>"From:")->place(-x=>300, -y=>25);
my $fromEntry = $mw->Entry( )->place(-x=>340, -y=>25);
my $toLabel   = $mw->Label(-text=>"To:")->place(-x=>300, -y=>50);
my $toEntry   = $mw->Entry( )->place(-x=>340, -y=>50);

my $resTitle  = $mw->Label(-text=>"Enter sequence...")->place(-x=>80, -y=>70);
my $resLabel  = $mw->Label(-text=>"Sequence:")->place(-x=>10, -y=>90);

my $seqData="";
my $seqFile="";
my $email="";

my $resEntry  = $mw->Entry(-width=>80, -textvariable=>\$seqData)->place(-x=>80, -y=>90);

my $browseButton = $mw->Button(-text => 'Browse...',
                               -command => sub { # inline subroutine to read file data
                                                 $seqFile = $mw->getOpenFile( );
                                                 print "seqFile: $seqFile\n";
                                                 $/ = undef;
                                                 open(FD, "< $seqFile");
                                                 $seqData = <FD>;
                                                 $/ = "\n";
                                                 close(FD);
                                               }
                               )->place(-x=>600, -y=>85);

my $seqType = "";
my @options = qw/DISPLAY PWSA CLEAVE/;

my $jobLabel  = $mw->Label(-text=>"Function:")->place(-x=>10, -y=>130);

my $menu = $mw->Optionmenu(
    -variable => \$seqType,
    -options  => [@options],
    -command  => [sub {print "args=$seqType\n"}]
    )->place(-x=>80, -y=>130);

# for debug purposes
print "seqType is: $seqType\n";


my $emailLabel  = $mw->Label(-text=>"Email:")->place(-x=>400, -y=>130);
my $emailEntry  = $mw->Entry(-width=>50, -textvariable=>\$email)->place(-x=>450, -y=>130);

# main output window configured as a scrollable window attached to a new frame
my $textArea = $mw->Frame(-width=>100, -height=>50, -borderwidth=>1, -relief=>'groove')->place(-x=>80,-y=>190);
my $output = $textArea->Scrolled('ROText', -scrollbars=>'se', -height=>25,
                                 -width=>80, -wrap=>'none')->pack(-side=>'left',
                                                                  -pady=>'5',
                                                                  -padx=>'5');
$output->configure(-background => "GREY");
$output->insert('end', "$sampleGenbank");

my $processButton = $mw->Button(-text=>"Process", -command=>\&button1Sub)->place(-x=>700, -y=>190);
my $exitButton    = $mw->Button(-text=>"Exit",    -command=>\&button2Sub)->place(-x=>700, -y=>220);

# if DISPLAY is chosen the GUI will display genbank data from user entered accession number.  If email is entered will send information to a vlid email address.   
sub button1Sub {
   $mw->messageBox(-message=>"Processing...", -type=>"OK");
   my @fragments;
    my $accNum = $accEntry->get(); 
	
   if ($seqType eq $options[0]){
	  my $ncbiURL = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=$accNum&rettype=gb";
	  my $text = get $ncbiURL;  
	  $output -> Contents($text);
	  
	  print $email, "\n";
	  
     my $emailSend = Email::Simple->create( 
	                  header => [
					       From => 'meldawe14@gmail.com',
						   To => $email,
						   Subject => 'GenBank Results',
	                     ],
						 body => $text,
						 );
	  my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => 'meldawe14@gmail.com',
              password => 'Goose2014@',
          ]
      }
  );
  eval { $sender->send($emailSend) };
  die "Error sending email: $@" if $@;
     
					
#if PWSA is chosen will align Genbank sequence and user entered sequence, results can be emailed
	  }
	if ($seqType eq $options[1]) {
	  my ($low, $high) = 0; 
	  my $db = Bio::DB::GenBank->new();
	  my $sequence = $db->get_Seq_by_acc($accNum);
	  my $seq = $sequence->seq; 
	  my $from = $fromEntry->get();
	  my $to = $toEntry->get(); 
	  my $formatSeq = substr($seq, $from, $to);
            my $result;
            if($high==0 && $low==0){
                $result = $formatSeq;
            }
            else{
                $result = substr($formatSeq,$low-1,$high-$low+1);
            }
            my $endresult= align(uc $result, uc $seqData);
            $output->delete("1.0",'end');
            $output->insert('end', "$endresult");
                 my $emailSend = Email::Simple->create( 
	                  header => [
					       From => 'meldawe14@gmail.com',
						   To => $email,
						   Subject => 'GenBank Results',
	                     ],
						 body => $endresult,
						 );
	  my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => 'meldawe14@gmail.com',
              password => 'Goose2014@',
          ]
      }
  );
  eval { $sender->send($emailSend) };
  die "Error sending email: $@" if $@;
  
  #if CLEAVE is chosen, program will cleave the Genbank sequence from the user defined sequence.  EMail may be set with output
	  
	}
	if ($seqType eq $options[2]) {
	  my $db = Bio::DB::GenBank->new();
	  my $seq = $db->get_Seq_by_acc($accNum);
	  my $sequence = $seq->seq; 
	  my $from = $fromEntry->get();
	  my $to = $toEntry->get(); 
	  my $formatSeq = substr($sequence, $from, $to);
	  my $seq_obj = new Bio::PrimarySeq(-seq => $formatSeq) ;
	  my $re = Bio::Restriction::Enzyme->new (-enzyme =>'RI', -seq => $seqData);
	  my $ra = Bio::Restriction::Analysis->new(-seq=>$seq_obj, -enzymes=>$re); 
      my @fragments = $ra->fragments('RI'); 
	  my $frag = join "\n", @fragments;
	 # $output->Contents($frag);
	   
	 #print $fragments[1], "\n";
	 
	 my $result = "";
	 
	 for (my $j = 0; $j < scalar(@fragments); $j++){
	 my $finalCleave = "";
	 
	   for (my $i = 0; $i < length($fragments[$j]); $i++) {
	      
		  #print length($fragments[$j]), "\n";
		  #print scalar(@fragments), "\n";
	      if ($i == 0) {
		     #print "1";
			 $finalCleave .= "1";
			
		  }
		  elsif ($i % 60 == 0) {
		     print "$i";
			 $finalCleave .= "$i";
			 $i += (length($i) -1); 
		  }
		  else {
		  $finalCleave .= " "; 
		     print " "; 
		  }  
	   }
	   
	   $result .= $finalCleave;
	   $result .= "\n";
	   $result .= $fragments[$j]; 
	   $result .= "\n";
	   
	   $output->delete("1.0",'end');
	   $output -> insert('1.0', "$finalCleave\n$fragments[$j]\n\n");
	   #print "\n";
	   print "$finalCleave\n";
	   print "$fragments[$j] \n";

	   }
	  my $emailSend = Email::Simple->create( 
	                  header => [
					       From => 'meldawe14@gmail.com',
						   To => $email,
						   Subject => 'GenBank Results',
	                     ],
						 body => $result,
						 );
	  my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => 'meldawe14@gmail.com',
              password => 'Goose2014@',
          ]
      }
  );
  eval { $sender->send($emailSend) };
  die "Error sending email: $@" if $@;
	   
	   }

	  }
	 

sub button2Sub {
   my $dialog = $mw->DialogBox(-title => 'Are you sure?', -buttons => ['Exit', 'Cancel'],
                     -default_button => 'Exit');
   my $answer = $dialog->Show( );
   if($answer eq "Exit") {
      exit;
   }
}

#subroutine for PWSA.
sub align($$);
sub align($$){

my $firstsequence = shift @_;
my $secondsequence = shift @_;
my ($match,$mismatch,$gop,$gep,@name_list0,@name_list1,@seq_list0,@seq_list1,@res0,@res1,$len0,$len1,@smat,@tb,@aln0,@aln1);
$match=10;
$mismatch=-10;
$gop=-10;
$gep=-10;

# Read The two sequences from two fasta format file:

#extract the names and the sequences
@name_list0="seq1";
@seq_list0 = $firstsequence;

@name_list1="seq2";
@seq_list1 = $secondsequence;

# get rid of the newlines, spaces and numbers
foreach my $seq (@seq_list0)
	{
	# get rid of the newlines, spaces and numbers
	$seq=~s/[\s\d]//g;	
	}
foreach my $seq (@seq_list1)
	{
	# get rid of the newlines, spaces and numbers
	$seq=~s/[\s\d]//g;	
	}

# split the sequences
for (my $i=0; $i<=$#name_list0; $i++)
	{
	$res0[$i]=[$seq_list0[$i]=~/([a-zA-Z-]{1})/g];
	}
for (my $i=0; $i<=$#name_list1; $i++)
	{
	$res1[$i]=[$seq_list1[$i]=~/([a-zA-Z-]{1})/g];
	}

#evaluate substitutions
$len0=$#{$res0[0]}+1;
$len1=$#{$res1[0]}+1;

for (my $i=0; $i<=$len0; $i++){$smat[$i][0]=$i*$gep;$tb[$i][0 ]= 1;}
for (my $j=0; $j<=$len1; $j++){$smat[0][$j]=$j*$gep;$tb[0 ][$j]=-1;}
	
for (my $i=1; $i<=$len0; $i++)
	{
	for (my $j=1; $j<=$len1; $j++)
		{
		#calcul du score
        my $s;
		if ($res0[0][$i-1] eq $res1[0][$j-1]){$s=$match;}
		else { $s=$mismatch;}
		
		my $sub=$smat[$i-1][$j-1]+$s;
		my $del=$smat[$i  ][$j-1]+$gep;
		my $ins=$smat[$i-1][$j  ]+$gep;
		
		if   ($sub>$del && $sub>$ins){$smat[$i][$j]=$sub;$tb[$i][$j]=0;}
		elsif($del>$ins){$smat[$i][$j]=$del;$tb[$i][$j]=-1;}
		else {$smat[$i][$j]=$ins;$tb[$i][$j]=1;}
		}
	}

my $i=$len0;
my $j=$len1;
my $aln_len=0;

while (!($i==0 && $j==0))
	{
	if ($tb[$i][$j]==0)
		{
		$aln0[$aln_len]=$res0[0][--$i];
		$aln1[$aln_len]=$res1[0][--$j];
		}
	elsif ($tb[$i][$j]==-1)
		{
		$aln0[$aln_len]='-';
		$aln1[$aln_len]=$res1[0][--$j];
		}
	elsif ($tb[$i][$j]==1)
		{
		$aln0[$aln_len]=$res0[0][--$i];
		$aln1[$aln_len]='-';
		}
	$aln_len++;
	
	}
#Output en Fasta:
my $end;
$end .=">$name_list0[0]\n";
for ($i=$aln_len-1; $i>=0; $i--){$end.= $aln0[$i];}
$end.= "\n";
$end.= ">$name_list1[0]\n";
for ($j=$aln_len-1; $j>=0; $j--){$end.= $aln1[$j];}
$end.= "\n";

return $end;	 
		 
}

MainLoop;
