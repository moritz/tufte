class Tufte::Renderer::Base;

has %.options;
has @!components;

submethod BUILD {
    self.define_layout;     # defined in inherting classes
}

# vim: ft=perl6 sw=4 ts=4 expandtab
