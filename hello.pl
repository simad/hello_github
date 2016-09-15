#!/usr/local/bin/perl
use DateTime;

sub commit_at_date{
  `touch .a`;
  `git commit -am 'Drawing stuff' --date="$_[0]" >/dev/null`;
  `git push > /dev/null`;
  `rm .a`;
}

my $dt = DateTime->new(
    year       => 2015,
    month      => 10,
    day        => 04
);

#Drawing the H
for my $i (0..6) {
  my $temp = $dt->add( days => 1 );
  commit_at_date($temp);
}

for my $i (0..6) {
  my $temp = $dt->add( days => 1 );
  print "$temp\n";
}
$dt = $dt->strftime('%d.%m.%Y');
# $datestring = strftime "%d.%m.%Y", localtime;
print "GMT date and time $dt\n";
