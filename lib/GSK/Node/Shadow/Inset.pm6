use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskInsetShadowNodeAncestry is export of Mu
  where GskInsetShadowNode | GskRenderNode;

class GSK::Node::Shadow::Inset:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskInsetShadowNode $!gsk-isn is implementor;

  submethod BUILD ( :$gsk-inset-shadow-node ) {
    self.setGskInsetShadowNode($gsk-inset-shadow-node)
      if $gsk-inset-shadow-node
  }

  method setGskInsetShadowNode (GskInsetShadowNodeAncestry $_) {
    my $to-parent;

    $!gsk-isn = do {
      when GskInsetShadowNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskInsetShadowNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskInsetShadowNode
    is also<GskInsetShadowNode>
  { $!gsk-isn }

  multi method new (
    GskInsetShadowNodeAncestry  $gsk-inset-shadow-node,
                               :$ref                    = True
  ) {
    return unless $gsk-inset-shadow-node;

    my $o = self.bless( :$gsk-inset-shadow-node );
    $o.ref if $ref;
    $o;
  }

  method get_blur_radius
    is also<
      get-blur-radius
      blur_radius
      blur-radius
    >
  {
    gsk_inset_shadow_node_get_blur_radius($!gsk-isn);
  }

  method get_color ( :$raw = False )
    is also<
      get-color
      color
    >
  {
    propReturnObject(
      gsk_inset_shadow_node_get_color($!gsk-isn),
      $raw,
      |GDK::RGBA.getTypePair
    );
  }

  method get_dx
    is also<
      get-dx
      dx
    >
  {
    gsk_inset_shadow_node_get_dx($!gsk-isn);
  }

  method get_dy
    is also<
      get-dy
      dy
    >
  {
    gsk_inset_shadow_node_get_dy($!gsk-isn);
  }

  method get_outline ( :$raw = False )
    is also<
      get-outline
      outline
    >
  {
    propReturnObject(
      gsk_inset_shadow_node_get_outline($!gsk-isn),
      $raw,
      |GSK::RoundedRect.getTypePair
    );
  }

  method get_spread
    is also<
      get-spread
      spread
    >
  {
    gsk_inset_shadow_node_get_spread($!gsk-isn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_inset_shadow_node_get_type, $n, $t )
  }

}

INIT {
  my \O = GSK::Node::Shadow::Inset;
  %render-node-types<Shadow::Inset> = {
    object    => O,
    node-type => GSK_INSET_SHADOW_NODE,
    type      => O.get_type
  }
}
