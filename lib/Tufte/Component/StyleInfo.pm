use Tufte::Component::Base;

class Tufte::Component::StyleInfo is Tufte::Component::Base {
    has $!visible = False;

    multi method process($svg, %options) {
        $svg.defs.push: :style[
            :type<text/css>,
            :cdata("\n%options<selector> \{\n    %options<style>\n\}\n")
        ];
    }
}

# vim: sw=4 ts=4 ft=perl6 expandtab
