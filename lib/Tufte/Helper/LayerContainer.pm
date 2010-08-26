role Tufte::Helper::LayerContainer;

has @.layers is rw;

multi method add($type=$!default-type, Callable $block?, *@args) {
    if @args[0].isa(Tufte::Layer::Base) {
        @!layers.push: @args[0];
        return @!layers;
    }

    my $title = @args[0].isa(Str) ?? @args.shift !! '';

    # Layer handles PointContainer module, don't do it here
    my $points  = @args[0].isa(Array) ?? @args.shift !! [];
    my %options = @args.shift if @args[0].isa(Hash);

    fail 'You must specify a graph type (area, bar, line, etc) if you do not have a default type specified.' unless $type;

    my $class_name = "Tufte::Layer::{to_camelcase($type)}";
    my $layer_class = eval($class_name);
    %options = :$points, :$title, %options;
    @!layers.push: $layer_class.new(%options, :$block);
}

# Returns the highest value in any of this container's layers.
#
# If padding is set to 'padded', a 15% padding is added to the highest value.
multi method top_value($padding?) {
    my $topval = [max] @!layers».top_value;
    $padding == 'padded' ?? ($topval - (($topval - $.bottom_value) * 0.15)) !! $topval;
}

# Returns the lowest value in any of this container's layers.
#
# If padding is set to 'padded', a 15% padding is added below the lowest value.
# If the lowest value is greater than zero, then the padding will not cross the zero line,
# preventing negative values from being introduced into the graph purely due to padding.
multi method bottom_value($padding?) {
    my $botval = [min] @!layers».bottom_value;
    my $above_zero = ?($botval > 0);
    $botval = ($botval - (($.top_value - $botval) * 0.15)) if $padding == 'padded';

    # Don't introduce negative values solely due to padding.
    # A user-provided value must be negative before padding will extend into negative values.
    ($above_zero && $botval < 0) ?? 0 !! $botval;
}

sub to_camelcase($type) {
    $type.split('_').map({ $_.capitalize }).join('');
}

=begin pod

=head1 NAME

Tufte::Helper::LayerContainer - Adds some common functionality to any object which needs to act as a container for graph layers.

=head1 DESCRIPTION

Adds some common functionality to any object which needs to act as a container for graph layers.
The best example of this is the Tufte::Graph object itself, but this module is also used by Tufte::Layer::Stacked.

=head1 METHODS

=head2 add

Adds a Layer to the Graph/Container. Accepts either a list of arguments used to build a new layer,
or a Tufte::Layer::Base-derived object. When passing a list of arguments, all arguments are optional,

=begin code
$graph.add(type="line", [100, 200, 150]); # Create and add an untitled line graph

$graph.add(type="line", "John's Sales", [150, 100]); # Create and add a titled line graph

$graph.add(Tufte::Layer::Bar.new({...}); # Adds Bar layer to graph
=end code

=end pod

# vim: sw=4 ts=4 ft=perl6 expandtab
