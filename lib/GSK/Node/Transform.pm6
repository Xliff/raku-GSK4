use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskTransformNodeAncestry is export of Mu
  where GskTransformNode | GskRenderNode;

class GSK::Node::Transform:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskTransformNode $!gsk-tn is implementor;

  submethod BUILD ( :$gsk-transform-node ) {
    self.setGskTransformNode($gsk-transform-node) if $gsk-transform-node
  }

  method setGskTransformNode (GskTransformNodeAncestry $_) {
    my $to-parent;

    $!gsk-tn = do {
      when GskTransformNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskTransformNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskTransformNode
    is also<GskTransformNode>
  { $!gsk-tn }

  multi method new (GskTransformNodeAncestry $gsk-transform-node, :$ref = True) {
    return unless $gsk-transform-node;

    my $o = self.bless( :$gsk-transform-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (GskRenderNode() $child, GskTransform() $transform) {
    my $gsk-transform-node = gsk_transform_node_new($child, $transform);

    $gsk-transform-node ?? self.bless( :$gsk-transform-node ) !! Nil
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
      gsk_transform_node_get_child($!gsk-tn),
      :$raw,
      :$proper
    );
  }

  method get_transform ( :$raw = False )
    is also<
      get-transform
      transform
    >
  {
    propReturnObject(
      gsk_transform_node_get_transform($!gsk-tn),
      $raw,
      |GSK::Transform.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_transform_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::Transform;
  %render-node-types{ O.get_type } := %render-node-types<Transform> = {
    object    => O,
    node-type => GSK_TRANSFORM_NODE,
    pair      => O.getTypePair
  }
}
