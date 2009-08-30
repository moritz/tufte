use SVG;

class SVG::State;

has @.drawings;
has @.defs;
has $.width is rw;
has $.height is rw;

multi method as-svg() {
    my @dimensions;
    @dimensions.push: 'width'  => $width  if defined $width;
    @dimensions.push: 'height' => $height if defined $height;
    return 'svg' => [
        'xmlns'         => 'http://www.w3.org/2000/svg',
        'xmlns:svg'     => 'http://www.w3.org/2000/svg',
        'xmlns:xlink'   => 'http://www.w3.org/1999/xlink',
        @dimensions,
        :defs => [
            @.defs,
        ],
        @.drawings,
    ];
}

multi method Str() {
    SVG.serialize(self.as-svg());
}


# vim: ft=perl6 sw=4 ts=4 expandtab
