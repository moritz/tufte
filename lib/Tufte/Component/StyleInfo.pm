use Tufte::Component::Base;

class Tufte::Component::StyleInfo is Tufte::Component::Base {
    has $!visible = False;

    multi method process(%options) {
        $!svg.defs = :style[
            :type<text/css>,
            :cdata("\n%options<selector> \{\n    %options<style>\n\}\n")
        ];
    }
}

# vim: sw=4 ts=4 ft=perl6 expandtab
