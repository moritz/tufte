use v6;
BEGIN { @*INC.push: 'lib' };

use Tufte::Graph;
use Tufte::Renderer::Pie;

my $g = Tufte::Graph.new();

$g.title    = 'Favourite Snacks';
$g.renderer = Tufte::Renderer::Pie.new;

$g.add: :pie, '', {
    Apple   => 20,
    Banana  => 100,
    Orange  => 70,
    Taco    => 30,
};

# vim: ft=perl6 sw=4 ts=4 expandtab
