role Tufte::Helper::Canvas;

has @.components is rw;

multi method reset_settings() {
    %!options = {}
}

multi method component($id, @components=@!components) {
    @components.grep: { .id ~~ $id };
}

multi method index($id, @components=@!components) {
    for @components.kv -> $idx, $component {
        return $idx if $component.id ~~ $id;
    }
}

multi method remove($id, @components is rw =@!components) {
    @components.delete($.index($id, @components));
}

# Converts percentage values into actual pixel values based on the known render size.
#
# Returns a hash consisting of x, y, width, and height elements.
multi method bounds_for(@canvas_size, @position, @size) {
    return unless @position && @size;
    return {
        x       => @canvas_size[0] * @position[0] / 100;
        y       => @canvas_size[1] * @position[1] / 100;
        width   => @canvas_size[0] * @size[0]     / 100;
        height  => @canvas_size[1] * @size[1]     / 100;
    }
}

=begin pod

=head1 NAME

Tufte::Helper::Canvas - Provides common methods for canvas objects.

=head1 DESCRIPTION

Provides common methods for canvas objects. Primarily used for providing spacial-type calculations where necessary.

=end pod

# vim: ft=perl6 sw=4 ts=4 expandtab
