use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskCairoNodeAncestry is export of Mu
  where GskCairoNode | GskRenderNode;

class GSK::Node::Cairo:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskCairoNode $!gsk-cn is implementor;

  submethod BUILD ( :$gsk-cairo-node ) {
    self.setGskCairoNode($gsk-cairo-node) if $gsk-cairo-node
  }

  method setGskCairoNode (GskCairoNodeAncestry $_) {
    my $to-parent;

    $!gsk-cn = do {
      when GskCairoNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskCairoNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskCairoNode
    is also<GskCairoNode>
  { $!gsk-cn }

  multi method new (GskCairoNodeAncestry $gsk-cairo-node, :$ref = True) {
    return unless $gsk-cairo-node;

    my $o = self.bless( :$gsk-cairo-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (graphene_rect_t() $bounds) {
    my $gsk-cairo-node = gsk_cairo_node_new($bounds);

    $gsk-cairo-node ?? self.bless( :$gsk-cairo-node ) !! Nil;
  }

  method get_draw_context ( :$raw = False )
    is also<
      get-draw-context
      draw_context
      draw-context
    >
  {
    propReturnObject(
      gsk_cairo_node_get_draw_context($!gsk-cn),
      $raw,
      cairo_t,
      Cairo::Context
    );
  }

  method get_surface ( :$raw = False )
    is also<
      get-surface
      surface
    >
  {
    propReturnObject(
      gsk_cairo_node_get_surface($!gsk-cn),
      $raw,
      cairo_surface_t,
      Cairo::Surface
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_cairo_node_get_type, $n, $t );
  }

}
