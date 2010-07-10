class Tufte::Renderer::Base;

has %.options;
has @.components is rw;
has $.svg;

submethod BUILD {
    self.define_layout;     # defined in inherting classes
    $!svg = SVG::State.new();
}

multi method render(*%options) {
    %options<graph_id>      //= 'scruffy_graph';
    %options<complexity>    //= $.global_complexity || 'normal';

    # Allow subclasses to muck with components prior to renders.
    my $r = self.clone;
    # XXX is this ported correctly from this piece of ruby?
    # rendertime_renderer.instance_eval { 
    #       before_render if respond_to?(:before_render) }
    $r.?before_render();
    $!svg.width  = %options<size>[0];
    $!svg.height = %options<size>[*-1];

    # TODO: rest of the method


}

multi method global_complexity() {
    # XXX
    Any;
}

# vim: ft=perl6 sw=4 ts=4 expandtab
