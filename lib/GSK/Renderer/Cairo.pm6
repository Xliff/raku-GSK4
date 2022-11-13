use v6.c;

use Method::Also;

use NativeCall;

use GSK::Raw::Types:ver<4>;

use GSK::Renderer;

use GLib::Roles::Implementor;

our subset GskCairoRendererAncestry is export of Mu
  where GskCairoRenderer | GskRendererAncestry;

class GSK::Renderer::Cairo is GSK::Renderer {
  has GskCairoRenderer $!gsk-cr is implementor;

  submethod BUILD ( :$gsk-cairo-renderer ) {
    self.setGskCairoRenderer($gsk-cairo-renderer)
      if $gsk-cairo-renderer
  }

  method setGskCairoRenderer (GskCairoRendererAncestry $_) {
    my $to-parent;

    $!gsk-cr = do {
      when GskCairoRenderer {
        $to-parent = cast(GskRenderer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskCairoRenderer, $_);
      }
    }
    self.setGskRenderer($to-parent);
  }

  method GSK::Raw::Definitions::GskCairoRenderer
    is also<GskCairoRenderer>
  { $!gsk-cr }

  multi method new (
    GskCairoRendererAncestry  $gsk-cairo-renderer,
                             :$ref                 = True
  ) {
    return unless $gsk-cairo-renderer;

    my $o = self.bless( :$gsk-cairo-renderer );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gsk-cairo-renderer = gsk_cairo_renderer_new();

    $gsk-cairo-renderer ?? self.bless( :$gsk-cairo-renderer ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_cairo_renderer_get_type, $n, $t );
  }

}

### /usr/src/gtk4-4.8.1+ds/gsk/gskcairorenderer.h

sub gsk_cairo_renderer_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_cairo_renderer_new
  returns GskRenderer
  is      native(gsk)
  is      export
{ * }
