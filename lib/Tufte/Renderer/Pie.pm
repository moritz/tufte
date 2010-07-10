use Tufte::Renderer::Base;
use Tufte::Component::Background;
use Tufte::Component::Graph;
use Tufte::Component::Title;
use Tufte::Component::Legend;
class Tufte::Renderer::Pie is Tufte::Renderer::Base;

submethod BUILD {
    @.components =
        Tufte::Component::Background.new(
            position => [0, 0],
            size     => [100, 100],
        ),
        Tufte::Component::Graph.new(
            position => [-15, 12],
            size     => [90, 88],
        ),
        Tufte::Component::Title.new(
            position => [5, 2],
            size     => [90, 7],
        );
        Tufte::Component::Legend.new(
            position => [60, 15],
            size     => [40, 88],
            :vertical_legend,
        );
}


# vim: ft=perl6 sw=4 ts=4 expandtab
