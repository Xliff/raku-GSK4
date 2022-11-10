use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskRepeatNodeAncestry is export of Mu
  where GskRepeatNode | GskRenderNode;

class GSK::Node::Repeat:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskRepeatNode $!gsk-rn is implementor;

  submethod BUILD ( :$gsk-repeat-node ) {
    self.setGskRepeatNode($gsk-repeat-node) if $gsk-repeat-node
  }

  method setGskRepeatNode (GskRepeatNodeAncestry $_) {
    my $to-parent;

    $!gsk-rn = do {
      when GskRepeatNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskRepeatNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskRepeatNode
    is also<GskRepeatNode>
  { $!gsk-rn }

  multi method new (GskRepeatNodeAncestry $gsk-repeat-node, :$ref = True) {
    return unless $gsk-repeat-node;

    my $o = self.bless( :$gsk-repeat-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    graphene_rect_t() $bounds,
    GskRenderNode()   $child,
    graphene_rect_t() $child_bounds
  ) {
    my $gsk-repeat-node = gsk_repeat_node_new($bounds, $child, $child_bounds);

    $gsk-repeat-node ?? self.bless( :$gsk-repeat-node ) !! Nil
  }

  method get_child ( :$raw = False )
    is also<
      get-child
      child
    >
  {
    propReturnObject(
      gsk_repeat_node_get_child($!gsk-rn),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_child_bounds ( :$raw = False )
    is also<
      get-child-bounds
      child_bounds
      child-bounds
    >
  {
    propReturnObject(
      gsk_repeat_node_get_child_bounds($!gsk-rn),
      $raw,
      |Graphene::Rect.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_repeat_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::Repeat;
  %render-node-types<Repeat> = {
    object => O,
    type   => O.get_type
  }
}
