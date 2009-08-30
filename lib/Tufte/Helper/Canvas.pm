module Tufte::Helper::Canvas;

multi sub bounds_for(@canvas_size, @position, @size) {
    return unless @position && @size;
    return {
        x       => @canvas_size[0] * @position[0] / 100;
        y       => @canvas_size[1] * @position[1] / 100;
        width   => @canvas_size[0] * @size[0]     / 100;
        height  => @canvas_size[1] * @size[1]     / 100;
    }
}

# vim: ft=perl6 sw=4 ts=4 expandtab
