use v6;
use Test;
use Tufte;

class BlankRenderer {
    method render (%options) {
        say "Rendering";
    }
}

{
    my $begin = "A new Tufte::Graph";
    my $graph = Tufte::Graph.new;

    is $graph.title, '',
      "$begin should have a blank title.";
    is $graph.theme.WHAT, Tufte::Themes::Keynote,
      "$begin should be set to the keynote theme.";
    is $graph.layers.elems, 0,
      "$begin should have zero layers.";
    is $graph.default-type.defined, False,
      "$begin should not have a default layer type.";
    is $graph.point-markers.elems, 0,
      "$begin should not have any point markers(x-axis values)";
    isa_ok $graph.value-formatter, Tufte::Formatter::Number,
      "$begin should format values as numbers by default.";
    isa_ok $graph.renderer, Tufte::Renderer::Standard,
      "$begin should use a StandardRenderer.";

    $graph.title = 'New Title';
    is $graph.title, 'New Title',
      "$begin should accept a new title.";

    $graph.theme = Tufte::Theme::Mephisto.new;
    is $graph.theme.WHAT, Tufte::Theme::Mephisto,
      "$begin should accept a new theme.";

    $graph.default-type = 'line';
    is $graph.default-type, 'line',
      "$begin should accept a new default type.";

    $graph.point-markers = <Jan Feb Mar>;
    is $graph.point-markers, <Jan Feb Mar>,
      "$begin should accept new point markers.";

    {
        my $renderer = BlankRenderer.new;
        $graph.renderer = $renderer;
        is $graph.renderer, $renderer,
          "$begin should accept a new renderer.";
    }

    dies_ok { $graph.render = 1 },
      "$begin should not accept renderers with missing .render menthods.";
}

{
    my $begin = "A Tufte::Graph's constructor";
    lives_ok { Tufte::Graph.new('line') },
      "$begin should accept just a default-type string.";
    lives_ok { Tufte::Graph.new(:title('My Title')) },
      "$begin should accept just an option.";
    lives_ok { Tufte::Graph.new(:title('My Title'),
                                :theme(Tufte::Theme::Keynote.new)) },
      "$begin should accept multiple options.";
    lives_ok { Tufte::Graph.new('line', :title('My Title')) },
      "$begin should accept both a default-type and options.";
    dies_ok { Tufte::Graph.new('line', 'Any additional arguments.') },
      "$begin should reject invalid arguments.";
    dies_ok { Tufte::Graph.new(:title('My Title'),
                               :some_key('Some Value')) },
      "$begin should reject unsupported options.";

    {
        my %options = 
          { title => 'My Title',
            theme => { background => 'black',
                       colors => [:red<red>, :yellow<yellow>] },
            layers => [Scruffy::Layers::Line.new(:points[100, 200, 300])],
            default-type => 'average',
            value-formatter => Tufte::Formatter::Currency.new,
            point-markers => ['One Hundred', 'Two Hundred', 'Three Hundred']};

        my $graph = Tufte::Graph.new(|%options);

        for <title theme layers default-type
          value-formatter points-markers> -> $attr {
            is $graph."$attr", %options{$attr},
              "$begin should save $attr option correctly.";
        }
    }
}

{
    my Tufte::Graph $graph .= new(:title('Test Graph'));
    $graph.push(Tufte::Layer::Average.new(:title<Average>,
                                          :points($graph.layers)));
    $graph.layers.first.relevant-data = Bool::False;
    $graph.push(Tufte::Layer::AllSmiles.new(:title<Smiles>,
                                            :points[100, 200, 300]));
    $graph.push(Tufte::Layer::Area.new(:title<Area>,
                                       :points[100, 200, 300]));
    $graph.push(Tufte::Layer::Bar.new(:title<Bar>,
                                      :points[100, 200, 300]));
    $graph.push(Tufte::Layer::Line.new(:title<Line>,
                                       :points[100, 200, 300]));
    isa_ok $graph.render(:width(800)), Str,
      "A fully-populated graph should render to SVG.";
}

{
    my Tufte::Graph $hash-graph .= new(:title<Graph>);
    $hash-graph.add(:line, 'Data', 0 => 1, 1 => 2, 3 => 4);

    my Tufte::Graph $array-graph .= new(:title<Graph>);
    $array-graph.add(:line, 'Data', 1, 2, Mu, 4);

    is $hash-graph.render(:to<hash.svg>),
      $array-graph.render(:to<array.svg>),
      "A graph with hash data should render identically to " ~
      "a graph with array data.";
}

done_testing;

# Local Variables:
#   mode: cperl
# End:
# vim: ft=perl6
