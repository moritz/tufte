use v6;
use Test;

use Tufte;

{
    my $begin = "Any layer";

    sub render ($points) {
        my role StubDraw {
            method draw ($svg, $coords, *%options) {
                $coords;
            }
        }

        my Tufte::Layer::Base $layer .= new(:title('My base layer'),
                                            :points($points));
        $layer = $layer but StubDraw;

        my @coords;

        lives_ok {
            my @size = 400, 400;
            @coords =
              $layer.render(Tufte::Renderer::Base.new.render(:layers[$layer],
                                                             :$size),
                            :$size, :min_value(100), :max_value(300));
        }, "Rendering a layer.";

        @coords;
    }

    is render([100, nil, 300]), [[0, 400], [400, 0]],
      "$begin should accept but ignore nil data.";
    is render({ 0 => 100, 2 => 300]), [[0, 400], [400, 0]],
      "$begin should accept hash data as sequentially-keyed data.";
}

done_testing;

# Local Variables:
#   mode: cperl
# End:
# vim: ft=perl6
