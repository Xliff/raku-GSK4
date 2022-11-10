use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskDebugNodeAncestry is export of Mu
  where GskDebugNode | GskRenderNode;

class GSK::Node::Debug:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskDebugNode $!gsk-dn is implementor;

  submethod BUILD ( :$gsk-transform-node ) {
    self.setGskDebugNode($gsk-transform-node) if $gsk-transform-node
  }

  method setGskDebugNode (GskDebugNodeAncestry $_) {
    my $to-parent;

    $!gsk-dn = do {
      when GskDebugNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskDebugNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskDebugNode
    is also<GskDebugNode>
  { $!gsk-dn }

  multi method new (GskDebugNodeAncestry $gsk-transform-node, :$ref = True) {
    return unless $gsk-transform-node;

    my $o = self.bless( :$gsk-transform-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (GskRenderNode() $child, Str() $message) {
    my $gsk-render-node = gsk_debug_node_new($child, $message);

    $gsk-render-node ?? self.bless( :$gsk-render-node ) !! Nil;
  }

  method get_child ( :$raw = False )
    is also<
      get-child
      child
    >
  {
    propReturnObject(
      gsk_debug_node_get_child($!gsk-dn),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_message
    is also<
      get-message
      message
    >
  {
    gsk_debug_node_get_message($!gsk-dn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_debug_node_get_type, $n, $t )
  }

}

INIT {
  my \O = GSK::Node::Debug;
  %render-node-types<Debug> = {
    object => O,
    type   => O.get_type
  }
}
