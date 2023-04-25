use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GSK::Raw::Types:ver<4>;
use GSK::Raw::Renderer:ver<4>;

use GDK::Surface:ver<4>;
use GDK::Texture:ver<4>;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

our subset GskRendererAncestry is export of Mu
  where GskRenderer | GObject;

class GSK::Renderer:ver<4> {
  also does GLib::Roles::Object;

  has GskRenderer $!gr is implementor;

  submethod BUILD ( :$gsk-renderer ) {
    self.setGskRenderer($gsk-renderer) if $gsk-renderer
  }

  method setGskRenderer (GskRendererAncestry $_) {
    my $to-parent;

    $!gr = do {
      when GskRenderer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskRenderer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GSK::Raw::Definitions::GskRenderer
    is also<GskRenderer>
  { $!gr }

  multi method new (GskRendererAncestry $gsk-renderer, :$ref = True) {
    return unless $gsk-renderer;

    my $o = self.bless( :$gsk-renderer );
    $o.ref if $ref;
    $o;
  }

  method new_for_surface (GdkSurface() $surface) is also<new-for-surface> {
    my $gsk-renderer = gsk_renderer_new_for_surface($surface);

    $gsk-renderer ?? self.bless( :$gsk-renderer ) !! Nil;
  }

  # Type: boolean
  method realized is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('realized', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'realized does not allow writing'
      }
    );
  }

  # Type: GSKSurface
  method surface ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Surface.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('surface', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Surface.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'surface does not allow writing'
      }
    );
  }

  method get_surface ( :$raw = False ) is also<get-surface> {
    propReturnObject(
      gsk_renderer_get_surface($!gr),
      $raw,
      |GDK::Surface.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_renderer_get_type, $n, $t );
  }

  method is_realized is also<is-realized> {
    so gsk_renderer_is_realized($!gr);
  }

  method realize (
    GdkSurface()            $surface,
    CArray[Pointer[GError]] $error    = gerror
  ) {
    clear_error
    my $rv = gsk_renderer_realize($!gr, $surface, $error);
    set_error($error);
    $rv;
  }

  method render (
    GskRenderNode()  $root,
    cairo_region_t() $region = cairo_region_t
  ) {
    gsk_renderer_render($!gr, $root, $region);
  }

  method render_texture (
    GskRenderNode()    $root,
    graphene_rect_t()  $viewport,
                      :$raw       = False
  )
    is also<render-texture>
  {
    propReturnObject(
      gsk_renderer_render_texture($!gr, $root, $viewport),
      $raw,
      |GDK::Texture.getTypePair
    );
  }

  method unrealize {
    gsk_renderer_unrealize($!gr);
  }

}
