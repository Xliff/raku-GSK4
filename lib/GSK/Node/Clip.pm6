use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Clip is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskClipNode $!gsk-cn is implementor;

  method new (GskRenderNode() $child, graphene_rect_t() $clip) {
    gsk_clip_node_new($child, $clip);
  }

  method get_child ( :$raw = False ) {
    propReturnObject(
      gsk_clip_node_get_child($node),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_clip ( :$raw = False ) {
    propReturnObject(
      gsk_clip_node_get_clip($node),
      $raw,
      |Graphene::Rect.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_clip_node_get_type, $n, $t );
  }

}
