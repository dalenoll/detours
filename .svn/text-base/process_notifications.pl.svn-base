#!/usr/bin/perl
#
# Process detour notifications
# --------------------------------
#
# ===============================================================================
# Revision History
# ================
#
#  Date       Who  Description
# ----------  ---  ------------------------------------------------------------
#
# 09/18/2009  DRN  Fixed problem where PDF was created in wrong location
# 10/18/2009  DRN  Added Getopt::Long to allow --e and --socket switches
# 06/28/2010  DRN  Changed the call file to allow the database to store the full asterisk dial string
#                  This allows the use of IAX2 trunks for users on switches other than Nortel 61.
# 07/20/2010  DRN  Changed the sender in e-mailed notifications
#
#
# ===============================================================================
# 

use strict;
use DBI();
use PDF::API2;
use Getopt::Long;

#
# For the PDF creation
#
use constant mm => 25.4 / 72;
use constant in => 1 / 72;
use constant pt => 1;

#
# These constants are in points
#
use constant letterWidth => 612;
use constant letterWidthCenter => 612 / 2;
use constant letterHeight => 792;

use constant headerYPos => 754;
use constant columnTop => 722;
use constant leftMargin => 18;
use constant rightMargin => 18;
use constant bottomMargin => 19;

use constant rowHeight => 16;
use constant leftColumnX => 111;
use constant rightColumnX => letterWidthCenter + leftColumnX;
use constant rightEdge => letterWidth - rightMargin;


use constant defaultPDFPath => "/var/www/html/detour/pdfs/";
our %settings;

#
# call notification constants
#
use constant defaultAsteriskCallDir => "/var/spool/asterisk/outgoing/";
use constant defaultAsteriskCallTemp => "/tmp";


print "===================================================================================\n";
print " process_notifications.pl - Started:  ", `date`;
print "===================================================================================\n";

#
# Get Options
#
my $environment="development";
my $socket="/var/lib/mysql/mysql.sock";

GetOptions( 	'e=s' => \$environment,
		'socket=s' => \$socket );

print "Environment = $environment\n";
# print "Socket = $socket\n";


my $database;
my $user;
my $password;
my $host;

if( $environment eq "production" ) {
	$database="detour";
	$user="detour";
	$password="detour";
	$host="localhost";
} elsif( $environment eq "development" ) {
	$database="detour_development";
	$user="detour";
	$password="detour";
	$host="localhost";
} else {
	print "Invalid value for environment: $environment\n";
	exit 1;
}

#
# Connect to the database
#
my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host;mysql_socket=$socket", 
				$user, $password, 
				{'RaiseError' => 1});

&readSettings($dbh);

#
# Create any PDF files that have not been created
&createUnprocessedPDFs($dbh);

#
# build a list of locations for later use
my %locations = &buildLocationsHash($dbh);

# foreach my $loc ( keys %locations ) {
# 	print "$loc(", $locations{$loc}->{'ID'}, "): ";
# 	print "FAX   = ", $locations{$loc}->{'FAX'}, "    ";
# 	print "EMAIL = ", $locations{$loc}->{'EMAIL'}, "    ";
# 	print "PRINT = ", $locations{$loc}->{'PRINT'}, "    ";
# 	print "CALL  = ", $locations{$loc}->{'CALL'}, "\n";
# }

#
# handle unsent notifications
&sendNotifications($dbh);



print "===================================================================================\n";
print " process_notifications.pl - Ended:    ", `date`;
print "===================================================================================\n";


exit;

#
# Read the system settings and place in a global hash
sub readSettings {
  my $dbh = shift;

  my $sth = $dbh->prepare("select parameter, value from settings");
  $sth->execute;

  my $hashref = $sth->fetchall_hashref('parameter');

  foreach my $param (keys %$hashref) {
    print "'$param'  - '$hashref->{$param}->{value}'\n";
    $settings{$param} = $hashref->{$param}->{value};
  }

}

#
# Select records from the detour table that do not have a PDF pathname and create the PDF
#
sub createUnprocessedPDFs {


	my $pathname;

	print "Creating any unprocessed detour documents\n";
	#
	# NEW detours
	#
	#
	# Select any detours that do not have a PDF for a new detour
	#
	print "  Checking new detours...\n";
	my $count=0;
	my $sth = $dbh->prepare("SELECT * FROM detours where (create_pdf_path is NULL or create_pdf_path = '') and canceled is null");
	$sth->execute();
	while (my $ref = $sth->fetchrow_hashref()) {
		print "    Found a new detour: id = $ref->{'id'}, Route = $ref->{'route'}\n";
		$pathname = createDetourPDF(
			$ref->{'id'},
			$ref->{'start_date'},
			$ref->{'start_time'},
			$ref->{'end_date'},
			$ref->{'end_time'},
			$ref->{'route'},
			$ref->{'direction'},
			$ref->{'description'},
			$ref->{'reason'},
			$ref->{'supervisor'},
			$ref->{'dispatcher'},
			$ref->{'detour_type'},
			'DETON',
			$ref->{'created_at'}	
			);

		print "          Created $pathname\n";
		my $upd = $dbh->prepare("update detours set create_pdf_path = ? where id = ?");
		$upd->execute($pathname, $ref->{'id'});
		$upd->finish();
		$count++;
	}
	$sth->finish();
	print "  $count documents created\n";

	#
	# Canceled detours
	#
	#
	# Select any detours that do not have a PDF for a canceled detour
	#
	print "  Checking canceled detours...\n";
	my $sth = $dbh->prepare("SELECT * FROM detours where (cancel_pdf_path is NULL or cancel_pdf_path = '') and canceled = 1");
	$sth->execute();
	$count=0;
	while (my $ref = $sth->fetchrow_hashref()) {
		print "    Found a canceled detour: id = $ref->{'id'}, Route = $ref->{'route'}\n";
		$pathname = createDetourPDF(
			$ref->{'id'},
			$ref->{'start_date'},
			$ref->{'start_time'},
			$ref->{'end_date'},
			$ref->{'end_time'},
			$ref->{'route'},
			$ref->{'direction'},
			$ref->{'description'},
			$ref->{'reason'},
			$ref->{'supervisor'},
			$ref->{'dispatcher'},
			$ref->{'detour_type'},
			'DETOFF',
			$ref->{'cancel_date'}
			);

		print "          Created $pathname\n";
		my $upd = $dbh->prepare("update detours set cancel_pdf_path = ? where id = ?");
		$upd->execute($pathname, $ref->{'id'});
		$upd->finish();
		$count++;
	}
	$sth->finish();
	print "  $count documents created\n";

	#
	# Changed detours
	#
	#
	# Select any detours that do not have a PDF for a changed detour
	#
	print "  Checking changed detours...\n";
	my $sth = $dbh->prepare("SELECT * FROM detours where (change_pdf_path is NULL or change_pdf_path = '') and change_at is not NULL and canceled is NULL");
	$sth->execute();
	$count=0;
	while (my $ref = $sth->fetchrow_hashref()) {
		print "    Found a changed detour: id = $ref->{'id'}, Route = $ref->{'route'}\n";
		$pathname = createDetourPDF(
			$ref->{'id'},
			$ref->{'start_date'},
			$ref->{'start_time'},
			$ref->{'end_date'},
			$ref->{'end_time'},
			$ref->{'route'},
			$ref->{'direction'},
			$ref->{'description'},
			$ref->{'reason'},
			$ref->{'supervisor'},
			$ref->{'dispatcher'},
			$ref->{'detour_type'},
			'DETCHG',
			$ref->{'change_at'}

			);

		print "          Created $pathname\n";
		my $upd = $dbh->prepare("update detours set change_pdf_path = ? where id = ?");
		$upd->execute($pathname, $ref->{'id'});
		$upd->finish();
		$count++;
	}
	$sth->finish();
	print "  $count documents created\n";

}

#
# Build a PDF for a new detour
# Takes a bunch of arguments from the detour record
# returns the pathname of the file created
#
sub createDetourPDF {

	my $detour_id = shift;
	my $start_date = shift;
	my $start_time = shift;
	my $end_date = shift;
	my $end_time = shift;
	my $route = shift;
	my $direction = shift;
	my $description = shift;
	my $reason = shift;
	my $supervisor = shift;
	my $dispatcher = shift;
	my $detour_type = shift;
	my $doc_type = shift;
	my $change_cancel_date = shift;

	my $pathname = defaultPDFPath;
        $pathname = $settings{'pdf_path'} if exists $settings{'pdf_path'};
        $pathname .= '/' if $pathname =~ m~[^/]$~;


	my $filename;
	if($doc_type eq 'DETOFF' ) {
		$filename = "detour_" . $detour_id . "_off.pdf";
	} elsif($doc_type eq 'DETCHG' ) {
		$filename = "detour_" . $detour_id . "_chg.pdf";
	} else {
		$filename = "detour_" . $detour_id . "_on.pdf";
	}
        $pathname .= $filename;

	print "     ----- createDetourPDF:  Pathname = $pathname\n";

	$start_date =~ s~(....)-(..)-(..)~$2/$3/$1~;
	$start_time =~ s~00:00:00~~;
	$start_time =~ s~(..:..):..~$1~;
	$end_date =~ s~(....)-(..)-(..)~$2/$3/$1~;
	$end_time =~ s~00:00:00~~;
	$end_time =~ s~(..:..):..~$1~;
	$change_cancel_date =~ s~(....)-(..)-(..) (\d\d:\d\d):\d\d~$2/$3/$1 $4~;

	print "    In Direction: $direction\n";
	$direction = "All" if $direction eq 5;
	$direction = "Both" if $direction eq 4;
	$direction = "Northbound" if $direction eq 0;
	$direction = "Southbound" if $direction eq 1;
	$direction = "Eastbound" if $direction eq 2;
	$direction = "Westbound" if $direction eq 3;
	print "   Out Direction: $direction\n";

	my $detourTypeText;
	$detourTypeText = "UNPLANNED - No Schedule Change" if $detour_type == 1;
	$detourTypeText = "PLANNED - Schedule Changed" if $detour_type == 2;
	$detourTypeText = "UNPLANNED - Schedule Changed" if $detour_type == 3;
	$detourTypeText = "PLANNED - No Schedule Change" if $detour_type == 4;


	my $pdf = PDF::API2->new(-file => $pathname);
	my %font = (
    	Helvetica => {
        	Bold   => $pdf->corefont( 'Helvetica-Bold',    -encoding => 'latin1' ),
	        Roman  => $pdf->corefont( 'Helvetica',         -encoding => 'latin1' ),
    	    Italic => $pdf->corefont( 'Helvetica-Oblique', -encoding => 'latin1' ),
	    },
    	Times => {
        	Bold   => $pdf->corefont( 'Times-Bold',   -encoding => 'latin1' ),
	        Roman  => $pdf->corefont( 'Times',        -encoding => 'latin1' ),
    	    Italic => $pdf->corefont( 'Times-Italic', -encoding => 'latin1' ),
	    },
	);

	#
	# Create the page
	#
	my $page = $pdf->page;
	$page->mediabox('Letter');
	$page->cropbox('Letter');

	# Text Area
	my $text = $page->text;

	#
	# Watermark
	#
	if($doc_type eq 'DETOFF' ) {
		$text->font( $font{'Times'}{'Bold'}, 175/pt );
		$text->strokecolor('black');
		$text->fillcolor('gray80');
		$text->transform(-translate=>[100,100], -rotate=>45);
		$text->text("Canceled");
		$text->font( $font{'Times'}{'Bold'}, 20/pt );
		$text->transform(-translate=>[300,250], -rotate=>45);
		$text->text($change_cancel_date);
	}

	if($doc_type eq 'DETCHG' ) {
		$text->font( $font{'Times'}{'Bold'}, 175/pt );
		$text->strokecolor('black');
		$text->fillcolor('gray80');
		$text->transform(-translate=>[100,100], -rotate=>45);
		$text->text("Updated");
		$text->font( $font{'Times'}{'Bold'}, 20/pt );
		$text->transform(-translate=>[300,250], -rotate=>45);
		$text->text($change_cancel_date);
	}

	# HEADING
	#
	# center the heading text so do some math
	#
	$text->font( $font{'Helvetica'}{'Bold'}, 24/pt );
	$text->fillcolor('black');
	my $headingText = "Detour Instructions";
	my $headingWidth = $text->advancewidth($headingText);
	my $xpos = letterWidthCenter - ($headingWidth / 2 );
	$text->translate( $xpos, headerYPos );
	$text->text($headingText);

	#
	# horizontal line full width
	#
	my $headerLine = $page->gfx;
	$headerLine->strokecolor('black');
	$headerLine->move(leftMargin,745);
	$headerLine->line(letterWidth - rightMargin,745);
	$headerLine->stroke;

	my $ypos = columnTop;
	
	#
	# Line 
	#
	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );

	$headingText = "Detour id:";
	$text->translate(leftMargin , $ypos);
	$text->text($headingText);

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->translate(leftColumnX, $ypos);
	$headingText = $start_date . "  " . $start_time;
	$text->text($detour_id);

	#
	# Line 
	#
	$ypos -= rowHeight;
	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );

	$text->translate(leftMargin , $ypos);
	$text->text("Detour Start:");

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->translate(leftColumnX, $ypos);
	$headingText = $start_date . "  " . $start_time;
	$text->text($headingText);

	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );

	$text->translate(letterWidthCenter , $ypos);
	$text->text("Detour End:");


	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->translate(rightColumnX, $ypos);
	$headingText = $end_date . "  " . $end_time;
	$text->text($headingText);

	#
	# Line 
	#
	$ypos -= rowHeight;
	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );

	$text->translate(leftMargin , $ypos);
	$text->text("Route:");

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->translate(leftColumnX, $ypos);
	$text->text($route);

	#
	# Line 
	#
	$ypos -= rowHeight;
	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );

	$text->translate(leftMargin , $ypos);
	$text->text("Direction:");

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->translate(leftColumnX, $ypos);
	$text->text($direction);

	#
	# Line 
	#
	$ypos -= rowHeight;
	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );

	$text->translate(leftMargin , $ypos);
	$text->text("Description:");

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );


	#
	# The description may be wider than a page so we have to
	# print multiple lines.  There is probably a very good way of
	# doing this, but I don't know what it is so we will probably 
	# reinvent the wheel, a wheel that is slightly out of round
	#
	
	# width of 'printable' area
	my $printAreaWidth = rightEdge - leftColumnX;

	#
	# turn any newlines in the data to be space around them
	# so when we break them apart we get them as a separate word
	$description =~ s/\r*(\n)/ $1 /g;

	# Break the string into an array of words
	(my @words) = split(/ +/,$description);	

	my $printLine = "";
	my $line = 1;
	foreach my $word (@words) {
		if( $word =~ m/\n/ ) {
			# newline in the data
			#	print "New Line\n";
			#	print "Word: $word\n";
			#	print "Print line: $printLine\n";
			$text->translate(leftColumnX, $ypos);
			$text->text($printLine);
			$ypos -= rowHeight;
			$printLine = "";
			next;
		}
		if( ($text->advancewidth($printLine) + $text->advancewidth($word)) > $printAreaWidth ) {
			# time to wrap
			#	print "Auto Wrap\n";
			#	print "Word: $word\n";
			#	print "Print line: $printLine\n";
			$text->translate(leftColumnX, $ypos);
			$text->text($printLine);
			$ypos -= rowHeight;
			$printLine = "";
		}
		$printLine .= $word . " "; 
	}

	if( $printLine ne "" ) {
		$text->translate(leftColumnX, $ypos);
		$text->text($printLine);
	}

	#
	# Line 
	#
	$ypos -= rowHeight;
	$ypos -= rowHeight;

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->translate(leftColumnX , $ypos);
	if( $detour_type == 0 ) {
		$text->text("This is an ");
	} else {
		$text->text("This is a ");
	}
	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );
	$text->text($detourTypeText);

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->text(" detour due to ");


	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );
	$text->text($reason);


	#
	# Last Line
	#
	$ypos = bottomMargin;

	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );
	$text->translate(leftMargin , $ypos);
	$text->text("Supervisor:");

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->translate(leftColumnX, $ypos);
	$text->text($supervisor);

	$text->font( $font{'Helvetica'}{'Bold'}, 12/pt );
	$text->translate(letterWidthCenter , $ypos);
	$text->text("Dispatcher:");

	$text->font( $font{'Helvetica'}{'Roman'}, 12/pt );
	$text->translate(rightColumnX,  $ypos);
	$text->text($dispatcher);


	$pdf->save;
	$pdf->end;

	return $filename;

}

#
# Recreate PDF that database says was created but filesystem says otherise
#
sub recreatePDF {

	my $dbh = shift;
	my $detour_id = shift;
	my $notification_type = shift;

	my $pathname;

	print "Recreating $notification_type PDF for detour $detour_id\n";
	my $count=0;
	my $sth = $dbh->prepare("SELECT * FROM detours where id = ?");
	$sth->execute($detour_id);
	my $ref = $sth->fetchrow_hashref(); 

	my $change_cancel_date = "";
	if($notification_type eq 'DETOFF') {
		$change_cancel_date = $ref->{'cancel_date'};
	} elsif($notification_type eq 'DETCHG' ) {
		$change_cancel_date = $ref->{'change_at'};
	}

	$pathname = createDetourPDF(
			$ref->{'id'},
			$ref->{'start_date'},
			$ref->{'start_time'},
		 	$ref->{'end_date'},
		    	$ref->{'end_time'},
		    	$ref->{'route'},
		    	$ref->{'direction'},
		    	$ref->{'description'},
		    	$ref->{'reason'},
		    	$ref->{'supervisor'},
		    	$ref->{'dispatcher'},
		    	$ref->{'detour_type'},
			$notification_type,
			$change_cancel_date
		);

	print "          Re-Created $pathname\n";
}

sub buildLocationsHash {

	my $dbh = shift;

	my %locs;


    my $sth = $dbh->prepare("SELECT * FROM locations");
    $sth->execute();
    while (my $ref = $sth->fetchrow_hashref()) {
		$locs{$ref->{'short_name'}}->{'ID'} = $ref->{'id'};
		$locs{$ref->{'short_name'}}->{'FAX'} = $ref->{'fax_number'};
		$locs{$ref->{'short_name'}}->{'CALL'} = $ref->{'phone_number'};
		$locs{$ref->{'short_name'}}->{'EMAIL'} = $ref->{'email_address'};
		$locs{$ref->{'short_name'}}->{'PRINT'} = $ref->{'printer'};

	}

	return %locs;
}

sub sendNotifications {

	my $dbh = shift;


	print "Processing undelivered notifications\n";
	my $sth = $dbh->prepare("SELECT * FROM notifications where delivered is null or delivered = 0");
	$sth->execute();
	my $count =0;
	print "  ", $sth->rows(), " notifications to process\n";

	while (my $ref = $sth->fetchrow_hashref()) {
		printf "  Notification %d, type %s, detour %d, Location %s, method %s\n",
			$ref->{'id'},
			$ref->{'notification_type'},
			$ref->{'detour_id'},
			$ref->{'location_id'},
			$ref->{'notification_method'};
		#
		# look up the notifcation options
		my $notify = getLocationNotificationMethod( $dbh, $ref->{'location_id'}, $ref->{'notification_method'} );
		print "$ref->{'notification_method'} notification for $ref->{'location_id'} is $notify\n";
		my $notifyDocumentPath = getDetourPDF( $dbh, $ref->{'detour_id'}, $ref->{'notification_type'} );
		print "Document path = $notifyDocumentPath\n";

		if($ref->{'notification_method'} eq 'FAX') {
			print "  !! Fax notification not implemented\n";
			next;
		#	if ( $notify == undef ) {
		#		print "  !! No FAX number defined for location $ref->{'location_id'}, cannot notify via FAX!!\n";
		#	} else {
		#	}
		} elsif($ref->{'notification_method'} eq 'EMAIL') {
		#	if ( $notify == undef ) {
		#		print "  !! No e-mail address defined for location $ref->{'location_id'}, cannot notify via E-Mail!!\n";
		#	} else {
				my $ret = sendEmailNotification(  $notify, $notifyDocumentPath, $ref->{'notification_type'});
				if( $ret == undef ) {
					print "  !! Error sending  $ref->{'notification_type'} notification to $ref->{'location_id'}\n";
				} else {
                                       $ret = setNotificationDelivered($dbh, $ref->{'id'});
                                        if( $ret != 1) {
                                                print "  !! Error updating $ref->{'id'} to show delivery.\n";
                                        }
                                }
		#	}
		} elsif($ref->{'notification_method'} eq 'PRINTER') {
			print "Notify = $notify\n";
		#	if ( $notify == undef ) {
		#		print "  !! No printer defined for location $ref->{'location_id'}, cannot notify via PRINTER!!\n";
		#	} else {
				my $postscript = isLocationPrinterPostscript($dbh, $ref->{'location_id'}); 
				my $ret = sendPrintNotification(  $notify, $notifyDocumentPath, $postscript);
				if( $ret == undef ) {
					print "  !! Error sending  $ref->{'notification_type'} notification to $ref->{'location_id'}\n";
				} else {
                                       $ret = setNotificationDelivered($dbh, $ref->{'id'});
                                        if( $ret != 1) {
                                                print "  !! Error updating $ref->{'id'} to show delivery.\n";
                                        }
                                }

		#	}
		} elsif($ref->{'notification_method'} eq 'PHONE') {
			print "Notify = $notify\n";
			if ( $notify eq undef ) {
				print "  !! No telephone number defined for location $ref->{'location_id'}, cannot notify via CALL!!\n";
			} else {
				my $ret = sendCallNotification( $ref->{'id'}, $ref->{'notification_type'}, $notify);
				if( $ret == undef ) {
					print "  !! Error sending $ref->{'notification_type'} notification to $ref->{'location_id'}\n";
				} else {
					$ret = setNotificationDelivered($dbh, $ref->{'id'});
					if( $ret != 1) {
						print "  !! Error updating $ref->{'id'} to show delivery.\n";
					}
				}
				# print "  !! Call notification not implemented\n";
			}
		} else {
			print "  !!!! Unknown notification method ", $ref->{'notification_method'}, " !!!!\n";
		}
		updateNotificationLastAttempt($dbh, $ref->{'id'});

	}
}

#
# lookup a location print and return true if printer is postscript
# return false if not postscript
#
# arguments
#   database handle
#   location_id

sub isLocationPrinterPostscript {

	my $dbh = shift;
	my $location = shift;

	my $sth = $dbh->prepare("SELECT * FROM locations where id = ?");
	$sth->execute($location);

	if ( $sth->rows() == 0 ) {
		print "Could not lookup location data for id $location\n";
		return undef;
	}
	if ( $sth->rows() > 1 ) {
		print "Multiple location data found for id $location\n";
		return undef;
	}
	my $ref = $sth->fetchrow_hashref();
	if( $ref->{'printer_is_postscript'} ) {
		return 1;
	} else {
		return 0;
	}
}

#
# lookup a location notification option
# returns the string of the appropriate number or undef if not defined in the datbase
#
# arguments
#   database handle
#   location_id
#   notification_method

sub getLocationNotificationMethod {

	my $dbh = shift;
	my $location = shift;
	my $notification_method = shift;

#	print "$location - Notification = $notification_type\n";
	my $sth = $dbh->prepare("SELECT * FROM locations where id = ?");
    $sth->execute($location);

	if ( $sth->rows() == 0 ) {
		print "Could not lookup location notification data for id $location\n";
		return undef;
	}
	if ( $sth->rows() > 1 ) {
		print "Multiple location notification data found for id $location\n";
		return undef;
	}
    my $ref = $sth->fetchrow_hashref();
	#foreach my $k (keys %$ref ) {
	#	print "$k = $ref->{$k}\n";
	#}
	my $ret;
	if ( $notification_method eq 'FAX' ) {
		$ret = $ref->{'fax_number'}; 
	} elsif ( $notification_method eq 'PHONE' ) {
		$ret = $ref->{'phone_number'};
	} elsif ( $notification_method eq 'EMAIL' ) {
		$ret = $ref->{'email_address'};
	} elsif ( $notification_method eq 'PRINTER' ) {
		$ret = $ref->{'printer'} ;
	} else {
		$ret = undef;
	}
#	print "value = $ret\n";
	return $ret;
}
#
# lookup a detour PDF document path
#   Returns the pathname to the PDF file
#
# arguments
#   database handle
#   detour_id
#   notification_type

sub getDetourPDF {

	my $dbh = shift;
	my $detour_id = shift;
	my $notification_type = shift;

	print "  == Retrieving PDF path for detour ", $detour_id, ". Notifiction Type: ", $notification_type, "\n";

	my $pathname = defaultPDFPath;
        $pathname = $settings{'pdf_path'} if exists $settings{'pdf_path'};
        $pathname .= '/' if $pathname =~ m~[^/]$~;
 
	my $sth = $dbh->prepare("SELECT * FROM detours where id = ?");
 	$sth->execute($detour_id);

	if ( $sth->rows() == 0 ) {
		print "Could not lookup detour $detour_id\n";
		return undef;
	}
	if ( $sth->rows() > 1 ) {
		print "Multiple detours found for detour $detour_id\n";
		return undef;
	}
 	my $ref = $sth->fetchrow_hashref();
	#foreach my $k (keys %$ref ) {
	#	print "$k = $ref->{$k}\n";
	#}
	my $ret;
	if ( $notification_type eq 'DETON' ) {
		$ret = $pathname . $ref->{'create_pdf_path'}; 
	} elsif ( $notification_type eq 'DETOFF' ) {
		$ret = $pathname . $ref->{'cancel_pdf_path'}; 
	} elsif ( $notification_type eq 'DETCHG' ) {
		$ret = $pathname . $ref->{'change_pdf_path'}; 
	} else {
		$ret = undef;
	}
#	print "value = $ret\n";
	if( ! -e $ret ) {
		print "NOTICE: Could not locate physical file $ret\n";
		&recreatePDF($dbh, $detour_id, $notification_type);
	}
	return $ret;
}


#
# Set notification to be delivered
#
# arguments
#    database handler
#    notification_id

sub setNotificationDelivered {
	my $dbh = shift;
	my $notification_id = shift;

	my $sth = $dbh->prepare("update notifications set delivered = 1 where id = ?");
	my $ret = $sth->execute($notification_id);

	return $ret;
}

#
# update last attempt timestamp
#
# arguments
#    database handler
#    notification_id

sub updateNotificationLastAttempt {
	my $dbh = shift;
	my $notification_id = shift;

	my $sth = $dbh->prepare("update notifications set last_attempt = now() where id = ?");
	my $ret = $sth->execute($notification_id);

	return $ret;
}

#
# Write an asterisk call file and place it where asterisk can pick it up
#
# arguments:
#   notification_id number
#   notification type (on or off)
#   telephone number
#
# return undef on failure
# return 1 on sucess
sub sendCallNotification {

	my $notification_id = shift;
	my $notification_type = shift;
	my $telephoneNumber = shift;

	print "    === Calling $telephoneNumber for detour $notification_type\n";

        my $asteriskCallPath = defaultAsteriskCallTemp;
        $asteriskCallPath = $settings{'asterisk_call_path'} if exists $settings{'asterisk_call_path'};
        $asteriskCallPath .= '/' if $asteriskCallPath =~ m~[^/]$~;

        my $asteriskTempPath = defaultAsteriskCallTemp;
        $asteriskTempPath = $settings{'asterisk_temp_path'} if exists $settings{'asterisk_temp_path'};
        $asteriskTempPath .= '/' if $asteriskTempPath =~ m~[^/]$~;

	my $tempCallPath = $asteriskTempPath . "call.XXXXXXXXXX";
	$tempCallPath = `mktemp $tempCallPath`;
	chomp($tempCallPath);

        my $temp = $tempCallPath;
        $temp =~ s/$asteriskTempPath/$asteriskCallPath/;
	$asteriskCallPath = $temp;

    print "Temporary file = $tempCallPath.... to be saved to $asteriskCallPath\n";
	open(OUT, ">$tempCallPath") || return undef;
	# printf OUT q(Channel: Zap/g0/%s
	printf OUT q(Channel: %s
callerid: Detour Notification <3278>
MaxRetries: 5
RetryTime: 300
WaitTime: 20
Context: mcts-call-notification
Extension: %s
Priority: 1
Set: notificationid=%s
),
	$telephoneNumber,
	$notification_type,
	$notification_id;
	close(OUT);

	print "mv $tempCallPath, $asteriskCallPath\n";
	system("mv $tempCallPath $asteriskCallPath");

	return 1;

}

#
# Send detour notification to printer
#
# arguments:
#   printer
#   document pathnam
#   
#   
#
# return undef on failure
# return 1 on sucess
sub sendPrintNotification {

	my $printer = shift;
	my $documentPath = shift;
	my $postscript = shift;

	my $device;
	if( $postscript == 1) {
		$device= "";
	} else {
		$device = "-sDEVICE=ljet4";
	}
	print "    === Printing notification $documentPath on $printer\n";

 	print "pdf2ps $device -sOutputFile=- -q $documentPath  | lp -d $printer";
	system("pdf2ps $device -sOutputFile=- -q $documentPath  | lp -d $printer");
	if ($? == -1) {
		print "   !!! failed to execute: $!\n";
		return 0;
	} elsif ($? & 127) {
		printf "   !!! child died with signal %d, %s coredump\n", ($? & 127),  ($? & 128) ? 'with' :  'without';
		return 0;
	} else {
		printf "   child exited with value %d\n", $? >> 8;
		return 1;
	}


}

#
# Send detour notification via e-mail
#
# arguments:
#   address
#   document pathname
#   notification type (on/off/update)
#   
#
# return undef on failure
# return 1 on sucess
sub sendEmailNotification {

	my $address = shift;
	my $documentPath = shift;
	my $notification_type = shift;

	my $notification_text = "";

	if( $notification_type eq 'DETON') {
		$notification_text = "new detour";
	} elsif( $notification_type eq 'DETOFF' ) {
		$notification_text = "canceled detour";
	} elsif( $notification_type eq 'DETCHG' ) {
		$notification_text = "changed detour";
	} else {
		print "Invalid notification type: $notification_type\n";
		return undef;
	}

	print "    === e-mailing $notification_type notification $documentPath to $address\n";

	if (open(MAIL, "| EMAIL='Detour Notification <do_not_reply\@mcts.org>' mutt -s'Detour notification' -a '$documentPath' $address")) {
		printf MAIL "The attached document describes a %s.", $notification_text;
		close(MAIL); 
		
	} else {
		print "   !!! Error opening e-mail client\n";
		return undef;
	}
	return 1;
}
