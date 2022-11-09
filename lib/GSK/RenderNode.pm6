use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our %render-node-types is export;

class GSK::RenderNode:ver<4> {
  has GskRenderNode $!gsk-rn is implementor;

  submethod BUILD (:$gsk-render-node ) {
    self.setGskRenderNode($gsk-render-node) if $gsk-render-node;
  }

  method setRenderNode ($render-node is copy) {
    $render-node = cast(GskRenderNode, $render-node)
      unless $render-node ~~ GskRenderNode;

    $!gsk-rn = $render-node;
  }

  method GSK::Raw::Definitions::GskRenderNode
  { $!gsk-rn }

  method new (GskRenderNode $gsk-render-node, :$ref = True) {
    return Nil unless $gsk-render-node;

    $o = self.bless( :$gsk-render-node );
    $o.ref if $ref;
    $o;
  }

  # cw: GskRenderNode is a Class as far as the GLib
  #     typing system is concerned. That means it IS an OBJECT, just not
  #     a *GObject*.
  #
  #     This is the base class. This means that ancestry code should handle
  #     it just like we do in GLib::Object (we're not handling this like we do
  #     GLib::ROLES::Object -- let's not repeat the same mistake of the past)

  method deserialize (
    GBytes() $bytes,
             &error_func,
    gpointer $user_data   = gpointer
  ) {
    gsk_render_node_deserialize($bytes, &error_func, $user_data);
  }

  method draw (cairo_t() $cr) {
    gsk_render_node_draw($node, $cr);
  }

  method get_bounds (graphene_rect_t() $bounds) is also<get-bounds> {
    gsk_render_node_get_bounds($node, $bounds);
  }

  method get_node_type is also<get-node-type> {
    gsk_render_node_get_node_type($node);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_render_node_get_type, $n, $t );
  }

  method ref {
    gsk_render_node_ref($node);
    self;
  }

  method serialize {
    gsk_render_node_serialize($node);
  }

  method unref {
    gsk_render_node_unref($node);
  }

  method write_to_file (
    Str()                   $filename,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<write-to-file>
  {
    clear_error;
    my $rv = so gsk_render_node_write_to_file($node, $filename, $error);
    set_error($error);
    $rv;
  }

  method serialization_error_quark
    is static

    is also<serialization-error-quark>
  {
    gsk_serialization_error_quark();
  }

}

INIT {
  %render-node-types<Render> = {
    object => GSK::RenderNode,
    type   => GSK::RenderNode.get_type
  }
}
