#!/usr/bin/perl -w
use DateTime;
use Date::Parse;
use DateTime;

# (1) quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if ($num_args != 2) {
    print "\nUsage: hello.pl start_date (format dd.mm.YYYY) string\n";
    exit;
}

# (2) we got two command line args, so assume they are the
# first name and last name
my $epoch = str2time($ARGV[0]);
my $string=$ARGV[1];


my $dt = DateTime->from_epoch(epoch => $epoch);

my %letters = ( E => \&E,
                H => \&H,
                L => \&L,
                O => \&O,
                );

my $count = 0;
foreach $char (split //, $string) {
    #todo check hash key
  $letters{$char}->($dt->clone()->add(weeks => $count));
  $count = $count + 6;
}

`touch .a`;

sub commit_at_date{
  my $date = $_[0]->strftime('%d.%m.%Y');
  `echo "a" >> .a`;
  `git add .a`;
  `git commit -m 'Drawing stuff' --date="$date"`;
  `git push origin master`;
}

sub draw_vertical_line {
  my $temp = $_[0]->clone();
  for(0..6) {
    print "$temp\n";
    # commit_at_date($temp);
    $temp = $temp->add( days => 1 );

  }
}
sub draw_horizontal_line {
  my $temp = $_[0]->clone();
  my $length = $_[1];
  for(1..$length) {
    $temp = $temp -> add( weeks => 1 );
    print "$temp\n";
    # commit_at_date($temp);
  }
}

sub H{
  draw_vertical_line($_[0]->clone());
  draw_horizontal_line($_[0]->clone()->add(days => 3), 3);
  draw_vertical_line($_[0]->clone()->add(weeks => 4));
}

sub E{
  draw_vertical_line($_[0]->clone());
  draw_horizontal_line($_[0]->clone(), 4);
  draw_horizontal_line($_[0]->clone()->add(days => 3), 4);
  draw_horizontal_line($_[0]->clone()->add(days => 6), 4);
}

sub L{
  draw_vertical_line($_[0]->clone());
  draw_horizontal_line($_[0]->clone()->add(days => 6), 4);
}

sub O{
  draw_vertical_line($_[0]->clone());
  draw_horizontal_line($_[0]->clone(), 3);
  draw_horizontal_line($_[0]->clone()->add(days => 6), 3);
  draw_vertical_line($_[0]->clone()->add(weeks=>4));
}
