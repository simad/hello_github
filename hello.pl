#!/usr/local/bin/perl
use DateTime;

sub commit_at_date{
  `touch .a`;
  `git commit -amf 'Drawing stuff' --date="$_[0]"`;
  `git push`;
  `rm -f .a`;
}

my $dt = DateTime->new(
    year       => 2015,
    month      => 10,
    day        => 04
);

#Drawing the H
for my $i (0..6) {
  my $temp = $dt->add( days => 1 )->strftime('%d.%m.%Y');
  print "Committing on $temp\n";
  commit_at_date($temp);
}

for my $i (0..6) {
  my $temp = $dt->add( days => 1 );
  print "$temp\n";
}
$dt = $dt->strftime('%d.%m.%Y');
# $datestring = strftime "%d.%m.%Y", localtime;
print "GMT date and time $dt\n";
