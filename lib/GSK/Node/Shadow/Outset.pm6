use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskOutsetShadowNodeAncestry is export of Mu
  where GskOutsetShadowNode | GskRenderNode;

class GSK::Node::Shadow::Outset:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskOutsetShadowNode $!gsk-osn is implementor;

  submethod BUILD ( :$gsk-outset-shadow-node ) {
    self.setGskOutsetShadowNode($gsk-outset-shadow-node)
      if $gsk-outset-shadow-node
  }

  method setGskOutsetShadowNode (GskOutsetShadowNodeAncestry $_) {
    my $to-parent;

    $!gsk-osn = do {
      when GskOutsetShadowNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskOutsetShadowNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskOutsetShadowNode
    is also<GskOutsetShadowNode>
  { $!gsk-osn }

  multi method new (
    GskOutsetShadowNodeAncestry  $gsk-outset-shadow-node,
                                :$ref                     = True
  ) {
    return unless $gsk-outset-shadow-node;

    my $o = self.bless( :$gsk-outset-shadow-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GskRoundedRect() $outline,
    GdkRGBA()        $color,
    Num()            $dx,
    Num()            $dy,
    Num()            $spread,
    Num()            $blur_radius
  ) {

    my gfloat ($ddx, $ddy, $s, $br) = ($dx, $dy, $spread, $blur_radius);

    my $gsk-outset-shadow-node = gsk_outset_shadow_node_new(
      $outline,
      $color,
      $ddx,
      $ddy,
      $s,
      $br
    );

    $gsk-outset-shadow-node ?? self.bless( :$gsk-outset-shadow-node ) !! Nil;
  }

  method get_blur_radius
    is also<
      get-blur-radius
      blur_radius
      blur-radius
    >
  {
    gsk_outset_shadow_node_get_blur_radius($!gsk-osn);
  }

  method get_color ( :$raw = False )
    is also<
      get-color
      color
    >
  {
    propReturnObject(
      gsk_outset_shadow_node_get_color($!gsk-osn),
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
    gsk_outset_shadow_node_get_dx($!gsk-osn);
  }

  method get_dy
    is also<
      get-dy
      dy
    >
  {
    gsk_outset_shadow_node_get_dy($!gsk-osn);
  }

  method get_outline ( :$raw = False )
    is also<
      get-outline
      outline
    >
  {
    propReturnObject(
      gsk_outset_shadow_node_get_outline($!gsk-osn),
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
    gsk_outset_shadow_node_get_spread($!gsk-osn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_outset_shadow_node_get_type, $n, $t )
  }

}

INIT {
  my \O = GSK::Node::Shadow::Outset;
  %render-node-types<Shadow::Outset> = {
    object    => O,
    node-type => GSK_OUTSET_SHADOW_NODE,
    type      => O.get_type
  }
}
