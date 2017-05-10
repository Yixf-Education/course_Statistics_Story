#!/usr/bin/perl

use warnings;
use strict;
use utf8;

my $num_cards   = $ARGV[0] ? $ARGV[0] : 52;
my $num_repeats = $ARGV[1] ? $ARGV[1] : 10000000;

my @color = ( 0, 1 );

my %total;
for ( my $i = 1 ; $i <= $num_repeats ; $i++ ) {
    my @cards = get_cards();
    my %stats = stats_cards(@cards);
    foreach my $count ( sort { $a <=> $b } keys %stats ) {

        # print "$i\t$count\t$stats{$count}\n";
        $total{$count} += $stats{$count};
    }
}

foreach my $count ( sort { $a <=> $b } keys %total ) {
    my $percent = sprintf( "%d", $total{$count} / $num_repeats * 100 );
    print "$count\t$total{$count}\t$percent\n";
}

sub get_cards {
    my @cards;
    for ( my $i = 0 ; $i < $num_cards ; $i++ ) {
        push @cards, get_card();
    }
    return @cards;
}

sub get_card {
    return $color[ rand @color ];
}

sub stats_cards {
    my @cards = @_;
    my ( $last_card, $cumsum, %stats );
    for (@cards) {
        if ( !defined $last_card ) {
            $last_card = $_;
            $cumsum    = 1;
        }
        elsif ( $_ == $last_card ) {
            $cumsum++;
        }
        else {
            $last_card = $_;
            $stats{$cumsum}++;
            $cumsum = 1;
        }
    }
    $stats{$cumsum}++;
    return %stats;
}
