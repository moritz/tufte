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
    @components.splice($.index($id, @components), 1);
}

multi method bounds_for(@canvas_size, @position, @size) {
    return unless @position && @size;
    return {
        x       => @canvas_size[0] * @position[0] / 100;
        y       => @canvas_size[1] * @position[1] / 100;
        width   => @canvas_size[0] * @size[0]     / 100;
        height  => @canvas_size[1] * @size[1]     / 100;
    }
}

# vim: ft=perl6 sw=4 ts=4 expandtab
