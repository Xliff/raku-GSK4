use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskOpacityNodeAncestry is export of Mu
  where GskOpacityNode | GskRenderNode;

class GSK::Node::Opacity:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskOpacityNode $!gsk-on is implementor;

  submethod BUILD ( :$gsk-opacity-node ) {
    self.setGskOpacityNode($gsk-opacity-node) if $gsk-opacity-node
  }

  method setGskOpacityNode (GskOpacityNodeAncestry $_) {
    my $to-parent;

    $!gsk-on = do {
      when GskOpacityNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskOpacityNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskOpacityNode
    is also<GskOpacityNode>
  { $!gsk-on }

  multi method new (GskOpacityNodeAncestry $gsk-opacity-node, :$ref = True) {
    return unless $gsk-opacity-node;

    my $o = self.bless( :$gsk-opacity-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (GskRenderNode() $child, Num() $opacity) {
    my gfloat $o = $opacity;

    my $gsk-opacity-node = gsk_opacity_node_new($child, $opacity);

    $gsk-opacity-node ?? self.bless( :$gsk-opacity-node ) !! Nil;
  }

  method get_child ( :$raw = False )
    is also<
      get-child
      child
    >
  {
    propReturnObject(
      gsk_opacity_node_get_child($!gsk-on),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_opacity
    is also<
      get-opacity
      opacity
    >
  {
    gsk_opacity_node_get_opacity($!gsk-on);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_opacity_node_get_type, $n, $t );
  }

}
