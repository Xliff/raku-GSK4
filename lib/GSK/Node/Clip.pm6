use v6.c;

use Method::Also;

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

  method get_child (
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  )
    is also<
      get-child
      child
    >
  {
    returnProperNode(
      gsk_clip_node_get_child($!gsk-cn),
      :$raw,
      :$proper
    );
  }

  method get_clip ( :$raw = False )
    is also<
      get-clip
      clip
    >
  {
    propReturnObject(
      gsk_clip_node_get_clip($!gsk-cn),
      $raw,
      |Graphene::Rect.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_clip_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::Clip;
  %render-node-types<Clip> = {
    object    => O,
    node-type => GSK_CLIP_NODE,
    pair      => O.getTypePair
  }
}
